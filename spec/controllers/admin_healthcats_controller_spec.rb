require 'spec_helper'

describe Admin::HealthcatsController do
    render_views

    before(:each) do
        @healthcat = FactoryGirl.create(:healthcat)
    end

    describe "if user is not authenticated" do
        it "should not get index" do
            get :index
            assert_redirected_to new_user_session_path
        end

        it "should not get new" do
            get :new
            assert_redirected_to new_user_session_path
        end

        it "should not get edit" do
            get :edit, :id => @healthcat
            assert_redirected_to new_user_session_path
        end

        it "should not get show" do
            get :show, :id => @healthcat
            assert_redirected_to new_user_session_path
        end

        it "should not get destroy" do
            delete :destroy, :cats => [@healthcat.id]
            assert_redirected_to new_user_session_path
        end 
    end

    describe "if user is authenticated" do
        before(:each) do
            @user = FactoryGirl.create(:user)
            sign_in @user
        end

        it "should not get index" do
            get :index
            assert_redirected_to new_user_session_path
        end

        it "should not get new" do
            get :new
            assert_redirected_to new_user_session_path
        end

        it "should not get edit" do
            get :edit, :id => @healthcat
            assert_redirected_to new_user_session_path
        end

        it "should not get show" do
            get :show, :id => @healthcat
            assert_redirected_to new_user_session_path
        end

        it "should not get destroy" do
            delete :destroy, :cats => [@healthcat.id]
            assert_redirected_to new_user_session_path
        end 
    end

    describe "if user is admin" do
        before(:each) do
            @admin = FactoryGirl.create(:admin)
            sign_in @admin
        end

        it "should get index" do
            get :index
            response.should be_success
        end

        it "should get new" do
            get :new
            response.should be_success
        end

        it "should get show" do
            get :show, :id => @healthcat
            response.should be_success
        end

        it "should create healthcat" do
            get :create, :healthcat => FactoryGirl.attributes_for(:healthcat)
            Healthcat.all.count.should == 2
        end

        it "should create new subcat" do
            get :create, :healthcat => FactoryGirl.attributes_for(:healthcat).merge(:gender => "", :parent_healthcat_id => @healthcat.id)
            Healthcat.last.parent_healthcat_id.should eq(@healthcat.id)
            Healthcat.last.gender.should eq(@healthcat.gender)
        end

        it "should destroy healthcat" do
            delete :destroy, :cats => [@healthcat.id]
            Healthcat.all.count.should == 0
        end

        it "should destroy cat and subcats" do
            Healthcat.create!(FactoryGirl.attributes_for(:healthcat).merge(:gender => "", :parent_healthcat_id => @healthcat.id))
            delete :destroy, :cats => [@healthcat.id]
            Healthcat.count.should == 0
        end

        it "should get edit" do
            get :edit, :id => @healthcat
            response.should be_success
        end

        it "should update healthcat" do
            put :update, :id => @healthcat
            @healthcat.update_attributes(:name => "New name")
            Healthcat.last.name.should eq("New name")
        end

        it "should get move" do
            post :move, :cats => [@healthcat.id]
            response.should be_success
        end

        it "should destroy healthcat if pass delete_button" do
            post :move, :delete_button => true, :cats => [@healthcat.id]
            Healthcat.all.count.should == 0
        end

        it "should move healthcat to childs of another healthcat" do
            post :move, :move_button => true, :cats => [FactoryGirl.create(:healthcat).id], :parent_cat => @healthcat.id
            Healthcat.last.parent_healthcat_id.should eq(@healthcat.id)
        end

        it "should contain childs of moved ex-parent in new parent" do
            @child = Healthcat.create!(FactoryGirl.attributes_for(:healthcat).merge(:gender => "", :parent_healthcat_id => @healthcat.id))
            @new_parent = FactoryGirl.create(:healthcat)
            post :move, :move_button => true, :cats => [@healthcat.id], :parent_cat => @new_parent.id
            @new_parent.child_healthcats.count.should == 2
        end

        it "should not contain childs in ex-parent" do
            @child = Healthcat.create!(FactoryGirl.attributes_for(:healthcat).merge(:gender => "", :parent_healthcat_id => @healthcat.id))
            @new_parent = FactoryGirl.create(:healthcat)
            post :move, :move_button => true, :cats => [@healthcat.id], :parent_cat => @new_parent.id
            @healthcat.child_healthcats.count.should == 0
        end
    end
end
