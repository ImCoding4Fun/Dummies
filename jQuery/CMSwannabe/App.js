$(function() {
    $.ajax({
			url: 'App.json',
			dataType: 'json',
			success: function(json){
						$(".navbar-brand").text(json.AppName);

						$(json.NavMenu).each(function(index, navMenuItem) {
							$(".navbar-nav a:eq("+index+")").text(navMenuItem.DisplayItem)							
						});

						$(".navbar-brand, .navbar-nav a").click(function(event) {
					       $("#app-content").html("");
					    });

					    $(".navbar-nav a").click(function(event) {
					        $("#target-link").val(event.target.text);
					        $("#app-content").load(json.TemplateFile);
					    });
					  }
	});
})
