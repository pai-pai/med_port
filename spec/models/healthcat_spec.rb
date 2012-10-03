require 'spec_helper'

describe Healthcat do
    it "should require a healthcat's name" do
        @attrs = FactoryGirl.attributes_for(:healthcat)
        Healthcat.new(@attrs.merge(:name => '')).should_not be_valid
    end

    it "should save category with valid translated_name" do
        @healthcat = FactoryGirl.create(:healthcat, name: 'Any word character (letter, number, underscore)')
        @healthcat.save!
        @healthcat.translated_name.should == 'any-word-character'
    end
end
