class Bodypart < ActiveRecord::Base
    attr_accessible :name

    has_many :placings, :dependent => :destroy
    has_many :healthcats, :through => :placings

    validates_presence_of :name
    validates_uniqueness_of :name
end
