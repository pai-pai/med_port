class Healthcat < ActiveRecord::Base
    attr_accessible :name, :description, :parent_healthcat_id, :gender

    cattr_accessor :genders do
        [ [ I18n.t('shared.genders.male'), "male" ], [ I18n.t('shared.genders.female'), "female" ] ]
    end

    scope :may_be_a_parent, lambda { where('parent_healthcat_id IS ?', nil).order(:name) }

    validates_presence_of :name

    def parent_healthcat
        self.class.find_by_id(parent_healthcat_id)
    end

    def child_healthcats
        self.class.find_all_by_parent_healthcat_id(id)
    end
end
