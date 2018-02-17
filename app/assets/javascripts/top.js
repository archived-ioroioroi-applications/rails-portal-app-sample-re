
// document.getElementById("ID名").value = ”2015/04/29”;
$(function () {
  var intervalId = setInterval(sampleMethod, 1000);
  function sampleMethod() {
    var time = new Date();
    console.log(time);
    $('#category-column').replaceWith($("<p class=\"category-title\" id=\"category-column\">" +  time + "</p>").hide().fadeIn('slow'));
  };

  // $('#category-list-item-column').on('click', function() {
  //   var category = $('#category-list-item-column').data("category-list-item-column");
  //   $('.category-title').replaceWith($("<p class=\"category-title\" id=\"category-title\">" +  category + "</p>").hide().fadeIn('slow'));
  // });
  // $('#category-list-item-it').on('click', function() {
  //   var category = $('#category-list-item-it').data("category-list-item-it");
  //   $('.category-title').replaceWith($("<p class=\"category-title\" id=\"category-title\">" +  category + "</p>").hide().fadeIn('slow'));
  // });
  // $('#category-list-item-gourmet').on('click', function() {
  //   var category = $('#category-list-item-gourmet').data("category-list-item-gourmet");
  //   $('.category-title').replaceWith($("<p class=\"category-title\" id=\"category-title\">" +  category + "</p>").hide().fadeIn('slow'));
  // });

});
