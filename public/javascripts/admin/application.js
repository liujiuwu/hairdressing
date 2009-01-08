$(document).ready(function(){
    $(".stripeMe tr").mouseover(function() {$(this).addClass("over");}).mouseout(function() {$(this).removeClass("over");});
    $("input[@type='button'],input[@type='submit']").each(function(){$(this).addClass("button");});
});


