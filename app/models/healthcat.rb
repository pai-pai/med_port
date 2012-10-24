class Healthcat < ActiveRecord::Base
    include Translator

    attr_accessible :name, :translated_name, :description, :parent_id, :gender, :bodypart_names

    cattr_accessor :genders do
        [ [ I18n.t('shared.genders.male'), "male" ], [ I18n.t('shared.genders.female'), "female" ] ]
    end

    has_many :subcats, :class_name => "Healthcat"
    belongs_to :parent, :class_name => "Healthcat", :foreign_key => "parent_id"
    has_many :placings, :dependent => :destroy
    has_many :bodyparts, :through => :placings
    has_many :articles, :dependent => :nullify

    scope :all_parents, lambda { where('parent_id IS ?', nil).order(:name) }
    scope :all_subcats, lambda { where('parent_id IS NOT ?', nil).order(:name) }

    validates_presence_of :name

    def count_of_articles
        count = 0
        if not self.subcat.blank?
            self.subcat.each do |child|
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
            self.gender = self.parent.gender if not self.parent_id.blank?
        end

        def set_translate_name
            self.translated_name = translate(self.name)
        end
end
