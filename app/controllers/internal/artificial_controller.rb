# frozen_string_literal: true

module Internal
  class ArtificialController < ApplicationController
    def index
      render 'artificial/index'
    end

    def speech_to_text
      @text_response = Ai::SpeechToText.new(audio_url: audio_params[:audio_url]).call

      respond_to do |f|
        f.html
        f.js { render 'artificial/speech_to_text' }
      end
    end

    private

    def audio_params
      params.permit(:audio_url)
    end
  end
end
