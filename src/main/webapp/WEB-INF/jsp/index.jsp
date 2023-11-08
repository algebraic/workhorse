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

    <link rel="stylesheet" href="/workhorse/css/style.css">
    <link rel="stylesheet" href="/workhorse/css/loading.io.css">


    <style>
        /* zj: move this junk into style.css at some point */
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

        .highlight-button {
            background: yellow;
        }
        .input-group-text:first-of-type {
            width: 100px;
            overflow: visible;
        }
    </style>

</head>

<body>
    <!-- navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container-fluid">
            <a class="navbar-brand" href="/workhorse">
                <img class="logo" src="/workhorse/img/small-light2.png">
                <span class="ml-2 pt-1">WORKHORSE<small class="version"><a class="nav-link" id="buildId"></a></small>
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
                aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-5">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            Select Action
                        </a>
                        <ul class="dropdown-menu" data-bs-theme="dark">
                            <li><a class="dropdown-item section" id="manual_entry" href="#">BPL Data Entry</a></li>
                            <li>
                                <hr class="dropdown-divider">
                            </li>
                            <li><a class="dropdown-item section" id="file_operation" href="#">File Operation</a></li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

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
        <br>
        <h3 class="form-title">BPL Data Entry</h3>
        <br>
        <div class="row justify-content-center">
            <div class="col-md-8">
                <!-- zj: mostly skeletal form, id's & name's get populated via script -->
                <form id="manualEntry">
                    <input type="hidden" id="username" name="username">
                    <div class="mb-3">
                        <select class="form-select" id="kpiName" aria-label="kpi name">
                            <option value="BPL_01">PDM complete investigations within 120 days</option>
                            <option value="BPL_02">PHC investigations completed within 120 days</option>
                            <option value="BPL_03">OCC investigations completed within 120 days</option>
                            <option value="BPL_04">Complaints received</option>
                            <option value="BPL_05">Complaints closed</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <div class="input-group">
                            <button class="btn btn-outline-secondary year-btn" data-action="-" type="button"><</button>
                            <input type="text" class="form-control text-center" id="year-input" readonly>
                            <button class="btn btn-outline-secondary year-btn" data-action="+" type="button">></button>
                        </div>
                    </div>

                    <div class="row month-data">
                        <div class="col-md-4">
                            <div class="input-group mb-3">
                                <span class="input-group-text">January</span>
                                <input type="number" class="form-control">
                                <span class="input-group-text">%</span>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="input-group mb-3">
                                <span class="input-group-text">February</span>
                                <input type="number" class="form-control">
                                <span class="input-group-text">%</span>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="input-group mb-3">
                                <span class="input-group-text">March</span>
                                <input type="number" class="form-control">
                                <span class="input-group-text">%</span>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-4">
                            <div class="input-group mb-3">
                                <span class="input-group-text">April</span>
                                <input type="number" class="form-control">
                                <span class="input-group-text">%</span>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="input-group mb-3">
                                <span class="input-group-text">May</span>
                                <input type="number" class="form-control">
                                <span class="input-group-text">%</span>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="input-group mb-3">
                                <span class="input-group-text">June</span>
                                <input type="number" class="form-control">
                                <span class="input-group-text">%</span>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-4">
                            <div class="input-group mb-3">
                                <span class="input-group-text">July</span>
                                <input type="number" class="form-control">
                                <span class="input-group-text">%</span>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="input-group mb-3">
                                <span class="input-group-text">August</span>
                                <input type="number" class="form-control">
                                <span class="input-group-text">%</span>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="input-group mb-3">
                                <span class="input-group-text">September</span>
                                <input type="number" class="form-control">
                                <span class="input-group-text">%</span>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-4">
                            <div class="input-group mb-3">
                                <span class="input-group-text">October</span>
                                <input type="number" class="form-control">
                                <span class="input-group-text">%</span>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="input-group mb-3">
                                <span class="input-group-text">November</span>
                                <input type="number" class="form-control">
                                <span class="input-group-text">%</span>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="input-group mb-3">
                                <span class="input-group-text">December</span>
                                <input type="number" class="form-control">
                                <span class="input-group-text">%</span>
                            </div>
                        </div>
                    </div>
                    <div class="row justify-content-center">
                        <button type="submit" class="btn btn-primary">Submit</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- footer -->
    <div class="container-fluid">
        <div class="row fixed-bottom">
            <div class="col-lg-12 text-center">
                <div class="alert-dark bg-dark my-0 p-0" id="footer">
                    <button type="button" class="btn btn-sm btn-outline-secondary float-start mt-2" id="test-data">test data</button>
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
            $("a.section:first").click();

            // get current year
            var currentYear = new Date().getFullYear();
            var yearInput = $('#year-input');
            yearInput.val(currentYear);

            // arrow buttons for year select
            $('.year-btn').click(function () {
                var action = $(this).attr("data-action");
                if (action === "-") {
                    currentYear--;
                } else {
                    currentYear++;
                }
                yearInput.val(currentYear);
                highlight($(this));
                setFieldAttributes();
                // populateData($("#kpiName").val(), currentYear);
            });

            // modify on select
            $("#kpiName").change(function() {
                var val = $(this).val();
                if (val === "BPL_04" || val === "BPL_05") {
                    $("span.input-group-text:last", ".input-group").text("#");
                } else {
                    $("span.input-group-text:last", ".input-group").text("%");
                }
                setFieldAttributes();
                // populateData(val, $("#year-input").val());
            });

            // submit
            $("form#manualEntry").submit(function (e) {
                e.preventDefault();
                var $form = $(this);
                
                // get previously saved data
                var savedData = {};
                if (localStorage.formData) {
                    savedData = JSON.parse(localStorage.formData);
                    console.info("savedData");
                    console.info(savedData);
                } else {
                    console.log("no saved data found");
                }

                // Serialize form data to a JSON object
                var formData = $form.serializeArray();
                var kpi = $("#kpiName").val();
                console.log("@ kpi = " + kpi);
                savedData[kpi] = {};
                var year = $("#year-input").val();
                console.log("@ year = " + year);
                savedData[kpi][year] = {};
                formData.forEach(function (field, index) {
                    console.log("@@ field = " + field.name + " -- " + field.value);
                    // console.info(index + " -- " + field + " -- " + kpi);
                    savedData[kpi][year][field.name] = field.value;
                });

                // Convert the JSON object to a string and save it to local storage
                localStorage.setItem('formData', JSON.stringify(savedData));
                alert('Form data serialized and saved to local storage.');
            });

            // Keyboard arrow key event listeners
            $("#year-input").keydown(function (e) {
                if (e.which === 37 || e.which === 40) { // Left arrow key
                    $('.year-btn').eq(0).click();
                } else if (e.which === 39 || e.which === 38) { // Right arrow key
                    $('.year-btn').eq(1).click();
                }
            });

            // set field attributes on load
            setFieldAttributes();

            // test data button
            $("#test-data").click(function() {
                testData();
            });
        });

        function populateData1(kpi, year) {
            // populate form data for given kpi
            console.info("kpi=" + kpi);

            // Retrieve data from local storage
            var storedData = localStorage.getItem('formData');
            if (storedData) {
                // Parse the stored JSON data
                var formDataObject = JSON.parse(storedData);

                if (formDataObject.hasOwnProperty(kpi)) {
                    var year = Object.keys(formDataObject[kpi]);
                    console.warn("year=" + year);
                    // $("#year-input").val(year);
                    // iterate over form fields & set values
                    $('input[type="number"]', ".month-data").val("").each(function () {
                        var fieldName = $(this).attr('name');
                        $(this).val(formDataObject[kpi][year][fieldName]);
                    });
                }
                // console.warn("hasOwnProperty(kpi)=" + formDataObject.hasOwnProperty(kpi));


                // // Iterate over the form fields and set their values
                // var kpi = Object.keys(formDataObject)[0];
                // $("#kpiName").val(kpi);
                // var year = Object.keys(formDataObject[kpi]);
                // console.info("Year="  + year);
                // $('#manualEntry input').each(function () {
                //     var fieldName = $(this).attr('name');
                //     $(this).val(formDataObject[kpi][year][fieldName]);
                // });
                // $("#year-input").val(year);
            } else {
                $('input[type="number"]', ".month-data").val("");
            }

        }

        function setFieldAttributes() {
            console.log("%%% setFieldAttributes %%%")
            // set form attributes
            var year = $("#year-input").val();
            $("input[type='number']", "#manualEntry").each(function (i) {
                var $this = $(this);
                $this.attr("name", i + 1 + "/1/" + year);
            });
        }

        function highlight(button) {
            button.addClass('btn-warning');
            setTimeout(function () {
                button.removeClass('btn-warning');
            }, 100);
        }

        function testData() {
            $("input[type='number']", "#manualEntry").each(function (i) {
                var $this = $(this);
                var index = $("input[type='number']", "#manualEntry").index($this);
                $this.val(index+1);
            });
        }
        

    </script>
</body>
