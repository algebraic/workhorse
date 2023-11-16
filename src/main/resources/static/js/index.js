$(function () {
    // blank-out file on click so change sill fires
    $("#fileinput").click(function () {
        $("#result").text("");
        $("#fileinput").val("");
    });

    $("#fileinput").change(function (e) {
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
            success: function (data) {
                $("#loading").toggleClass("d-none");
                $("#result").text(data + " data rows loaded").toggleClass("d-none");
                $("#rowcount").val(data);
            }
        });

    });

    $("#from").keydown(function (e) {
        // on tab, use default from if nothing entered
        if (e.which == 9 && $(this).val() == "") {
            $(this).val("noreply@michigan.gov");
        }
    });

    $("#submit").click(function () {
        $(".error").removeClass("error");
        $(".text-danger").remove();
        var errorText = "<span class='text-danger validation-error'>field required</span>";
        var emailErrorText = "<span class='text-danger validation-error'>valid email required</span>";
        var error = false;

        $(":text.form-control, :file.form-control-file").each(function () {
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
                success: function (data) {
                    console.log(data);
                    $("#filename").text(data);
                }
            });
        }

    });

    // reset button
    $("#reset").click(function () {
        $("#result").text("").addClass("d-none");
        $("#file-note").removeClass("d-none");
        $(".error").removeClass("error");
        $(".error").removeClass("error");
        $(".text-danger").remove();
    });

    $("#close").click(function () {
        // alert close button
        window.location.reload();
    });

    // get git version number
    $.ajax({
        type: "GET",
        url: "../workhorse/commitId", 
        dataType: "json",
        success: function (data) {
            var buildData = "branch:" + data["branch"];
            buildData += "\ncommitMessage - " + data["commitMessage"];
            $("#buildId").text("build " + data['describeShort']);
        },
        error: function () {
            $("#buildId").text("build id unavailable");
        }
    });


    // style first letter
    var $elements = $(".flash-text");
    var upperCase = new RegExp('[^A-Z]');
    $elements.each(function () {
        var text = $(this).text().trim();
        var words = text.split(' ');

        var newHtml = '';
        for (var i = 0; i < words.length; i++) {
            var firstLetter = words[i].charAt(0);
            if (firstLetter === firstLetter.toUpperCase() && firstLetter != firstLetter.toLowerCase()) {
                var restOfWord = words[i].slice(1);
                var spannedLetter = '<span class="first-letter">' + firstLetter + '</span>';
                var newWord = spannedLetter + restOfWord;
                newHtml += newWord + ' ';
            } else {
                newHtml += words[i] + " ";
            }
        }
        $(this).html(newHtml.trim());
    });

});

function getProgress() {
    var progress = 0;

    $.ajax({
        url: '/workhorse/getProgress',
        type: 'GET',
        async: true,
        success: function (data) {
            console.info(data);
            progress = data;
            $("#progressbar").text(progress + "%").attr("aria-valuenow", progress).css("width", progress + "%");
        },
        error: function () {
            console.error("error getting progress");
        }
    });

    if ((Number(progress) != 100)) {
        setTimeout(function () {
            if (Number(progress) != 100) {
                getProgress();
            } else {
                setTimeout(function () {
                    console.log("progress bar has completed, if you need to do anything after");
                    $("#completed-msg").addClass("alert-success");
                    $("#close").addClass("btn-success");
                    $("#footer-text, #progress, #completed-msg").toggleClass("d-none");
                    $("#progressbar").text("0%").attr("aria-valuenow", 0).css("width", "0%");
                    $("#load-icon").hide();
                }, 2000);
            }
        }, 100);
    }
}