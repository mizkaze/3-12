class BooksController < ApplicationController
  
  def index
    @books_open = Book.all
    @book = Book.new
  end
  
  def create
    # 「book」はローカル変数
    # →変更：ローカル変数はviewへの受け渡しが出来ないから、インスタンス変数に書き換える！
    # Bookモデルを新規作成(データを絞り込んで受信)
    @book = Book.new(book_params)
    # フォームが空か確認するのも(book_params)の機能
    
    # 変更をデータベースに保存
    if @book.save
      # フラッシュメッセージ
      flash[:success] = "Book was successfully updated."
      # 投稿内容詳細ページに遷移
      redirect_to book_path(@book.id)
    else
      @books_open = Book.all
      # 駄目だった場合は「このページ」と指定↑
      render action: :index
      # 新規作成ページのviewを出す
    end
    
  end

  def show
    @book_find = Book.find(params[:id])
  end

  def edit
    @book_find = Book.find(params[:id])
    # 編集したいデータを選ぶ
  end
  
  def update
    @book_find = Book.find(params[:id])
    
    if @book_find.update(book_params)
      flash[:success] = "Book was successfully updated."
      redirect_to book_path(@book_find.id)
    else
      @books_find = Book.all
      render action: :edit
    end
    
  end
  
  def destroy
    book_find = Book.find(params[:id])
    book_find.destroy
    redirect_to '/books'
  end
  
  private
  
  # ストロングパラメータ
  def book_params
    params.require(:book).permit(:title, :body)
  end
  
end
