require 'spec_helper'

describe CategoriesController do
    it "should get index" do
        get :index
        response.should be_success
    end

    it "assign all categories to @categories" do
        category = FactoryGirl.create(:category)
        get :index
        assigns(:categories).should eq([category])
    end

    it "should get new" do
        get :new
        response.should be_success
    end

    describe "actions with category" do
        before(:each) do
            @category = FactoryGirl.create(:category)
        end

        it "should get edit" do
            get :edit, :id => @category
            response.should be_success
        end

        it "should get show" do
            get :show, :id => @category
            response.should be_success
        end

        it "should get destroy" do
            get :destroy, :id => @category
            response.should be_success
        end
    end
end
