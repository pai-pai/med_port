require 'spec_helper'

describe Category do
    it "should require a categoty's name" do
        @attr = Factory.create(:category)
        category = Category.new(@attr.merge(:name => ''))
        category.should_not be_valid
    end
end
