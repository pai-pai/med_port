require 'spec_helper'
require "cancan/matchers"

describe "pages/home.html.erb" do
    describe "if user is authenticated" do
        before(:each) do
            @request.env["devise.mapping"] = Devise.mappings[:user]
            @user = FactoryGirl.create(:user)
            @user.confirm!
            sign_in @user
        end

        it "should not contain sign up link" do
            render :partial => "shared/top_nav"
            rendered.should_not have_link(t('devise.actions.sign_up'))
        end

        it "should contain link to administration's panel" do
            render :partial => "shared/top_nav"
            rendered.should_not have_link(t('devise.actions.admin_panel'))
        end
    end

    describe "if user is admin" do
        before(:each) do
            @request.env["devise.mapping"] = Devise.mappings[:admin]
            @admin = FactoryGirl.create(:admin)
            @admin.confirm!
            sign_in @admin
        end

        it "should contain link to administration's panel" do
            render :partial => "shared/top_nav"
            rendered.should have_link(t('devise.actions.admin_panel'))
        end
    end
end
