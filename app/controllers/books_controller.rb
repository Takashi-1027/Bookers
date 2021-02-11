class BooksController < ApplicationController
  # topページ
  def top
  end

  def new
  end


  # Bookersのページ
  def index
    @books = Book.all
    @book = Book.new
  end


 # データを新規登録(保存処理)するためのAction
  def create
    # １. データを新規登録するためのインスタンス作成
    @book = Book.new(book_params)
    # ２. データをデータベースに保存するためのsaveメソッド実行
    if @book.save
      flash[:notice] = "Book was successfully created."
      redirect_to book_path(@book)
    else
      @books = Book.all
      render :index
    end
  end

  # データを閲覧する画面を表示するためのAction
  def show
  	@book = Book.find(params[:id])
  end
  # データを更新する画面を表示するためのAction
  def edit
  	@book = Book.find(params[:id])
  end
  # データを更新するためのAction
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
    flash[:notice] = 'Book was successfully updated.'
    redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  # データを削除するためのAction
  def destroy
    book = Book.find(params[:id])
    if book.destroy
      redirect_to books_path, notice: "Book was successfully destroyed."    #flash[:destroy] = 'Book was successfully destroyed.'
    end                                                                     #redirect_to books_path
  end

private
  def book_params
    params.require(:book).permit(:title, :body)
  end
end