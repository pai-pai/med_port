require 'spec_helper'

describe Organization do
    it "should require an organization's name" do
        Organization.new(:name => '', :address => 'address').should_not be_valid
    end

    it "should require an organization's address" do
        Organization.new(:name => 'name', :address => '').should_not be_valid
    end
end
