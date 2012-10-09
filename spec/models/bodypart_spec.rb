require 'spec_helper'

describe Bodypart do
    it "should require a bodypart's name" do
        Bodypart.new(:name => '').should_not be_valid
    end

    it "should require unique name" do
        FactoryGirl.create(:bodypart, :name => 'part')
        Bodypart.new(:name => 'part').should_not be_valid
    end
end
