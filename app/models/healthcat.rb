class Healthcat < ActiveRecord::Base
    attr_accessible :name, :translated_name, :description, :parent_healthcat_id, :gender

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

    def to_param
        "#{id}-#{translated_name}"
    end

    before_save :set_childs_gender, :set_translate_name

    private
        def set_childs_gender
            self.gender = self.parent_healthcat.gender if not self.parent_healthcat_id.blank?
        end

        def set_translate_name
            @decoded = "".encode("cp1251") + self.name
            self.translated_name = translate(@decoded.mb_chars.downcase.gsub(/([(].*[)])/, '').gsub(/( )+/, '-').gsub(/(-)\z/, ''))
        end

        def translate(line)
            @parity_array = []
            @lat_alphabet = [ "a", "b", "v", "g", "d", "e", "e", "zh", "z", "i", "j", "k", "l", "m", "n", "o", "p", "r", "s", "t", "u", "f", "h", "ts", "ch", "sh", "sch", "", "i", "", "e", "u", "ya" ]
            ("".encode("cp1251") + I18n.t('alphabet')).each_char { |ch| @parity_array << ch }
            @ending_hash = Hash[@parity_array.zip(@lat_alphabet)]
            @new_word = ""
            line.each_char do |trans_char|
                @new_word << "-" if trans_char.eql?("-")
                @ending_hash.each do |rus_letter, lat_letter|
                    @new_word << lat_letter if trans_char.eql?(rus_letter)
                end
            end
            @new_word = line if @new_word.gsub(/(-)/, "").empty?
            @new_word
        end
end
