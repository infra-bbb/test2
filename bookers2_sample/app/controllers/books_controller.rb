class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_params_book, except: [:index, :create]

  def index
    @book = Book.new
    @books = Book.all
  end

  def show
    @new_book = Book.new
    @user = @book.user
    @comment = Comment.new
  end

  def edit
    if @book.user != current_user
      redirect_to books_path
    end
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = 'Book was successfully created!'
      redirect_to book_path(@book)
    else
      @books = Book.all
      render :index
    end
  end

  def update
    if @book.update(book_params)
      flash[:notice] = 'Book was successfully updated!'
      redirect_to book_path(@book)
    else
      render :edit
    end
  end

  def destroy
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def set_params_book
    @book = Book.find(params[:id])
  end
end
