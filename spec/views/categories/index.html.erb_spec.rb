require 'spec_helper'

describe "categories/index" do
    it "should contain all categories" do
        assign(:categories, [stub_model(Category), stub_model(Category), stub_model(Category)])
        render
        rendered.should have_selector('.cat_column', :count => 3)
    end
end
