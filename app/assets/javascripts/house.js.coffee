$ ->
    $('#house_open_report_button a').click ->
        $('.hr_resolved').hide()
        $('.hr_claimed').hide()
        $('.hr_open').show()
        return false
    $('#house_claimed_report_button a').click ->
        $('.hr_open').hide()
        $('.hr_resolved').hide()
        $('.hr_claimed').show()
        return false
    $('#house_resolved_report_button a').click ->
        $('.hr_open').hide()
        $('.hr_claimed').hide()
        $('.hr_resolved').show()
        return false
    $('#house_all_report_button a').click ->
        $('.hr_open').show()
        $('.hr_claimed').show()
        $('.hr_resolved').show()
        return false
