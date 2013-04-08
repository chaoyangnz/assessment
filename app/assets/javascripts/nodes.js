// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(function() {

//
//    $('#question-form tbody').append(choice)

    $('#question-form .add-choice').on('click', function() {
        var choice = template('choice-template', {})
        $('table tbody').append(choice)
    });

    $('#question-form table').on('click', '.remove-choice', function() {
        if($(this).closest('tr').find('input[name="node[choices_attributes][][id]"]').length == 0) {
            console.log('删除还未保存的选择项')
            $(this).closest('tr').remove()
        } else {
            console.log('删除已存在的保存的选择项')
            $(this).closest('tr').hide()
            $(this).closest('tr').append('<input type="hidden" name="node[choices_attributes][][_destroy]" value="1"> ')
        }
    });

    $('#audio-uploader').uploadify({
        swf      : '/assets/uploadify.swf',
        uploader : '/uploads/',//'<%= uploads_path %>',
        method   : 'post',
//        fileObjName: 'file',
        buttonText: '浏览上传',
        width: 60,
        height: 20,
        buttonClass: 'btn',
        fileSizeLimit : '10MB',
        fileTypeDesc : 'Audio Files',
        fileTypeExts : '*.mp3; *.wma',
        formData : {
            type: 'audio',
            authenticity_token: $('input[name=authenticity_token]').val()//"<%= form_authenticity_token.to_s %>"
        },
        onUploadSuccess : function(file, data, response) {
            $('#node_content').val(JSON.parse(data).file.url)
        }
    });

    $('#node_media').change(function() {
        if($(this).val() == 'audio') {
            $('#audio-uploader-div').show()
            $('#node_content').val('')
            $('#node_content').attr("readonly",true);
        } else {
            $('#audio-uploader-div').hide()
            $('#node_content').val('')
            $('#node_content').attr("readonly",false);
        }
    })

    $('li.answer').each(function() {
        var that = $(this)
        that.css({position: 'relative'})
        $('<i class="icon-ok" style="position: absolute; left: -25px; bottom: -8px; font-size: 1.2em; color: red"></i>').prependTo(that)
    })


    $('dt, dd').mouseover(function() {
        $(this).find('.bar').removeClass('hide')
    }).mouseout(function() {
        $(this).find('.bar').addClass('hide')
    })

});