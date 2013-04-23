$(function() {
    $('.question-nav').click(function() {
        var that = $(this)

        var i = that.attr('question')

        $('.btn-inverse').removeClass('btn-inverse')
        that.addClass('btn-inverse')

        $('.question:not(.hide)').addClass('hide')
        $('.question[question=' + i + ']').removeClass('hide')
    })
})