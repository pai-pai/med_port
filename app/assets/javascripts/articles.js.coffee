jQuery ->
    $("#article_healthcats_tabs a:last").tab "show"

    $("#article_healthcats_tabs a").click (e) ->
        e.preventDefault()
        $(this).tab "show"
    
    $("#article_healthcats_tabs a:first").click ->
        $("#show_article_intro").html $("#article_introduction").val()
        $("#show_article_body").html $("#article_body").val()
