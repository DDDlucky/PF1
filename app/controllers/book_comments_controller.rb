class BookCommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:destroy]

  def create
    @book = Book.find(params[:book_id])
    @book_comment = current_user.book_comments.new(
      book_id: params[:book_id],
      comment: params[:comment]
    )
    @book_comment.save
    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path) }
      format.js
    end
  end

  def destroy
    @book_comment = BookComment.find(params[:id])
    @book = @book_comment.book
    @book_comment.destroy
    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path) }
      format.js
    end
  end

  private

  def ensure_correct_user
    @book_comment = BookComment.find(params[:id])
    unless @book_comment.user == current_user
      redirect_to book_path(@book_comment.book)
    end
  end
end
