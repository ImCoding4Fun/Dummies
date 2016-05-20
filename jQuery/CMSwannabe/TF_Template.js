 /*
Top & Flop template BL 
 */

$(function(){
  console.info($("#target-link").val());
	$.getJSON( "movies.json", function( json ) {
      $("h1:first").text(json.BestLabel);
      $("h1:last").text(json.WorstLabel);
      
      $(json.Best).each(function(index,movie) {
        setMovieItem(".container>div:first",index,movie);
      });

  		$(json.Worst).each(function(index,movie) {
        setMovieItem(".container>div:last",index,movie);
  		});
 	})
})


function setMovieItem(selector,index,movie) {
    $(selector).find("h2.item-title:eq('"+ index +"')").text(movie.Name);
    $(selector).find("h2.item-desc:eq('"+ index +"')").text(movie.Plot);
    $(selector).find("img:eq('"+ index +"')").attr('src',movie.Image);
}