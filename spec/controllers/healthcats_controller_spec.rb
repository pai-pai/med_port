require 'spec_helper'

describe HealthcatsController do
    render_views

    before(:each) do
        @user = FactoryGirl.create(:user)
        @user.confirm!
        @healthcat = FactoryGirl.build(:healthcat)
    end

    it "should get index" do
        get :index
        response.should be_success
    end

    it "assign all healthcats to @healthcats" do
        healthcat = FactoryGirl.create(:healthcat)
        get :index
        assigns(:healthcats).should eq([healthcat])
    end

    it "should get show" do
        @healthcat.save
        get :show, :id => @healthcat
        response.should be_success
    end

    describe "if user is not authenticated" do
        it "should not get new" do
            get :new
            assert_redirected_to new_user_session_path
        end

        it "should not get edit" do
            @healthcat.save
            get :edit, :id => @healthcat
            assert_redirected_to new_user_session_path
        end

        it "should not get destroy" do
            @healthcat.save
            get :destroy, :id => @healthcat
            assert_redirected_to new_user_session_path
        end
    end

    describe "if user is authenticated" do
        before(:each) do
            sign_in @user
        end

        it "should not get new" do
            get :new
            assert_redirected_to root_path
        end

        it "should not get edit" do
            @healthcat.save
            get :edit, :id => @healthcat
            assert_redirected_to root_path
        end

        it "should not get destroy" do
            @healthcat.save
            get :destroy, :id => @healthcat
            assert_redirected_to root_path
        end
    end

    describe "if user is admin" do
        before(:each) do
            @admin = FactoryGirl.create(:admin)
            @admin.confirm!
            sign_in @admin
        end

        it "should not get new" do
            get :new
            response.should be_success
        end

        it "should create new healthcat" do
            get :create, :healthcat => FactoryGirl.attributes_for(:healthcat)
            Healthcat.all.count.to_i.should == 1
        end

        it "should not get edit" do
            @healthcat.save
            get :edit, :id => @healthcat
            response.should be_success
        end

        it "should get destroy" do
            @healthcat.save
            expect {
				delete :destroy, {:id => @healthcat.id}
            }.to change(Healthcat, :count).by(-1)
        end

        it "should create new subcat" do
            @healthcat.save
            @healthcat = Healthcat.last
            Healthcat.create!(FactoryGirl.attributes_for(:healthcat).merge(:gender => "", :parent_id => @healthcat.id))
            Healthcat.last.parent_id.should eq(@healthcat.id)
            Healthcat.last.gender.should eq(@healthcat.gender)
        end

        it "should destroy cat and subcats" do
            @healthcat.save
            @healthcat = Healthcat.last
            Healthcat.create!(FactoryGirl.attributes_for(:healthcat).merge(:gender => "", :parent_id => @healthcat.id))
            delete :destroy, {:id => @healthcat.id}
            Healthcat.count.should == 0
        end
    end
end
