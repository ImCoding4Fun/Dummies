/*
  HTMLifies* the textual content of a given DOM element ID.
  * = quite rudely because it simply replaces url, pseudoUrl and email address with their corresponding HTML tags.
*/
String.prototype.toHtml = function()
{
   // http://, https://, ftp://
   var urlPattern = /(\(.*?)?\b((?:https?|ftp|file):\/\/[-a-z0-9+&@#\/%?=~_()|!:,.;]*[-a-z0-9+&@#\/%=~_()|])/ig
   // www. sans http:// or https://
   var pseudoUrlPattern = /(^|[^\/"'])(www\.[\S]+(\b|$))/gim;
   // Email addresses
   var emailAddressPattern = /(([a-zA-Z0-9_\-\.]+)@[a-zA-Z_]+?(?:\.[a-zA-Z]{2,6}))+/gim


   var lines = $(""+this).val().split("\n")
   var htmlText = ""

    $.each(lines, function(i){

          var htmlLine = lines[i]
                         .replace(urlPattern, '<a target="_blank" href="$&">$&</a>')
                         .replace(pseudoUrlPattern, '$1<a target="_blank" href="http://$2">$2</a>')
                         .replace(emailAddressPattern, '<a href="mailto:$1">$1</a>') + "<br />";

          htmlText += htmlLine
    });

    return "<p>" + htmlText + "</p>"
}
