require 'spec_helper'

describe Healthcat do
    it "should require a healthcat's name" do
        @attrs = FactoryGirl.attributes_for(:healthcat)
        Healthcat.new(@attrs.merge(:name => '')).should_not be_valid
    end
end
