# def get_unicode(char)
#   accented_vowels = %w[aãàáąą̃ą̀ą́eẽeẽèéęę̃ę̀ę́ėė̃ė̀ė́ė́iĩìíį̃į̀įįoõòóyỹỳýũùúuųų̃ų̀ų́ūū̃ū̀ū́]
#   # puts accented_vowels
#   (0..55295).each do |pos|
#   # (0..109976).each do |pos|
#     chr = ""
#     chr << pos
#     if chr == char
#       # puts "This is the unicode of #{char}: #{pos.to_s(16)}"
#       @letters_hash[char] = pos.to_s(16)
#     end
#   end
# end

@letters_hash = Hash.new

accented_vowels = %w[aãàáąą̃ą̀ą́eẽeèéęę̃ę̀ę́ėė̃ė̀ė́ė́iĩìíį̃į̀įįoõòóyỹỳýũùúuųų̃ų̀ų́ūū̃ū̀ū́]

unicode_letters = ["\u00e0"]

lithuanian_letters_with_diacritics = {
  "a"=>"\\61",
  "ã"=>"\\e3",
  "à"=>"\u00e0",
  "á"=>"\\e1",
  "ą"=>"\\105",
  "e"=>"65",
  "ẽ"=>"1ebd",
  "è"=>"\u00e8",
  "é"=>"\u00e9",
  "ę"=>"\u0119",
  "ę̀"=>"\u0119\u0300",
  "ę́"=>"\u0119\u0301",
  "ę̃"=>"\u0119\u0303",
  "ė"=>"\u0117",
  "ė̀"=>"\u0117\u0300",
  "ė́"=>"\u0117\u0301",
  "ė̃"=>"\u0117\u0303",
  "į"=>"\u012f",
  "į̀"=>"\u012f",
  "į́"=>"\u012f",
  "į̃"=>"\u012f",
  "ì"=>"\\ec",
  "í"=>"\u00ed",
  "ĩ"=>"\u0129",
  "o"=>"\\6f",
  "ò"=>"\u00f2",
  "ó"=>"\u00f3",
  "õ"=>"\u00f5",
  "u"=>"\\75",
  "ù"=>"\\00f9",
  "ú"=>"\\00fa",
  "ũ"=>"\u0169",
  "ų"=>"\\173",
  "ų̀"=>"\\173\u0300",
  "ų́"=>"\\173\u0301",
  "ų̃"=>"\\173\u0303",
  "ū"=>"\\16b",
  "ū̀"=>"\\16b\u0300",
  "ū́"=>"\\16b\u0301",
  "ū̃"=>"\\16b\u0303",
  "y"=>"\\79",
  "ỳ"=>"\u1ef3",
  "ý"=>"\u00fd",
  "ỹ"=>"\u1ef9",
  "l"=>"\\6c",
  "l̀"=>"\\6c\u0300",
  "ĺ"=>"\u013a",
  "l̃"=>"\\6c\u0303",
  "m"=>"\\6d",
  "m̀"=>"\\6d\u0300",
  "ḿ"=>"\u1e3f",
  "m̃"=>"\\6d\u0303",
  "n"=>"\\6e",
  "ǹ"=>"\u01f9",
  "ń"=>"\u0144",
  "ñ"=>"\u00f1",
  "r"=>"\\72",
  "r̀"=>"\\72\u0300",
  "ŕ"=>"\u0155",
  "r̃"=>"\\72\u0303",
}

# @infinitive_slice = @infinitive_form.removeaccents.sub("\u0301", "").sub("\u0302", "").sub("\u0303", "").sub("\u1ef9", "y").sub("ū́", "ū").sub("m̃", "m")[@matching_lemma.length..-1]
# @present3_slice = @present3.removeaccents.sub("\u0301", "").sub("\u0302", "").sub("\u0303", "").sub("\u1ef9", "y").sub("ū́", "ū").sub("m̃", "m")[@matching_lemma.length..-1]
# @past3_slice = @past3.removeaccents.sub("\u0301", "").sub("\u0302", "").sub("\u0303", "").sub("\u1ef9", "y").sub("ū́", "ū").sub("m̃", "m")[@matching_lemma.length..-1]
# @file_name = "#{@infinitive_slice}_#{@present3_slice}_#{@past3_slice}"



# puts accented_vowels.class

# split_accented_vowels = accented_vowels.to_s.split("")


# split_accented_vowels.each do |letter|
#   # puts "This is the letter: #{letter}"
#   get_unicode(letter)
# end

# puts @letters_hash

updated_letters_hash = {"["=>"5b", "\""=>"22", "a"=>"61", "ã"=>"e3", "̀"=>"300", "á"=>"e1", "ą"=>"105", "̃"=>"303", "́"=>"301", "e"=>"65", "ẽ"=>"1ebd", "ę"=>"119", "ė"=>"117", "i"=>"69", "ì"=>"ec", "į"=>"12f", "o"=>"6f", "õ"=>"f5", "ò"=>"f2", "ó"=>"f3", "y"=>"79", "ỹ"=>"1ef9", "ý"=>"fd", "u"=>"75", "ų"=>"173", "ū"=>"16b", "]"=>"5d"}

# updated_letters_hash.each do |key, code|
#   if code.include?("300") || code.include?("301") || code.include?("302") || code.include?("303")
#     puts "found standalone accent in #{code}: #{key}"
#   end
# end

# def get_character(hexnum)
#   char = ''
#   char << hexnum.to_i(16)
# end

# def get_unicode(char)
#   # puts char.to_s(16)
#   (0..109_976).each do |pos|
#     chr = ""
#     chr << pos
#     while char != chr
#     else
#       puts pos.to_s(16)# if chr == char
#     end
#   end
# end


# "ė".each_byte do |c|
#   puts c
# end
# "ė"=>"117", "i"=>"69", "ì"=>"ec", "į"=>"12f", "o"=>"6f", "õ"=>"f5", "ò"=>"f2", "ó"=>"f3", "y"=>"79", "ỹ"=>"1ef9", "ý"=>"fd", "u"=>"75", "ų"=>"173", "ū"=>"16b", "]"=>"5d"

def get_unicode(char)
  (0..55295).each do |pos|
  # (0..109976).each do |pos|
    chr = ""
    chr << pos
    if chr == char
      puts "This is the unicode of #{char}: #{pos.to_s(16)}"
    end
  end
end

get_unicode("y")
get_unicode("l")
get_unicode("m")
get_unicode("n")
get_unicode("r")
