# frozen_string_literal: true
module Admin
  class BooksController < ApplicationController
    before_action :authenticate_user!
    before_action :set_book, only: %i[edit update destory]
    def index
      @books = Book.all
    end

    def new
      @book = Book.new
    end

    def create
      @book = Book.new(book_params)
      @book.user = current_user

      if @book.save
        redirect_to admin_books_path, notice: '新增成功'
      else
        render :new
      end
    end

    def edit; end

    def update
      if @book.update(book_params)
        redirect_to admin_books_path, notice: '更新成功'
      else
        render :edit
      end
    end

    def destroy
      @book.destroy
      redirect_to admin_books_path, notice: '刪除成功'
    end

    private

    def book_params
      params.require(:book).permit(:name, :description, :price, :user_id)
    end

    def set_book
      @book = Book.find(params[:id])
    end
  end
end
