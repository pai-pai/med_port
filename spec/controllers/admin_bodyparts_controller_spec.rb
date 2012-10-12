require 'spec_helper'

describe Admin::BodypartsController do
    render_views

    before(:each) do
        @bodypart = FactoryGirl.create(:bodypart)
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
            get :edit, :id => @bodypart
            assert_redirected_to new_user_session_path
        end

        it "should not get show" do
            get :show, :id => @bodypart
            assert_redirected_to new_user_session_path
        end

        it "should not get destroy" do
            delete :destroy, :parts => [@bodypart.id]
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
            get :edit, :id => @bodypart
            assert_redirected_to new_user_session_path
        end

        it "should not get show" do
            get :show, :id => @bodypart
            assert_redirected_to new_user_session_path
        end

        it "should not get destroy" do
            delete :destroy, :parts => [@bodypart.id]
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
            get :show, :id => @bodypart
            response.should be_success
        end

        it "should create bodypart" do
            get :create, :bodypart => FactoryGirl.attributes_for(:bodypart)
            Bodypart.all.count.should == 2
        end

        it "should destroy bodypart" do
            delete :destroy, :parts => [@bodypart.id]
            Bodypart.all.count.should == 0
        end

        it "should get edit" do
            get :edit, :id => @bodypart
            response.should be_success
        end

        it "should update bodypart" do
            put :update, :id => @bodypart
            @bodypart.update_attributes(:name => "New name")
            Bodypart.last.name.should eq("New name")
        end
    end
end
