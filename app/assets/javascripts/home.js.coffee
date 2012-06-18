$ ->
    $("#neighborhood_list li a").click ->
        $("#neighborhood_list li").removeClass("hilite")
        $(this).parent().parent().addClass("hilite")
        return true
        
    $("div.slider").carousel({loop: true, autoSlide: true, autoSlideInterval: 5000, delayAutoSlide: 2000, animSpeed: "slow"});