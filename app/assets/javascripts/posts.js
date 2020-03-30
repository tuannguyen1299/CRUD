$( function() {
  var availableTags = [];
  $.ajax({
    url: "/search_post",
    success: function (data) {
      $( "#search" ).autocomplete({
        source: data.posts
      });
     }
  })
});

$(function() {
  var search = document.getElementById("search");
  var els = document.querySelectorAll(".post");
  if(search){
    search.addEventListener("keyup", function(){
      Array.prototype.forEach.call(els, function(el) {
        el_title = el.getElementsByClassName('title')[0].textContent
        if (el_title.indexOf(search.value) === 0)
          el.style.display = 'block';
        else el.style.display = 'none';
      });
    })
  }
})
