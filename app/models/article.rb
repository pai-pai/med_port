class Article < ActiveRecord::Base
    include Translator

    attr_accessible :body, :introduction, :name, :translated_name, :healthcat_id

    belongs_to :categorizable, polymorphic: true
    has_many :taggings, :dependent => :destroy
    has_many :tags, :through => :taggings

    validates_presence_of :name, :body
    validates_uniqueness_of :name

    def to_param
        "#{id}-#{translated_name}"
    end

    def tag_names=(names)
        names_line = "".encode("cp1251") + names
        names_line = names_line.gsub(/^(; *)+/, "")
        self.tags = Tag.with_names(names_line.split(%r{; +}))
    end

    def tag_names
        tags.map(&:name).join('; ')
    end

    before_save :set_translate_name

    private
        def set_translate_name
            self.translated_name = translate(self.name)
        end
end
