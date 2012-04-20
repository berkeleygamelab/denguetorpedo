# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
    $('#houses_button').click -> (ev)
        $('.neighborhoods #houses').show()
        $('.neighborhoods #participants').hide()
        $('.neighborhoods #health_agents').hide()
        return false
    $('#participants_button').click -> (ev)
        $('.neighborhoods #houses').hide()
        $('.neighborhoods #participants').show()
        $('.neighborhoods #health_agents').hide()
        return false
    $('#health_agents_button').click -> (ev)
        $('.neighborhoods #houses').hide()
        $('.neighborhoods #participants').hide()
        $('.neighborhoods #health_agents').show()
        return false

