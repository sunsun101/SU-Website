var onResize = function () {
  // apply dynamic padding at the top of the body according to the fixed navbar height
  $("body").css("padding-top", $(".fixed-top").height());
};
$(window).resize(onResize);
document.addEventListener("turbolinks:load", () => {
    onResize();
});

document.addEventListener("turbolinks:render", () => {
    onResize();
});
