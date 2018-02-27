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
    # TODO: Add word length as an option to limit results based on the length
    # of the word.

    # Guards
    return [] unless letters.is_a?(Hash)
    return [] if letters.empty?

    # Initialize a variable to hold the words
    id_array = []

    # Q: Can I turn the following two steps into a recursive function?
    # 1. Process the first letter
    fl = letters.first
    # Find the Word IDs where the provided letter is in the provided position.
    select('distinct word_id').where(["position = ? AND letter = ?", fl[0], fl[1]]).each do |id|
      id_array << id.word_id
    end

    # 2. Process the rest of the letters
    letters.reject{|k,v| k == fl[0]}.each do |li|
      # Create a temp variable.
      temp_ids = []

      # Find the Word IDs where the provided letter is in the provided position.
      select('distinct word_id').where(["position = ? AND letter = ?", li[0], li[1]]).each do |id|
        temp_ids << id.word_id
      end

      # Perform an intersection of arrays to reduce the candidate set.
      id_array = id_array & temp_ids
    end

    # Guard against no matches
    return [] if id_array.empty?

    # return the result.
    Word.where("id IN (#{id_array.uniq.join(', ')})").map{ |w| w.word }
  end
end
