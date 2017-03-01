$(document).ready(function(){
  $(".title").click(function() {
    $(this).next('div').fadeToggle("description");
  });

  $(".lighttrigger").mouseenter(function() {
    $(".lightbulb").addClass("enter");
    $(".lightbulb").removeClass("leave");
  });

  $(".lighttrigger").mouseleave(function() {
    $(".lightbulb").removeClass("enter");
    $(".lightbulb").addClass("leave");
  });
});
