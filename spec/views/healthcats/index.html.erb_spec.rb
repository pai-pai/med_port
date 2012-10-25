require 'spec_helper'

describe "healthcats/index.html.erb" do
    describe "if user is authenticated" do
        before(:each) do
            @request.env["devise.mapping"] = Devise.mappings[:user]
            @user = FactoryGirl.create(:user)
            @user.confirm!
            sign_in @user
        end

        it "should not contain add new healthcat link" do
            render
            rendered.should_not have_link(t('healthcats.shared.add_new'))
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
            render
            rendered.should have_link(t('healthcats.shared.add_new'))
        end
    end
end
