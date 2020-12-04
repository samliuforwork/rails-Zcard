class PostsController < ApplicationController
    before_action :session_required, only: [:create, :edit, :update]
    before_action :set_board, only: [:new, :create]
    before_action :set_post, only: [:show]

    def show
      @comment = Comment.new
      @comments = @post.comments.order(id: :desc).includes(:user)
    end

    def new
      @post = Post.new
    end

    def create
    #   @post = Post.new(post_params)
    #   @post.board = @board
    #   @post.user = current_user

    #   @post = current_user.posts.new(post_params)
    #   @post.user = current_user

      @post = current_user.posts.new(post_params)
      @post.board = @board

      if @post.save
        # TODO: posts/123
        redirect_to @board, notice: '新增文章成功'
      else
        render :new
      end
    end

    def edit
        # @post = Post.find_by!(id: params[:id], user: current_user)
        # 下面的寫法是從使用者的文章中找出
        @post = current_user.posts.find(params[:id])
    end

    def update
        @post = current_user.posts.find(params[:id])

        if @post.update(post_params)
            redirect_to @post, notice: '文章更新成功'
        else
            render :edit
        end
    end

    def favorite
      post = Post.find(params[:id])
# 我想知道這篇文章是否在我的最愛裡面
      if current_user.favorite?
      #↓移除我的最愛
        current_user.my_favorites.destroy(post)
        render json: { status: 'remove' }
      else
        current_user.my_posts << post
        render json: { status: 'added' }
      # ↑我要把這篇加到我的最愛
      end
    end


    private
    def set_board
        @board = Board.find(params[:board_id])
    end
    def post_params
        params.require(:post).permit(:title, :content)
    end

    def set_post
        @post = Post.find(params[:id])
    end
end