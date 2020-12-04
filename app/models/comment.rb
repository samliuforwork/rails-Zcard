class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :content, presence: true

  #因為我們要做假刪除，所以這裡適合放
  default_scope { where(deleted_at: nil) }

  def destroy
    update(deleted_at: Time.now)
  end
end
