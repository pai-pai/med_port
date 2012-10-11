jQuery ->
    genderToggler = ->
        unless $("#healthcat_parent_healthcat_id").val() is ""
            $("div.gender").slideUp()
        else
            $("div.gender").show()

    bodypartsBages = ->
        if $("#healthcat_bodypart_names").val() isnt undefined and $("#healthcat_bodypart_names").val() isnt ""
            line_parts = $("#healthcat_bodypart_names").val()
            parts = line_parts.split(", ")
            parts = line_parts if parts is ""
            part = 0
            while part < parts.length
                $(".parts").append "<span class='part_element badge badge-info'>" + parts[part] + "</span>"
                $(".add_by_click .dropdown-menu li.enable").each ->
                    $(this).removeClass("visible").addClass("hidden") if $(this).text() is parts[part]
                part++

    subcatToggler = (parent_elt) ->
        $(parent_elt).parent("tr").next().find(".slide_panel").slideToggle("slow")
    
    $("#healthcat_parent_healthcat_id").change ->
        genderToggler()

    $(".display_subcats").click ->
        subcatToggler this

    $(".add_by_click .dropdown-menu li.enable").click ->
        $("#healthcat_bodypart_names").val $("#healthcat_bodypart_names").val() + ", " + $(this).text()
        $(".parts").append "<span class='part_element badge badge-info'>" + $(this).text() + "</span>"
        $(this).removeClass("visible").addClass("hidden")
        $(".nothing_to_add").show() if $(".add_by_click .dropdown-menu li.visible").size() is 0

    $(".part_element").live "click", ->
        remove_elt = this
        $(".add_by_click .dropdown-menu li").each ->
            $(this).removeClass("hidden").addClass("visible") if $(this).text() is $(remove_elt).text()
        return_text = $("#healthcat_bodypart_names").val().replace($(remove_elt).text(), "")
        $("#healthcat_bodypart_names").val return_text
        $(".nothing_to_add").hide() if $(".add_by_click .dropdown-menu li.visible").size() > 0
        $(remove_elt).remove()

    $(document).ready ->
        genderToggler()
        bodypartsBages()
        $(".dropdown-toggle").dropdown()
        $(".display_subcats").each ->
            $(this).parent("tr").next().find(".slide_panel").hide()
        $(".nothing_to_add").hide()
        $("#healthcat_bodypart_names").hide()
