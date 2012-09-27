class Healthcat < ActiveRecord::Base
  attr_accessible :description, :gender_id, :name, :parent_healthcat_id
end
