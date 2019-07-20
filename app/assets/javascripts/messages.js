$(function() {

  // 個々のmessageを表示するHTMLを作成
  function buildMessage(message) {
    var html = null;
    var message_text_html = "";
    var message_image_html = "";

    if(message.body) {
      message_text_html =
      `<div class="message--text">
        ${message.body}
      </div>`
    }

    if(message.image.url) {
      message_image_html =
      `<div class="message--image">
        <img src="${message.image.url}">
      </div>`
    }

    html = `<div class="message">
              <div class="message--title">
                <span class="message--title__post-user">${message.user_name}</span>
                <span class="message--title__post-date">${message.create_date}</span>
                ${message_text_html}
                ${message_image_html}
                </div>
              </div>
            </div>`

    if(html) {
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
      //入力エリアクリア
      $("#form--text-input").val("");
      //画像ファイルクリア
      $("#form--file-select-icon__display").val("");
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

  //メッセージの自動更新
  var reloadMessages = function() {
    //カスタムデータ属性を利用し、ブラウザに表示されている最新メッセージのidを取得
    last_message_id = $(".message").last().data("id")
    $.ajax({
      //ルーティングで設定した通りのURLを指定
      url: location.pathname.substring(0,location.pathname.lastIndexOf('/')) + "/api/messages",
      //ルーティングで設定した通りhttpメソッドをgetに指定
      type: 'GET',
      dataType: 'json',
      //dataオプションでリクエストに値を含める
      data: {last_message_id: last_message_id}
    })
    .done(function(messages) {
      console.log('success');
    })
    .fail(function() {
      console.log('error');
    });
  };
  setInterval(reloadMessages, 5000);
})