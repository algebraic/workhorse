$(function() {

    // blank file on click so change sill fires
    $("#fileinput").click(function() {
        $("#result").text("");
        $("#fileinput").val("");
    });

    $("#fileinput").change(function(e) {
        $("#file-note, #loading").toggleClass("d-none");
        var file = e.target.files[0];
        var formData = new FormData();
        formData.append('file', file);

        $.ajax({
            url: '/workhorse/check',
            type: 'POST',
            data: formData,
            processData: false,
            contentType: false,
            success: function(data) {
                $("#loading").toggleClass("d-none");
                $("#result").text(data + " data rows loaded").toggleClass("d-none");
                $("#rowcount").val(data);
            }
        });

    });

    $("#from").keydown(function(e) {
        // on tab, use default from if nothing entered
        if (e.which == 9 && $(this).val() == "") {
            $(this).val("noreply@michigan.gov");
        }
    });

    $("#submit").click(function() {
        $(".error").removeClass("error");
        $(".text-danger").remove();
        var errorText = "<span class='text-danger validation-error'>field required</span>";
        var emailErrorText = "<span class='text-danger validation-error'>valid email required</span>";
        var error = false;

        // alert("rowcount = " + $("#rowcount").val());

        $(":text.form-control, :file.form-control-file").each(function() {
            var $this = $(this);
            if ($this.attr("id") == "from" && $this.val() != "") {
                var re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
                var validEmail = re.test(String($this.val()).toLowerCase());
                if (!validEmail) {
                    error = true;
                    $this.parents(".card").addClass("error").append(emailErrorText);
                }
            }
            if ($this.val() == "" && $this.attr("id")) {
                error = true;
                $this.parents(".card").addClass("error").append(errorText);
            }
            
        });


        if (!error) {
            $("#footer-text, #progress, #overlay").toggleClass("d-none");
            var file = $("#fileinput")[0].files[0];
            var formData = new FormData();
            formData.append('file', file);
            formData.append('rowcount', $("#rowcount").val());

            getProgress();

            $.ajax({
                url: '/workhorse/load',
                type: 'POST',
                async: true,
                data: formData,
                processData: false,
                contentType: false,
                success: function(data) {
                    console.log(data);
                }
            });
        }

    });

    // reset button
    $("#reset").click(function() {
        $("#result").text("").addClass("d-none");
        $("#file-note").removeClass("d-none");
        $("#body").summernote("reset");
        $(".error").removeClass("error");
        $(".error").removeClass("error");
        $(".text-danger").remove();
    });

    $("#close").click(function() {
        // alert close button
        window.location.reload();
    });
});

function getProgress() {
    var progress = 0;
    firstRun = true;

    $.ajax({
        url: '/workhorse/getProgress',
        type: 'GET',
        async: true,
        success: function(data) {
            progress = data;
            $("#progressbar").text(progress + "%").attr("aria-valuenow", progress).css("width", progress + "%");
        },
        error: function() {
            console.error("error getting progress");
        }
    });

/*
well, at least it stops now...
gotta get the progress bar to finish off cleanly
& also the timeout at the end doesn't seem to fire...
---
i think we've actually got 3 stages here...
progress < 100 && isNan >>> first time it's run through to kickoff
progress < 100 && !isNan >>> regular % processing
progress somehow still < 100 && isNaN >>> all done now?
*/


    if (progress <= 100) {
        setTimeout(function() {
            if (isNaN(progress) && firstRun) {
                firstRun = false;
                getProgress();
            } else if (!isNaN(progress)) {
                console.info("getProgress() timeout -- " + progress + " -- " + isNaN(progress));
                getProgress();
            }
        }, 100);
    } else {
        console.info("done?")
        $("#progressbar").text("100%").attr("aria-valuenow", 100).css("width", "100%");
        setTimeout(function() {
            console.info("progress bar has completed, if you need to do anything after");
            $("#completed-msg").addClass("alert-success");
            $("#close").addClass("btn-success");
            $("#footer-text, #progress").toggleClass("d-none");
            $("#progressbar").text("0%").attr("aria-valuenow", 0).css("width", "0%");
            $("#load-icon").hide();
        }, 2000);
    }
}