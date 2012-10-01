class Healthcat < ActiveRecord::Base
    attr_accessible :name, :description, :parent_healthcat_id, :gender

    cattr_accessor :genders do
        [ [ I18n.t('shared.genders.male'), "male" ], [ I18n.t('shared.genders.female'), "female" ] ]
    end

    scope :may_be_a_parent, lambda { where('parent_healthcat_id IS ?', nil).order(:name) }

    validates_presence_of :name
end
