class Tag < ActiveRecord::Base
    attr_accessible :name

    has_many :taggings, :dependent => :destroy
    has_many :articles, :through => :taggings

    validates_prescence_of :name
    validates_uniqueness_of :name

    def self.with_names(names)
        names.map do |name|
            Tag.find_or_create_by_name(name)
        end
    end
end
