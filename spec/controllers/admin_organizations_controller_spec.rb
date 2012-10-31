require 'spec_helper'

describe Admin::OrganizationsController do
    render_views

    before(:each) do
        @organization = FactoryGirl.create(:organization)
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
            get :edit, :id => @organization
            assert_redirected_to new_user_session_path
        end

        it "should not get show" do
            get :show, :id => @organization
            assert_redirected_to new_user_session_path
        end

        it "should not get destroy" do
            delete :destroy, :organizations => [@organization.id]
            assert_redirected_to new_user_session_path
        end
    end

    describe "if user is authenticated" do
        before(:each) do
            @user = FactoryGirl.create(:user)
            @user.confirm!
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
            get :edit, :id => @organization
            assert_redirected_to new_user_session_path
        end

        it "should not get show" do
            get :show, :id => @organization
            assert_redirected_to new_user_session_path
        end

        it "should not get destroy" do
            delete :destroy, :organizations => [@organization.id]
            assert_redirected_to new_user_session_path
        end
    end

    describe "if user is admin" do
        before(:each) do
            @admin = FactoryGirl.create(:admin)
            @admin.confirm!
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
            get :show, :id => @organization
            response.should be_success
        end

        it "should create an organization" do
            get :create, :organization => FactoryGirl.attributes_for(:organization)
            Organization.all.count.should == 2
        end

        it "should destroy an organization" do
            delete :destroy, :organizations => [@organization.id]
            Organization.all.count.should == 0
        end

        it "should get edit" do
            get :edit, :id => @organization
            response.should be_success
        end

        it "should update an organization" do
            put :update, :id => @organization
            @organization.update_attributes(:name => "New name")
            Organization.last.name.should eq("New name")
        end
    end

end
