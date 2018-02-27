class LetterIndex < ApplicationRecord
  belongs_to :word

  # self.find_words will accept a Hash like position_integer => 'Letter' and
  # return an Array words with those letters in the indicated positions
  #
  # * Options:
  #   - integer => 'letter'. e.g. 1 => 't', 2 => 'e', 3 => 's', 4 => 't'
  # * Returns:
  #   - An Array of words. e.g. ['test']
  # * Examples:
  #     LetterIndex.find_words(1 => 't', 2 => 'e') => ['test', 'tent']
  def self.find_words(letters = {})
    # Guards
    return [] unless letters.is_a?(Hash)
    return [] if letters.empty?

    # Initialize a variable to hold the words
    word_array = []

    # Process the first letter
    fl = letters.first
    where(["position = ? AND letter = ?", fl[0], fl[1]]).each do |li|
      word_array << li.word.word
    end

    # Process the rest of the letters
    letters.reject{|k,v| k == fl[0]}.each do |li|
      temp_words = []
      where(["position = ? AND letter = ?", fl[0], fl[1]]).each do |li|
        temp_words << li.word.word
      end
      # Perform an intersection of two arrays
      word_array = word_array & temp_words
    end
    # return the result.
    word_array
  end
end
