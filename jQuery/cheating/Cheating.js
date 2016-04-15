$( document ).ready(function() {
    //set up a local web server before calling this...
    $.getJSON("70480.json", function(json) {
    	var html = "";
    	
    	for(var field in json.response)
    	{
    		html +=  "<p id='"+json.response[field].id.toLowerCase()+"'>"+json.response[field].id+"<br/>"+json.response[field].question+"</p>";
    		html +=  "<span id=s"+i+">Check</span> | <span id=sa"+i+">Show/hide answer</span>";
    		html +=  " <input type='text' id=a"+i+"></input>";
			html +=  " <input id=ca"+i+" type='hidden' value='"+json.response[field].answer+"'></input>";
    		$("body").append(html);
    		html = "";
    	}

    	$("[id^='s']").click(function () {
	    	var correct_answer_id = "#"+ this.id.replace('s','ca');
	    	var answer_id = "#"+ this.id.replace('s','a');
	    	
	    	if($(correct_answer_id).val() == $(answer_id).val()){
				$(answer_id).addClass("correct");
				$(answer_id).removeClass("error");
			}
			else{
				$(answer_id).addClass("error");
				$(answer_id).removeClass("correct");
			}
	    });

	    $("[id^='sa']").click(function () {
	    	var answer_id = "#"+ this.id.replace('sa','a');
	    	var correct_answer_id = "#"+ this.id.replace('sa','ca');
	    	$(answer_id).removeClass("correct");
	    	$(answer_id).removeClass("error");
	    	$(answer_id).val( $(answer_id).val() == ""? $(correct_answer_id).val() : "" );
	    });

    });
});