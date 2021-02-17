class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      flash[:notice] = 'Comment was successfuly created!'
      redirect_to request.referer
    else
      @book = Book.find(params[:comment][:book_id])
      @user = @book.user
      @new_book = Book.new
      render :'books/show'
    end
  end

  def destroy
    Comment.find(params[:id]).destroy
    redirect_to request.referer
  end

  def index
    redirect_to request.referer
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :user_id, :book_id)
  end
end
