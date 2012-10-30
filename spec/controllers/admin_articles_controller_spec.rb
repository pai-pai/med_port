require 'spec_helper'

describe Admin::ArticlesController do
    render_views

    before(:each) do
        @article = FactoryGirl.create(:article)
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
            get :edit, :id => @article
            assert_redirected_to new_user_session_path
        end

        it "should not get show" do
            get :show, :id => @article
            assert_redirected_to new_user_session_path
        end

        it "should not get destroy" do
            delete :destroy, :articles => [@article.id]
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
            get :edit, :id => @article
            assert_redirected_to new_user_session_path
        end

        it "should not get show" do
            get :show, :id => @article
            assert_redirected_to new_user_session_path
        end

        it "should not get destroy" do
            delete :destroy, :articles => [@article.id]
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
            get :show, :id => @article
            response.should be_success
        end

        it "should create an article" do
            get :create, :article => FactoryGirl.attributes_for(:article)
            Article.all.count.should == 2
        end

        it "should destroy an article" do
            delete :destroy, :articles => [@article.id]
            Article.all.count.should == 0
        end

        it "should get edit" do
            get :edit, :id => @article
            response.should be_success
        end

        it "should update an article" do
            put :update, :id => @article
            @article.update_attributes(:name => "New name")
            Article.last.name.should eq("New name")
        end
    end
end
