require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = Array.new(7) { ('a'..'z').to_a.sample }
    @letters.shuffle!
  end

  def score
    @word = params[:word]
    @letters = params[:letters]
    # @word length = 7, @word contain only letters from the array @letters, and its an english word
    @included = included?(@letters, @word)
    @english_word = english_word?(@word)
    @length = length?(@letters, @word)
  end

private

  def included?(letters, word)
    @word.chars.all?  { |letter| @word.count(letter) <= @letters.count(letter) }
  end

  def length?(letters, word)
    word.length == letters.length
  end

  def english_word?(word)
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json["found"]
  end


end
