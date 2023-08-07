require 'open-uri'
require 'json'

class GamesController < ApplicationController

  def new
    @letters = []
    @letters << ('a'..'z').to_a.sample while @letters.size < 10
  end

  def score
    # raise
    @attempt = params[:attempt]
    @letters = params[:letters]

    @word_in_letters = word_in_letters?(@attempt, @letters)
    @english_word = english_word?(@attempt)
  end

  private

  def word_in_letters?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end

  def english_word?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{@attempt}"
    word_serialized = URI.open(url).read
    @word = JSON.parse(word_serialized)
    @word["found"]
  end
end
