class BooksController < ApplicationController
  before_action :set_book, only: [:edit, :update, :destory]
  def index
    @books = Book.all.order(id: :desc)
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)

    if @book.save
      redirect_to books_path,notice: "新增成功"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @book.update(book_params)
      redirect_to books_path, notice: "更新成功"
    else
      render :edit 
    end
  end

  def destroy
    @book.destroy
      redirect_to books_path, notice: "刪除成功"
  end

  private

  def book_params
    params.require(:book).permit(:name, :description, :price)
  end

  def set_book
    @book = Book.find(params[:id])
  end
end
