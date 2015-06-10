#= require active_admin/base
 jQuery(document).ready ->
  $("#banner_image").change ->
    readURL = (input) ->
      if input.files and input.files[0]
        reader = new FileReader()
        reader.onload = (e) ->
          $("#my_image").attr "src", e.target.result

        reader.readAsDataURL input.files[0]
    readURL this
   


