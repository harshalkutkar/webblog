// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .



$(function(){

    var success=0;

    $("#loginform").submit(function(e) {
        $.ajax({
            type : 'POST',
            url : '/authentication/authenticate',
            data : $(this).serialize(),
            success :function reply(data) {
                if (data==0)
                {
                    success=0;
                $("#error").html("<h4 style='color: red'> Whoops! Wrong username and password </h4>")
                }
                else
                {
                    success=1;
                    return true;
                }

            }



        });


        if (success==0)
        {
        //These need to be there in order to stop submission
        e.preventDefault();
        return false;
        }


    });
});


function getPhotos(id)
{
    $.ajax({
        url: '../photos/uploads/'+id,

        success: function response(r)
        {
            $("#right_panel").html(r);

        }

    });
}



