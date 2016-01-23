//menu
$(document).ready(function(){
  
  $('li.subNavBtn').mousemove(function(){
  $(this).find('ul').slideDown("1000");//you can give it a speed
  });
  $('li.subNavBtn').mouseleave(function(){
  $(this).find('ul').slideUp("fast");
  });
  
});
