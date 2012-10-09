class Placing < ActiveRecord::Base
    belongs_to :healthcat
    belongs_to :bodypart
end
