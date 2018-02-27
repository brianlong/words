require 'test_helper'

class LetterIndexTest < ActiveSupport::TestCase
  test 'find_words' do
    assert_equal ['test'], LetterIndex.find_words(1 => 't', 2 => 'e')
    assert_equal ['example'], LetterIndex.find_words(1 => 'e', 2 => 'x')
    assert_equal [], LetterIndex.find_words(1 => 'b', 2 => 'a', 3 => 'd')
    assert_equal [], LetterIndex.find_words
    assert_equal [], LetterIndex.find_words(x: 'y', 'z' => 'z')
  end
end
