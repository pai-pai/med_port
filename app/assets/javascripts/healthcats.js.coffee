jQuery ->
    genderToggler = ->
        unless $("#healthcat_parent_healthcat_id").val() is ""
            $("div.gender").slideUp()
        else
            $("div.gender").show()

    $("#healthcat_parent_healthcat_id").change ->
        genderToggler()

    $(document).ready ->
        genderToggler()
