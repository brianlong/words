require 'test_helper'

class LetterIndexTest < ActiveSupport::TestCase
  test 'find_words' do
    # The test fixtures include 'test' & 'tent'. we want to find both
    result = LetterIndex.find_words(1 => 't', 2 => 'e')
    assert result.include?('test')
    assert result.include?('tent')
    # Find only 'test'
    assert_equal ['test'], LetterIndex.find_words(1 => 't', 2 => 'e', 3 => 's')
    # Find only 'tent'
    assert_equal ['tent'], LetterIndex.find_words(1 => 't', 2 => 'e', 3 => 'n')
    # Find 'example'
    assert_equal ['example'], LetterIndex.find_words(1 => 'e', 2 => 'x')
    # The next tests should not return results
    assert_equal [], LetterIndex.find_words(1 => 'b', 2 => 'a', 3 => 'd')
    assert_equal [], LetterIndex.find_words
    assert_equal [], LetterIndex.find_words(x: 'y', 'z' => 'z')
    assert_equal [], LetterIndex.find_words(1)
    assert_equal [], LetterIndex.find_words('A')
    assert_equal [], LetterIndex.find_words([1])
  end
end
