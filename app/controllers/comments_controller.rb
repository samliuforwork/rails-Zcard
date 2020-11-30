class CommentsController < ApplicationController
    before_action :session_required
    before_action :find_post, only: [:create]
  
    def create
      @comment = current_user.comments.new(comment_params)
      @comment.post = @post
  
      if @comment.save
        redirect_to @post, notice: '新增留言成功'
      else
        render 'posts/show'
      end
    end

    def destroy
      # 下面這句翻譯，select * from comments where id= ? and user_id = ?，從使用者的角度來資料      
      comment = current_user.comments.find(params[:id])
      #下面這句翻譯，是從comment裡面撈資料，有可能砍到別人的
      # comment = Comment.find(params[:id])
      comment.destroy
      redirect_to comment.post, notice: '留言已經刪除'
    end
  
    private
    def find_post
      @post = Post.find(params[:post_id])
    end
  
    def comment_params
      params.require(:comment).permit(:content)
    end
  end