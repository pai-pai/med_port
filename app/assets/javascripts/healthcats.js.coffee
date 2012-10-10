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

    $(".add_by_click .dropdown-menu li.enable").click ->
        $("#healthcat_bodypart_names").val $("#healthcat_bodypart_names").val() + $(this).text() + ", "
        $(".parts").append "<span class='part_element badge badge-info'>" + $(this).text() + "</span>"
        $(this).remove()
        $(".nothing_to_add").show() if $(".add_by_click .dropdown-menu li").size() is 1
        

    $(document).ready ->
        genderToggler()
        $(".dropdown-toggle").dropdown()
        $(".display_subcats").each ->
            $(this).parent("tr").next().find(".slide_panel").hide()
        $(".nothing_to_add").hide()
