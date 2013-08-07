$ ->
    $('a#house_open_report_button').click ->
        $('.hr_resolved').hide()
        $('.hr_claimed').hide()
        $('.hr_open').show()
        $('div#house_open_report_button').attr("class", "house_report_button span1 active")
        $('div#house_claimed_report_button').attr("class", "house_report_button span1")
        $('div#house_resolved_report_button').attr("class", "house_report_button span1")
        $('div#house_all_report_button').attr("class", "house_report_button span1")
        return false
    $('a#house_claimed_report_button').click ->
        $('.hr_open').hide()
        $('.hr_resolved').hide()
        $('.hr_claimed').show()
        $('div#house_open_report_button').attr("class", "house_report_button span1")
        $('div#house_claimed_report_button').attr("class", "house_report_button span1 active")
        $('div#house_resolved_report_button').attr("class", "house_report_button span1")
        $('div#house_all_report_button').attr("class", "house_report_button span1")
        return false
    $('a#house_resolved_report_button').click ->
        $('.hr_open').hide()
        $('.hr_claimed').hide()
        $('.hr_resolved').show()
        $('div#house_open_report_button').attr("class", "house_report_button span1")
        $('div#house_claimed_report_button').attr("class", "house_report_button span1")
        $('div#house_resolved_report_button').attr("class", "house_report_button span1 active")
        $('div#house_all_report_button').attr("class", "house_report_button span1")
        return false
    $('a#house_todos_report_button').click ->
        $('.hr_open').show()
        $('.hr_claimed').show()
        $('.hr_resolved').show()
        $('div#house_open_report_button').attr("class", "house_report_button span1")
        $('div#house_claimed_report_button').attr("class", "house_report_button span1")
        $('div#house_resolved_report_button').attr("class", "house_report_button span1")
        $('div#house_all_report_button').attr("class", "house_report_button span1 active")
        return false
