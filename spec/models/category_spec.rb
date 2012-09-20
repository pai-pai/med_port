require 'spec_helper'

describe Category do
    it "should require a categoty's name" do
        @attrs = FactoryGirl.attributes_for(:category)
        Category.new(@attrs.merge(:name => '')).should_not be_valid
    end
end
