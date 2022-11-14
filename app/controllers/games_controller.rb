require 'json'
require "open-uri"

class GamesController < ApplicationController
  # The new action will be used
  # to display a new random grid and a form.
  # The form will be submitted (with POST) to the score action.
  def new
    # 10 random letters
    array = ('a'..'z').to_a
    @letters = (0..9).to_a.map { array[rand(0..25)] }
  end

  # To display the score.
  def score
    # raise <!-- breaks the code -->
    # Get the word from user
    @word = params[:word].capitalize

    # Score scenarios
    # 1- The word can’t be built out of the original grid
    # 2- The word is valid according to the grid, but is not a valid English word
    # 3- The word is valid according to the grid and is an English word

    @grid = params[:grid].split(" ") # convets grid from string to array

    @grid.map { |letter| @word.include?(letter) }




    for number in (0..@grid.length) do
      if @word.include?("#{@grid[number]}")
        @message = english_word?
      else
        @message = "Sorry but #{@word} can't be buid out of #{@grid}"
      end
    end

    # Validate the word using given API
    # @valid_word = validation(@word)["found"]
    # case @valid_word
    # when false
    #   @message = "Sorry but #{@word} does not seem to be a valid English word"
    # when true
    #   @message = "Congratulations! #{@word} is a valid English word!"
    # end
  end

  private

  def validation(attempt)
    url = "https://wagon-dictionary.herokuapp.com/#{attempt}"
    lewagon_serialized = URI.open(url).read
    return JSON.parse(lewagon_serialized) #API hash
  end

  def english_word?
    @valid_word = validation(@word)["found"]
    case @valid_word
    when false
      "Sorry but #{@word} does not seem to be a valid English word"
    when true
      "Congratulations! #{@word} is a valid English word!"
    end
  end
end
