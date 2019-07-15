$(function() {

  function buildSearchUser(user) {
    var html = `<div class="chat-group-user clearfix">
                  <p class="chat-group-user__name">${user.name}</p>
                  <div class="user-search-add chat-group-user__btn chat-group-user__btn--add" data-user-id="${user.id}" data-user-name="${user.name}">追加</div>
                </div>`
    $(".user-search-result").append(html);
  }

  function appendSearchErrMsgToHTML(msg) {
    var html = `<div class="chat-group-user clearfix">
                  <p class="chat-group-user__name">${msg}</p>
                </div>`
    $(".user-search-result").append(html);
  }

  function buildGroupMenber(user)
  {
    var html = `<div class='chat-group-user clearfix js-chat-member' id='chat-group-user-8'>
                  <input name='group[user_ids][]' type='hidden' value='${user.id}'>
                  <p class='chat-group-user__name'>${user.name}</p>
                  <div class='user-search-remove chat-group-user__btn chat-group-user__btn--remove js-remove-btn'>削除</div>
                </div>`
    $(".group-member").append(html);
  }

  $(document).on('turbolinks:load', function() {
    $("#user-search-field").on("keyup", function() {
      var input = $("#user-search-field").val();

      $.ajax({
        type: "get",
        url: "/users",
        data: { keyword: input },
        dataType: "json"
      })
      .done(function(users) {
        $(".user-search-result").empty();
        if (users.length !== 0) {
          users.forEach(function(user){
            buildSearchUser(user);
          });
        }
        else {
          appendSearchErrMsgToHTML("一致するユーザーはありません");
        }
      })
      .fail(function() {
        alert("ユーザー検索に失敗しました");
      });
    });

    $(".user-search-result").on("click",".chat-group-user__btn.chat-group-user__btn--add",function() {
      //追加ボタンの情報を取得
      var user = { "id" : $(this).attr("data-user-id"),
                   "name" : $(this).attr("data-user-name") };
      //追加したデータをチャットメンバー一覧に追加
      buildGroupMenber(user);
      //クリックしたチャットメンバーを検索結果から消去
      $(this).parent().remove();
    });

    $(".group-member").on("click",".chat-group-user__btn.user-search-remove",function() {
      //クリックしたチャットメンバーをグループ一覧から消去
      $(this).parent().remove();
    });

  });
})