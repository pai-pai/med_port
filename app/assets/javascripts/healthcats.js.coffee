jQuery ->
    genderToggler = ->
        unless $("#healthcat_parent_healthcat_id").val() is ""
            $("div.gender").slideUp()
        else
            $("div.gender").show()

    subcatToggler = (parent_elt) ->
        $(parent_elt).parent("tr").next().find(".slide_panel").slideToggle("slow")

    $("#healthcat_parent_healthcat_id").change ->
        genderToggler()

    $(".display_subcats").click ->
        subcatToggler this

    $(document).ready ->
        genderToggler()
        $(".display_subcats").each ->
            $(this).parent("tr").next().find(".slide_panel").hide()
