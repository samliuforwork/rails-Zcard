document.addEventListener("DOMContentLoaded", function(){
  const favorite_btn = document.querySelector("#favorite_btn")
  if (favorite_btn) {
  favorite_btn.addEventListener('click', function(e){
  e.preventDefault()

// 我想要按下愛心的時候，印出一串東西，並從一串東西中取得id

// 打API  /送資料
//alert('1')

// 非同步處理
      const ax = require('axios')
      const token = document.querySelector('[name=csrf-token]').content
      ax.defaults.headers.common['X-CSRF-TOKEN'] = token

      const postId = e.currentTarget.dataset.id
      const icon = e.target

      ax.post(`/posts/${postId}/favorite`, {})
        .then(function(resp){
          if (resp.data.status == "added") {
            icon.classList.remove("far")
            icon.classList.add("fas")
          } else {
            icon.classList.remove("fas")
            icon.classList.add("far")
          }
        })
        .catch(function(err) {
          console.log(err);
        })
      
    })
  }

})

