$(function() {

  function buildSearchUser(user) {
    var html = `<div class="chat-group-user clearfix">
                  <p class="chat-group-user__name">${user.name}</p>
                  <div class="user-search-add chat-group-user__btn chat-group-user__btn--add" data-user-id="ユーザーのid" data-user-name="ユーザー名">追加</div>
                </div>`
    $(".user-search-result").append(html);
  }

  function appendSearchErrMsgToHTML(msg) {
    var html = `<div class="chat-group-user clearfix">
                  <p class="chat-group-user__name">${msg}</p>
                </div>`
    $(".user-search-result").append(html);
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
        alert('ユーザー検索に失敗しました');
      });
    });
  });
})