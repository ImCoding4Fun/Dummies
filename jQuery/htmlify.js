function htmlifyText(text_id, load_or_update)
{
    var noteLines = load_or_update ? $("#"+text_id).text().split(' ') : $("#"+text_id).val().split(' ')
    var htmlNote = "";
    for (var i = 0; i < noteLines.length; i++) 
    {
        htmlNote = htmlNote + htmlify(noteLines[i]) + ' '
    }
    return htmlNote    
}

function htmlify(line) 
{
    // http://, https://, ftp://
    var urlPattern = /(\(.*?)?\b((?:https?|ftp|file):\/\/[-a-z0-9+&@#\/%?=~_()|!:,.;]*[-a-z0-9+&@#\/%=~_()|])/ig

    // www. sans http:// or https://
    var pseudoUrlPattern = /(^|[^\/"'])(www\.[\S]+(\b|$))/gim;
    
    // Email addresses
    var emailAddressPattern = /(([a-zA-Z0-9_\-\.]+)@[a-zA-Z_]+?(?:\.[a-zA-Z]{2,6}))+/gim
    
    return line
        .replace(urlPattern, '<a target="_blank" href="$&">$&</a>')
        .replace(pseudoUrlPattern, '$1<a target="_blank" href="http://$2">$2</a>')
        .replace(emailAddressPattern, '<a href="mailto:$1">$1</a>');
}