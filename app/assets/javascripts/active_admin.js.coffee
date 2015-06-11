#= require active_admin/base
 jQuery(document).ready ->
  $("#my_image").attr "src", "/assets/no_image.jpg"
  $("#banner_image").change ->
    readURL = undefined
    readURL = (input) ->
      reader = undefined
      if input.files and input.files[0]
        reader = new FileReader()
        reader.onload = (e) ->
          $("#my_image").attr "src", e.target.result

        reader.readAsDataURL input.files[0]

    readURL this




