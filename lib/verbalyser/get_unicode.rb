def get_unicode(char)
  accented_vowels = %w[aãàáąą̃ą̀ą́eẽeẽèéęę̃ę̀ę́ėė̃ė̀ė́ė́iĩìíį̃į̀įįoõòóyỹỳýũùúuųų̃ų̀ų́ūū̃ū̀ū́]
  puts accented_vowels
  (0..55295).each do |pos|
  # (0..109976).each do |pos|
    chr = ""
    chr << pos
    if chr == char
      puts "This is the unicode of #{char}: #{pos.to_s(16)}"
    end
  end
end

accented_vowels = %w[aãàáąą̃ą̀ą́eẽeẽèéęę̃ę̀ę́ėė̃ė̀ė́ė́iĩìíį̃į̀įįoõòóyỹỳýũùúuųų̃ų̀ų́ūū̃ū̀ū́]

puts accented_vowels.class

split_accented_vowels = accented_vowels.to_s.split("")

split_accented_vowels.each do |letter|
  puts "This is the letter: #{letter}"
  get_unicode(letter)
end

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

# get_unicode("e")
# get_unicode("ę")
