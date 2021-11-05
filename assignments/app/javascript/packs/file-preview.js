// $(document).ready(function () {
//   imageHandler();
// });
// function imageHandler() {
//   $("#event_pictures").on("keyup", function (event) {
//     if (event.keyCode == 86) {
//         clearMediaPreview()
//         var imageUrl = $('#event_pictures').val()
//         showImagePreview(imageUrl)
//     }
//     if (event.keyCode == 8) {
//       if ($("#event_pictures").val() == "") {
//         clearMediaPreview()
//         showImageUrl()
//       }
//     }
//   });
// }

// function clearMediaPreview() {
//   $(".media-preview").html("");
// }

// function showImagePreview(imageUrl) {
//   console.log("here is the url",)
//   $(".media-preview").html("<img src=" + imageUrl + ">");
// }

// function showImageUrl() {
//   $("#event_pictures").show();
// }
// $(function () {
//   // Multiple images preview in browser
//   var imagesPreview = function (input, placeToInsertImagePreview) {
//     if (input.files) {
//       var filesAmount = input.files.length;

//       for (i = 0; i < filesAmount; i++) {
//         var reader = new FileReader();

//         reader.onload = function (event) {
//           $($.parseHTML("<img>"))
//             .attr("src", event.target.result)
//             .appendTo(placeToInsertImagePreview);
//         };

//         reader.readAsDataURL(input.files[i]);
//       }
//     }
//   };

//   $("#event_pictures").on("change", function () {
//     imagesPreview(this, "div.gallery");
//   });
// });
