class Bodypart < ActiveRecord::Base
    attr_accessible :name

    has_many :placings, :dependent => :destroy
    has_many :healthcats, :through => :placings

    validates_presence_of :name
    validates_uniqueness_of :name

    def self.with_names(names)
        names.map do |name|
            Bodypart.find_by_name(name)
        end
    end
end
