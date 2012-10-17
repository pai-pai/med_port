require 'spec_helper'

describe Admin::TagsController do
    render_views

    before(:each) do
        @tag = FactoryGirl.create(:tag)
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
            get :edit, :id => @tag
            assert_redirected_to new_user_session_path
        end

        it "should not get show" do
            get :show, :id => @tag
            assert_redirected_to new_user_session_path
        end

        it "should not get destroy" do
            delete :destroy, :tags => [@tag.id]
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
            get :edit, :id => @tag
            assert_redirected_to new_user_session_path
        end

        it "should not get show" do
            get :show, :id => @tag
            assert_redirected_to new_user_session_path
        end

        it "should not get destroy" do
            delete :destroy, :tags => [@tag.id]
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
            get :show, :id => @tag
            response.should be_success
        end

        it "should create an tag" do
            get :create, :tag => FactoryGirl.attributes_for(:tag)
            Tag.all.count.should == 2
        end

        it "should destroy an tag" do
            delete :destroy, :tags => [@tag.id]
            Tag.all.count.should == 0
        end

        it "should get edit" do
            get :edit, :id => @tag
            response.should be_success
        end

        it "should update an tag" do
            put :update, :id => @tag
            @tag.update_attributes(:name => "New name")
            Tag.last.name.should eq("New name")
        end
    end
end
