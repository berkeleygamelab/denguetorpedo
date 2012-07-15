$ ->
    $('#house_open_report_button a').click ->
        $('.hr_report').hide()
        $('.hr_open').show()
        return false
    $('#house_claimed_report_button a').click ->
        $('.hr_report').hide()
        $('.hr_claimed').show()
        return false
    $('#house_resolved_report_button a').click ->
        $('.hr_report').hide()
        $('.hr_resolved').show()
        return false
    $('#house_all_report_button a').click ->
        $('.hr_report').show()
        return false
