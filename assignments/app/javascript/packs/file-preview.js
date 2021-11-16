$(function () {
  // Multiple images preview in browser
  var imagesPreview = function (input, placeToInsertImagePreview) {
    const btn1 = document.getElementById("removeImage");
    $(placeToInsertImagePreview).html("");
    if (input.files) {
      var filesAmount = input.files.length;

      if (filesAmount > 0) {
        for (i = 0; i < filesAmount; i++) {
          var reader = new FileReader();
          var id = $(input.files[i]).attr("id");
          reader.onload = function (event) {
            $($.parseHTML('<img class = "contact-img">'))
              .attr("src", event.target.result)
              .appendTo(placeToInsertImagePreview);
          };

          reader.readAsDataURL(input.files[i]);
        }
        btn1.style.display = "block";
      } else {
        $(placeToInsertImagePreview).html("");
        btn1.style.display = "none";
      }
    }
  };

  $("#uploaded-pictures").on("change", function () {
    imagesPreview(this, "div.preview");
  });
  $("#removeImage").click(function (e) {
    e.preventDefault(); // prevent default action of link
    this.files = [];
    $("#uploaded-pictures").val(""); // clear image input value
    imagesPreview(this, "div.preview");
  });
});
