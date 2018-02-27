# ENV["RAILS_ENV"] = ARGV[0].nil? ? "production" : "development"
ENV["RAILS_ENV"] = "development"
require File.expand_path('../../config/environment',  __FILE__)

# input_file = "#{Rails.root}/db/words_alpha.head.txt"
input_file = "#{Rails.root}/db/words_alpha.txt"
File.open(input_file).each_line do |line|
  # byebug
  lw = line.chomp("\r\n")
  word = Word.create(word: lw)
  1.upto(lw.length) do |i|
    word.letter_indices.create(position: i, letter: lw[i-1]) unless lw[i-1].nil?
  end
end # File.open(input_file).each_line do |line|
