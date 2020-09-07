require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    letters_array = ('A'..'Z').to_a
    @letters = 10.times.map {letters_array.sample}
  end

  def score
    @word = params[:word]

    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    api_words = open(url).read
    words = JSON.parse(api_words)

    if words['found'] == false
      @result = "Sorry but #{@word} does not seem to be a valid English word.."
    elsif has?(@word) == false
      @result = "Sorry but #{@word} can't be built with the given letters"
    else words['found'] == true
      @result = "Congratulations! #{@word} is a valid English word!"
    end

  end

  def has?(word)
    @letters = params[:letters].downcase.split("")
    word.split("").all? do |character|
      @letters.include?(character)
    end
  end
  
end
