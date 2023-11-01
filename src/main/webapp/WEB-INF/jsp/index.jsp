<!doctype html>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="en">

<head>
    <title>WORKHORSE</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN"
        crossorigin="anonymous">

    <link rel="stylesheet" href="/workhorse/css/material.float.labels.css">

    <link rel="stylesheet" href="/workhorse/css/style.css">
    <link rel="stylesheet" href="/workhorse/css/loading.io.css">

    <link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote-bs4.css" rel="stylesheet">

    <style>
        span.first-letter {
            text-shadow: -1px -1px rgba(221, 135, 6, 0.432) !important;
        }
        .logo {
            height: 50px;
            width: 50px;
        }
        .version {
            position: absolute;
            left: 70px;
            top: 45px;
        }
        .hidden {
            display: none;
        }
    </style>

</head>

<body>
    <!-- navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container-fluid">
            <a class="navbar-brand" href="/workhorse">
                <img class="logo" src="/workhorse/img/small-light2.png">
                <span class="ml-2 pt-1">WORKHORSE<small class="version"><a class="nav-link disabled" id="buildId"></a></small>
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
                aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0 px-5">
                    <li class="nav-item px-2">
                        <a id="file_operation" class="btn btn-outline-warning section" href="#" role="button">File Operation</a>
                        <a id="manual_entry" class="btn btn-outline-warning section" href="#" role="button">Manual Entry</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container-fluid">
        
    </div>

    <!-- file operation section -->
    <div class="container-fluid hidden" data-section="file_operation">
        <div id="overlay" class="d-none">
            <div class="lds-grid" id="load-icon">
                <div></div>
                <div></div>
                <div></div>
                <div></div>
                <div></div>
                <div></div>
                <div></div>
                <div></div>
                <div></div>
            </div>
            <div id="completed-msg" class="alert d-none" role="alert">
                <h4 class="alert-heading">Process Completed</h4>
                <p>File <span id="filename"></span> has been successfully uploaded</p>
                <hr>
                <button id="close" class="btn">Close</button>
            </div>
        </div>
    
        <br>
        <div class="page-content hide float-labels">
            <div class="container">
                <form>
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="card">
                                <div class="card-body">
                                    <h6 class="my-4">Select data file:</h6>
                                    <div class="form-group">
                                        <input type="file" name="fileinput" id="fileinput" class="form-control-file">
                                        <div class="lds-hourglass-sm d-none" id="loading">
                                            <div></div>
                                            <div></div>
                                        </div>
                                        <small id="result" class="d-none"></small>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
    
                    <br>
    
                    <div class="row my-5">
                        <div class="col-lg-12 text-center mb-1">
                            <input type="hidden" id="rowcount" name="rowcount">
                            <button type="button" id="submit" class="btn btn-dark">Submit</button>
                            <button type="reset" id="reset" class="btn btn-dark">Reset</button>
                        </div>
                    </div>
                </form>
    

            </div>
        </div>
    </div>
    
    <!-- manual entry section -->
    <div class="container-fluid hidden" data-section="manual_entry">
        <h3>manual entry section</h3>
        <br>
        <div class="form-floating mb-3">
            <input type="email" class="form-control" id="floatingInput" placeholder="placeholder text">
            <label for="floatingInput">Field Name</label>
        </div>
        <small><a href="https://jsfiddle.net/zjohnson/udtyrbao/7/" target="_blank">mine</a> shows placeholder text also ;)</small>
    </div>

    <!-- footer -->
    <div class="container-fluid">
        <div class="row fixed-bottom">
            <div class="col-lg-12 text-center">
                <div class="alert-dark bg-dark my-0 p-0" id="footer">
                    <small style="top: 10px; position: relative;" class="flash-text" id="footer-text">
                        Web-based Organization and Reporting Kit for High-level Operations and Reliable Systematic Extraction
                    </small>
                    <!-- <h6 class="card-title flash-text"></h6> -->
                    <div class="progress d-none" id="progress" style="height: 50px">
                        <div class="progress-bar progress-bar-striped progress-bar-animated bg-info" id="progressbar" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width: 0%;"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>



    <script src="https://code.jquery.com/jquery-3.4.1.min.js"
        integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo=" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
        crossorigin="anonymous"></script>
    <script src="/workhorse/js/material.float.labels.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote-bs4.js"></script>
    <script src="https://kit.fontawesome.com/208550a0ca.js"></script>

    <script src="/workhorse/js/index.js"></script>

    <script>
        $(function () {

            // section buttons
            $("a.section").click(function() {
                $("div[data-section]").addClass("hidden");
                var section = $(this).attr("id");
                console.info("section = " + section);
                $('div[data-section="' + section + '"]').removeClass("hidden");
            });

            // get git version number
            $.ajax({
                type: "GET",
                url: "commitId", // Replace with the correct URL to your controller method
                dataType: "json",
                success: function (data) {
                    console.info("git data::" );
                    console.info(data);
                    var buildData = "branch - " + data["branch"];
                    $("#buildId").text("build " + data['describeShort']).attr("title", buildData);
                    // Assuming your controller method returns JSON
                        // "<p>Commit Branch: " + data['Commit branch'] + "</p>" +
                        // "<p>Commit ID: " + data['Commit id'] + "</p>");
                },
                error: function () {
                    $("#commitData").html("Failed to retrieve commit data.");
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
    </script>
</body>

</html>