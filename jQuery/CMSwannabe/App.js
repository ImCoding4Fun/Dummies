$(function() {
    $.ajax({
			url: 'App.json',
			dataType: 'json',
			success: function(json){
						$(".navbar-brand").text(json.AppName);

						$(json.NavMenu).each(function(index, navMenuItem) {
							$(".navbar-nav a:eq("+index+")").text(navMenuItem.DisplayItem);	
							$(".navbar-nav input:eq("+index+")").val(navMenuItem.SourceFile);							
						})

						$(".navbar-brand, .navbar-nav a").click(function(event) {
					       $("#app-content").html("");
					    })

					    $(".navbar-nav a").click(function(event) {
					        var data_source = $(event.target).siblings()[0].value;
					        $("#data-source").val(data_source);
					        $("#app-content").load(json.TemplateFile);
					    })
					  }
	});
})
