$(function() {
  // 個々のmessageを表示するHTMLを作成
  function buildMessage(message)
  {
    var html = null;
    if(message.body && message.image.url)
    {
      html = `<div class="message">
                <div class="message--title">
                  <span class="message--title__post-user">${message.user_name}</span>
                  <span class="message--title__post-date">${message.create_date}</span>
                  <div class="message--text">
                    ${message.body}
                  </div>
                  <div class="message--image">
                    <img src="${message.image.url}">
                  </div>
                </div>
              </div>`;
    }
    else if(message.body)
    {
      html = `<div class="message">
                <div class="message--title">
                  <span class="message--title__post-user">${message.user_name}</span>
                  <span class="message--title__post-date">${message.create_date}</span>
                  <div class="message--text">
                    ${message.body}
                  </div>
                </div>
              </div>`;
    }
    else if(message.image)
    {
      html = `<div class="message">
                <div class="message--title">
                  <span class="message--title__post-user">${message.user_name}</span>
                  <span class="message--title__post-date">${message.create_date}</span>
                  <div class="message--image">
                    <img src="${message.image.url}">
                  </div>
                </div>
              </div>`;
    }

    if(html)
    {
      // 作成したHTMLをメッセージ画面の一番下に追加する
      $(".chat--messages").append(html);
    }
  }

  //jqueryで無効化したSendボタンの有効化
  function send_button_enable() {
    $('#form--send-button').prop('disabled', false);
  }

  $(".new_message").on("submit", function(e) {
    e.preventDefault();
    var formData = new FormData(this);
    var url = $(this).attr("action");
    $.ajax({
      type: "POST",
      url: url,
      data: formData,
      dataType: "json",
      processData: false,
      contentType: false
    })
    .done(function(message) {
      //HTML要素を作成して追加
      buildMessage(message);
      $("#form--text-input").val("");
      //現在位置+最終コメント要素の相対位置にスクロール
      var currentScrollTop = $(".chat--messages").scrollTop()
      var scrollSize = $(".message").last().offset().top
      $(".chat--messages").animate(
        { scrollTop: currentScrollTop + scrollSize },
        { duration: 2000 }
      );
      //Sendボタンの有効化
      send_button_enable();
    })
    .fail(function()
    {
      alert("エラー");
      //Sendボタンの有効化
      send_button_enable();
    });
  });
})