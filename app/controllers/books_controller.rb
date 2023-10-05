# frozen_string_literal: true

class BooksController < ApplicationController
  before_action :authenticate_user!

  def index
    @books = Book.all
  end
end
