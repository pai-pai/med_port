module Translator
    LAT_ALPHABET = [ "a", "b", "v", "g", "d", "e", "e", "zh", "z", "i", "j", "k", "l", "m", "n", "o", "p", "r", "s", "t", "u", "f", "h", "ts", "ch", "sh", "sch", "", "i", "", "e", "u", "ya" ]
    RUS_ALPHABET = I18n.t('alphabet')

    def translate(name)
        parity_array = []
        ("".encode("cp1251") + RUS_ALPHABET).each_char { |ch| parity_array << ch }
        zipped_hash = Hash[parity_array.zip(LAT_ALPHABET)]
        translated_name = ""
        line = ("".encode("cp1251") + name).mb_chars.downcase.gsub(/([(].*[)])/, '').gsub(/( )+/, '-').gsub(/(-)\z/, '')
        line.each_char do |trans_char|
            translated_name << trans_char if trans_char.eql?("-")
            zipped_hash.each do |rus_letter, lat_letter|
                translated_name << lat_letter if trans_char.eql?(rus_letter)
            end
        end
        translated_name = line if translated_name.gsub(/(-)/, "").empty?
        return translated_name
    end
end
