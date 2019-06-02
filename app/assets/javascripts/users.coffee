# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  # collection_selectの選択肢を書き換える
  replaceSelectOptions = ($select, results) ->
    $select.html $('<option>')
    $.each results, ->
      option = $('<option>').val(this.id).text(this.name)
      $select.append(option)

  # ジャンルをカテゴリに合わせて変更する
  replaceGenreOptions = ->
    # あとで書き換えるためにジャンルの一覧を決めるHTMLを取得
    $selectGenre = $(@).closest('form').find('.genre').find('#q_category_id_eq')

    # カテゴリに対応するジャンル一覧をRailsに問い合わせ
    $.ajax(
      url: '/categories'
      dataType: 'json'
      data: {
        parent_id: $(@).find('option:selected').val()
      }
      success: (results) ->
        replaceSelectOptions($selectGenre, results)
      error: (XMLHttpRequest, textStatus, errorThrown) ->
        console.error('Error occurred in replaceGenreOptions')
        console.log("XMLHttpRequest: #{XMLHttpRequest.status}")
        console.log("textStatus: #{textStatus}")
        console.log("errorThrown: #{errorThrown}")
    )

  $('.category').on
    'change': replaceGenreOptions
