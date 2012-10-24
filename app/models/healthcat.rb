class Healthcat < ActiveRecord::Base
    include Translator

    attr_accessible :name, :translated_name, :description, :parent_healthcat_id, :gender, :bodypart_names

    cattr_accessor :genders do
        [ [ I18n.t('shared.genders.male'), "male" ], [ I18n.t('shared.genders.female'), "female" ] ]
    end

    has_many :placings, :dependent => :destroy
    has_many :bodyparts, :through => :placings
    has_many :articles, :dependent => :nullify

    scope :may_be_a_parent, lambda { where('parent_healthcat_id IS ?', nil).order(:name) }
    scope :children, lambda { where('parent_healthcat_id IS NOT ?', nil).order(:name) }

    validates_presence_of :name

    def parent_healthcat
        self.class.find_by_id(parent_healthcat_id)
    end

    def child_healthcats
        self.class.where('parent_healthcat_id = ?', id).order(:name)
    end

    def count_of_articles
        count = 0
        if not self.child_healthcats.blank?
            self.child_healthcats.each do |child|
                count = count + child.articles.count if not child.articles.blank?
            end
        else
            count = self.articles.count if not self.articles.blank?
        end
        return count
    end

    def to_param
        "#{id}-#{translated_name}"
    end

    def bodypart_names=(names)
        names_line = "".encode("cp1251") + names
        names_line = names_line.gsub(/^(, *)+/, "")
        self.bodyparts = Bodypart.with_names(names_line.split(%r{, +}))
    end

    def bodypart_names
        bodyparts.map(&:name).join(', ')
    end

    before_save :set_childs_gender, :set_translate_name

    private
        def set_childs_gender
            self.gender = self.parent_healthcat.gender if not self.parent_healthcat_id.blank?
        end

        def set_translate_name
            self.translated_name = translate(self.name)
        end
end
