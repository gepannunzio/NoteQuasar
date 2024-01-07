class HomeController < ApplicationController
    skip_before_action :protect_pages, only: [:welcome]

    def welcome
    end
  end