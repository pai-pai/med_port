class Organization < ActiveRecord::Base
    attr_accessible :address, :description, :name

    validates_presence_of :name, :address
end
