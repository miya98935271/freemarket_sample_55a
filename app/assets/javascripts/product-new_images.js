
$(document).on('turbolinks:load', function(){
  var image_upload_area = $('.form-image__field');
  var image_upload_area2 = $('.form-image__field2');
  var label = $('.upload-label');
  var previews = $('#previews')
  var previews2 = $('#previews2');
  var images = [];
  var inputs = [];
  var input_area = $('.input_area');
  var new_image = $(`<input multiple="multiple" name="images[image][]" class="hidden" data-image="0" type="file" id="product_images_attributes_0_name"></input>`)
  
  // プレビュー機能
  $('.image_upload').on('change', function (e) {
    var reader = new FileReader();
    var append_preview = $(`<li class="image-preview">
                              <div class="image-preview__wapper">
                                <img class="preview">
                              </div>
                              <div class="image-preview_btn">
                                <div class="image-preview_btn_edit">編集</div>
                                <div class="image-preview_btn_delete">削除</div>
                              </div>
                            </li>`
                          );   
    // 画像ファイルを読み込む
    reader.readAsDataURL(e.target.files[0]);
    //画像ファイルが読み込んだら、処理が実行される。
    reader.onload = function(e){
      $(append_preview).find('.preview').attr('src', e.target.result);
    }
    //画像ファイルをimagesに保存する。
    images.push(append_preview);
    if (images.length <= 4) {
      $('#previews').empty();
      $.each(images,function(index, image){
        image.data('image', index);
        $('#previews').append(image)
      })
      image_upload_area.css({
        'width': `calc(100% - (20% * ${images.length}))`
      })
    }
    else if (images.length == 5) {
      $('#previews').empty();
      $.each(images,function(index, image){
        image.data('image', index);
        $('#previews').append(image)
      })
      image_upload_area.css({
        'display': 'none'
      })
      image_upload_area2.css({
        'display': 'block'
      })
    }
    else if (images.length >= 6) {
      var images_0_5 = images.slice(0,5);
      var images_6_10 = images.slice(5);
      $('#previews').empty();
      $('#previews2').empty();
      $.each(images_0_5,function(index, image){
        image.data('image', index);
        $('#previews').append(image)
      })
      $.each(images_6_10,function(index, image){
        image.data('image', index);
        $('#previews2').append(image)
      })
      image_upload_area2.css({
        'width': `calc(100% - (20% * ${images.length - 5}))`
      })
      if (images.length == 10) {
        image_upload_area2.css({
          'display': 'none'
        })
      }
    }
  })
  //削除機能
  $(document).on('click',"image-preview_btn_delete",function(){
    var index = $('image-preview').index(this);
  })
});