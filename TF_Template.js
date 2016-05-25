 /*
Top & Flop template BL 
 */

$(function(){
  var data_source = $("#data-source").val();
  console.info(data_source);
	$.getJSON( "movies.json", function( json ) {
      $("h1:first").text(json.BestLabel);
      $("h1:last").text(json.WorstLabel);
      
      $(json.Best).each(function(index,item) {
        fillItemBox(".container>div:first",index,item);
      });

  		$(json.Worst).each(function(index,item) {
        fillItemBox(".container>div:last",index,item);
  		});
 	})
})

function fillItemBox(selector,index,item) {
    $(selector).find("h2.item-title:eq('"+ index +"')").text(item.Name);
    $(selector).find("h2.item-desc:eq('"+ index +"')").text(item.Desc);
    $(selector).find("img:eq('"+ index +"')").attr('src',item.Image);
}