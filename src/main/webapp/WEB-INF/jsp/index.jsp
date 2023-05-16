<!DOCTYPE html>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <html>

        <script src="https://code.jquery.com/jquery-3.4.1.min.js"
            integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo=" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.bundle.min.js"
            integrity="sha384-xrRywqdh3PHs8keKZN+8zzc5TX0GRTLCcmivcbNJWm2rs5C8PRhcEn3czEjhAO9o"
            crossorigin="anonymous"></script>
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet"
            integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
            integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
            crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.bundle.min.js"
            integrity="sha384-xrRywqdh3PHs8keKZN+8zzc5TX0GRTLCcmivcbNJWm2rs5C8PRhcEn3czEjhAO9o"
            crossorigin="anonymous"></script>

        <script src="/workhorse/js/material.float.labels.js"></script>
        <link rel="stylesheet" href="/workhorse/css/material.float.labels.css">

        <link rel="stylesheet" href="/workhorse/css/style.css">
        <link rel="stylesheet" href="/workhorse/css/loading.io.css">

        <link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote-bs4.css" rel="stylesheet">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote-bs4.js"></script>
        <script src="https://kit.fontawesome.com/208550a0ca.js"></script>

        <script src="/workhorse/js/index.js"></script>


        <head>
            <title>WORKHORSE</title>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
            <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

            <style>
                span.first-letter {
                    text-shadow: -1px -1px rgba(0, 0, 255, 0.5);
                }
            </style>

            <script>
                $(function () {
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


        </head>

        <body>

            <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
                <a class="navbar-brand" href="/workhorse">
                    <img src="/workhorse/img/dtmb_small.png">
                    <span class="ml-2 pt-1">WORKHORSE <small>version 0.0.1</small>
                </a>
                <div class="form-group drive-buttons hide mb-0" style="position:absolute; right:0px;">
                    <a class="nav-link" href="#" id="config" title="config"><i
                            class="fas fa-cogs fa-lg text-light"></i></a>
                </div>

            </nav>

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
                                <h6 class="card-title flash-text">Web-based Organization and Reporting Kit for
                                    High-level
                                    Operations and Reliable Systematic Extraction</h6>
                                <div class="card">
                                    <div class="card-body">
                                        <h6 class="my-4">Select data file:</h6>
                                        <div class="form-group">
                                            <input type="file" name="fileinput" id="fileinput"
                                                class="form-control-file">
                                            <div class="lds-hourglass-sm d-none" id="loading">
                                                <div></div>
                                                <div></div>
                                            </div>
                                            <small id="file-note" class="text-info">should be xls or xlsx? we'll need
                                                sample data files to be precise</small>
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

                    <div class="row fixed-bottom">
                        <div class="col-lg-12 text-center">
                            <div class="alert-dark bg-dark my-0 p-0 text-light" id="footer">
                                <small style="top: 10px; position: relative;" id="footer-text">test app for BCC
                                    Dashboards effort</small>
                                <!-- emails addresses must be in a csv file with "email" as the first item -->
                                <div class="progress d-none" id="progress" style="height: 50px">
                                    <div class="progress-bar progress-bar-striped progress-bar-animated bg-info"
                                        id="progressbar" role="progressbar" aria-valuenow="0" aria-valuemin="0"
                                        aria-valuemax="100" style="width: 0%;"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>

        </body>

        </html>