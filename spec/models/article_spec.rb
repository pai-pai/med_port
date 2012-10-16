require 'spec_helper'

describe Article do
    it "should require an article's name" do
        Article.new(:name => '').should_not be_valid
    end

    it "should require unique name" do
        FactoryGirl.create(:article, :name => 'Article')
        Article.new(:name => 'Article').should_not be_valid
    end
end
