$ ->
    $("#neighborhood_list li a").click ->
        $("#neighborhood_list li").removeClass("hilite")
        $(this).parent().parent().addClass("hilite")
        return true

    $("#slider").nivoSlider()
