# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
    $('#house_open_report_button a').click ->
        $('.report').hide()
        $('.open_report').show()
        return false
    $('#house_claimed_report_button a').click ->
        $('.report').hide()
        $('.claimed_report').show()
        return false
    $('#house_resolved_report_button a').click ->
        $('.report').hide()
        $('.resolved_report').show()
        return false
