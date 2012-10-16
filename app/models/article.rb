class Article < ActiveRecord::Base
    attr_accessible :body, :introduction, :name, :translated_name

    belongs_to :healthcat

    validates_presence_of :name
    validates_uniqueness_of :name

    before_save :set_translate_name

    private
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
