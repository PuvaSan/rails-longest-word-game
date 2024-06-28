require 'open-uri'

class GamesController < ApplicationController
  def new
    # The new action will be used to display a new random grid and a form.
    @letters = []

    10.times do
      @letters << ('A'..'Z').to_a.sample
    end
  end

  def score
    # The form will be submitted (with POST) to the score action.
    url = 'https://dictionary.lewagon.com/'
    guess = params[:guess].upcase
    original = params[:letters]
    dictionary = JSON.parse(URI.open(url + guess).read)
    result = dictionary['found']

    cross_ref = original.split('') & guess.split('')
    length_check = cross_ref.length == guess.split('').length

    if length_check
      if result
        @display = "Congratulations! #{guess} is a valid English word!"
      else
        @display = "Sorry but #{guess} does not seem to be a valid English word..."
      end
    else
      @display = "Sorry but #{guess} can't be built out of #{original}"
    end
  end
end
