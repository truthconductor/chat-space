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
      //スクロール
      $(".chat--messages").animate(
        { scrollTop:$(".message").last().offset().top },
        { duration: 2000 }
      );
      //Sendボタンの有効化
      $('#form--send-button').prop('disabled', false);
    })
    .fail(function()
    {
      alert("エラー");
      //Sendボタンの有効化
      $('#form--send-button').prop('disabled', false);
    });
  });
})