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
                            <li><a class="dropdown-item section" id="file_operation" href="#">File Operation</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li class="text-center" style="font-variant: small-caps;">test actions</li>
                            <li><hr class="dropdown-divider"></li>
                            <!-- <li><a class="dropdown-item" id="exportTest" href="#">Export Test</a></li> -->
                            <li><a class="dropdown-item" id="testData" href="#">load test data</a></li>
                            <!-- <li><a class="dropdown-item" id="storageTest" href="#" disabled>Storage Test</a></li> -->
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- section title -->
    <div class="container-fluid my-5">
        <h3 id="section-title"></h3>
        <div class="instructions">
            <p><b><u>BPL Reporting Data Entry proof-of-concept</u></b></p>
            <p>The main idea is a web-based form for data collection. Click the menu above and click "<b>BPL Data Entry</b>" to test the form.
                <br>Saving data saves to the browser's local storage, no data is currently being trasnsmitted or saved in any way.</p>
            <p>We can also process an Excel data-file if need be, choose "<b>File Operation</b>" in the menu above to test the file operation.
                <br>(but file operation doesn't currently have visible output)
            </p>
            <p>
                The "<b>load test data</b>" action will load the data from Dennis that Sateesh used to set up the initial reports.
            </p>
            
        </div>
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
        <div class="page-content hide">
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
        <div class="row justify-content-center">
            <div class="col-md-8">
                <!-- zj: mostly skeletal form, id's & name's get populated via script -->
                <form id="manualEntry">
                    <input type="hidden" id="username" name="username">
                    <div class="row mb-3">
                        <div class="input-group">
                            <select class="form-select" id="kpiName" aria-label="kpi name">
                                <option value="BPL_01">PDM complete investigations within 120 days</option>
                                <option value="BPL_02">PHC investigations completed within 120 days</option>
                                <option value="BPL_03">OCC investigations completed within 120 days</option>
                                <option value="BPL_04">Complaints received</option>
                                <option value="BPL_05">Complaints closed</option>
                            </select>
                        </div>
                    </div>

                    <!-- loaded data row -->
                    <div class="row mb-3" id="displayData">
                        <div class="col-lg-12" style="min-height: 31px;">
                            
                        </div>
                    </div>

                    <div class="row mb-3">
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
                    <div class="row month-data">
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
                    <div class="row month-data">
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
                    <div class="row month-data">
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
                $("div.instructions").addClass("hidden");
                $("div[data-section]").addClass("hidden");
                var $this = $(this);
                var section = $this.attr("id");
                $('div[data-section="' + section + '"]').removeClass("hidden");
                $("#section-title").text($this.text());
            });
            // $("a.section:first").click();

            // get current year
            var currentYear = new Date().getFullYear();
            var $yearInput = $('#year-input');
            $yearInput.val(currentYear);

            // arrow buttons for year select
            $('.year-btn').click(function () {
                var action = $(this).attr("data-action");
                if (action === "-") {
                    currentYear--;
                } else {
                    currentYear++;
                }
                $yearInput.val(currentYear);
                highlight($(this));
                setFieldAttributes();
                populateData($("#kpiName").val(), currentYear);
                analyzeData();
            }).focus(function() {
                $yearInput.focus();
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
                populateData(val, $("#year-input").val());
                analyzeData();
            });

            $("#storageTest").click(function() {
                // get previously saved data
                $("#displayData div").empty();
                var savedData = JSON.parse(localStorage.getItem('formData'));
                kpi = $("#kpiName").val();
                if (savedData.hasOwnProperty(kpi)) {
                    var years = Object.keys(savedData[kpi]);
                    $.each(years, function(index, year) {
                        $("#displayData div").append("<a class='btn btn-sm year-badge btn-outline-success mx-1' title='load " + year + " data'>" + year + "</a>");
                    });
                    $("a.year-badge").click(function() {
                        var year = $(this).text();
                        $("#year-input").val(year);
                        setFieldAttributes();
                        populateData(kpi, year);
                    });
                }
            });

            // submit
            $("form#manualEntry").submit(function(e) {
                e.preventDefault();
                var $form = $(this);
                
                // prompt for username & save to localstorage
                if ("username" in localStorage) {
                    $("#username").val(localStorage.getItem("username"));
                } else {
                    var username=prompt("Please enter your username");
                    localStorage.setItem("username", username);
                    $("#username").val(username);
                }
                
                // get previously saved data
                var savedData = JSON.parse(localStorage.getItem('formData'));
                
                // serialize form data to json
                var formData = $form.serializeArray();
                var kpi = $("#kpiName").val();
                var newData = {};
                newData[kpi] = {};
                var year = $("#year-input").val();
                newData[kpi][year] = {};
                formData.forEach(function (field, index) {
                    newData[kpi][year][field.name] = field.value;
                });

                var finalObj = $.extend(true, {}, savedData, newData);
                localStorage.setItem('formData', JSON.stringify(finalObj));
                alert('Form data serialized and saved to local storage.');
            });

            // Keyboard arrow key event listeners
            $("#year-input").keydown(function (e) {
                if (e.which === 37 || e.which === 40) { // left & up arrow keys
                    $('.year-btn').eq(0).click();
                } else if (e.which === 39 || e.which === 38) { // right & down arrow key
                    $('.year-btn').eq(1).click();
                } else if (e.which === 9 && e.shiftKey) { // tab key
                    e.preventDefault();
                    $("#kpiName").focus();
                } else if (e.which === 9) { // tab key
                    e.preventDefault();
                    $("input[type='number']").eq(0).focus();
                }
            });

            // set field attributes on load
            setFieldAttributes();
            // load any saved data on initial pageload
            $("#kpiName").change();

            // test data button
            $("#testData").click(function() {
                loadTestData();
            });
        });

        function exportTest() {
            console.info("hi");
        }

        function analyzeData() {
            // analyze saved data
            $("#displayData div").empty();
            var savedData = JSON.parse(localStorage.getItem('formData'));
            kpi = $("#kpiName").val();
            if (savedData && savedData.hasOwnProperty(kpi)) {
                var years = Object.keys(savedData[kpi]);
                $.each(years, function (index, year) {
                    $("#displayData div").append("<a class='btn btn-sm year-badge btn-outline-success mx-1' title='load " + year + " data'>" + year + "</a>");
                });
                $("a.year-badge").click(function () {
                    var year = $(this).text();
                    $("#year-input").val(year);
                    setFieldAttributes();
                    populateData(kpi, year);
                });
            } else {
                console.debug("no saved data found");
            }
        }

        function populateData(kpi, year) {
            // populate form data for given kpi/year
            var savedData = localStorage.getItem('formData');
            if (savedData) {
                var formDataObject = JSON.parse(savedData);
                if (formDataObject.hasOwnProperty(kpi)) {
                    if (formDataObject[kpi][year]) {
                        $('input[type="number"]', ".month-data").val("").each(function () {
                            var fieldName = $(this).attr('name');
                            $(this).val(formDataObject[kpi][year][fieldName]);
                        });
                    } else {
                        $('input[type="number"]', ".month-data").val("");
                    }
                } else {
                    $('input[type="number"]', ".month-data").val("");
                }
            } else {
                $('input[type="number"]', ".month-data").val("");
            }

        }

        function setFieldAttributes() {
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

        function loadTestData() {
            var test_json = {"BPL_01":{"2021":{"username":"username-test","1/1/2021":"","2/1/2021":"","3/1/2021":"","4/1/2021":"","5/1/2021":"","6/1/2021":"","7/1/2021":"","8/1/2021":"","9/1/2021":"68","10/1/2021":"78","11/1/2021":"63","12/1/2021":"68"},"2022":{"username":"username-test","1/1/2022":"76","2/1/2022":"76","3/1/2022":"63","4/1/2022":"76","5/1/2022":"79","6/1/2022":"87","7/1/2022":"77","8/1/2022":"80","9/1/2022":"83","10/1/2022":"80","11/1/2022":"85","12/1/2022":"63"},"2023":{"username":"username-test","1/1/2023":"76","2/1/2023":"76","3/1/2023":"50","4/1/2023":"77","5/1/2023":"90","6/1/2023":"95","7/1/2023":"63","8/1/2023":"85","9/1/2023":"77","10/1/2023":"78","11/1/2023":"84","12/1/2023":"79"}},"BPL_02":{"2021":{"username":"username-test","1/1/2021":"","2/1/2021":"","3/1/2021":"","4/1/2021":"","5/1/2021":"","6/1/2021":"","7/1/2021":"","8/1/2021":"","9/1/2021":"77","10/1/2021":"78","11/1/2021":"84","12/1/2021":"79"},"2022":{"username":"username-test","1/1/2022":"83","2/1/2022":"60","3/1/2022":"69","4/1/2022":"81","5/1/2022":"73","6/1/2022":"68","7/1/2022":"71","8/1/2022":"83","9/1/2022":"66","10/1/2022":"84","11/1/2022":"88","12/1/2022":"79"},"2023":{"username":"username-test","1/1/2023":"76","2/1/2023":"83","3/1/2023":"85","4/1/2023":"81","5/1/2023":"83","6/1/2023":"81","7/1/2023":"86","8/1/2023":"80","9/1/2023":"","10/1/2023":"","11/1/2023":"","12/1/2023":""}},"BPL_03":{"2021":{"username":"username-test","1/1/2021":"","2/1/2021":"","3/1/2021":"","4/1/2021":"","5/1/2021":"","6/1/2021":"","7/1/2021":"","8/1/2021":"","9/1/2021":"58","10/1/2021":"68","11/1/2021":"68","12/1/2021":"67"},"2022":{"username":"username-test","1/1/2022":"73","2/1/2022":"85","3/1/2022":"90","4/1/2022":"97","5/1/2022":"88","6/1/2022":"90","7/1/2022":"90","8/1/2022":"92","9/1/2022":"90","10/1/2022":"98","11/1/2022":"95","12/1/2022":"100"},"2023":{"username":"username-test","1/1/2023":"95","2/1/2023":"99","3/1/2023":"100","4/1/2023":"98","5/1/2023":"100","6/1/2023":"96","7/1/2023":"100","8/1/2023":"95","9/1/2023":"","10/1/2023":"","11/1/2023":"","12/1/2023":""}},"BPL_04":{"2021":{"username":"username-test","1/1/2021":"","2/1/2021":"","3/1/2021":"","4/1/2021":"","5/1/2021":"","6/1/2021":"","7/1/2021":"","8/1/2021":"","9/1/2021":"100","10/1/2021":"150","11/1/2021":"75","12/1/2021":"36"},"2022":{"username":"username-test","1/1/2022":"98","2/1/2022":"145","3/1/2022":"250","4/1/2022":"145","5/1/2022":"78","6/1/2022":"42","7/1/2022":"59","8/1/2022":"87","9/1/2022":"57","10/1/2022":"43","11/1/2022":"25","12/1/2022":"116"},"2023":{"username":"username-test","1/1/2023":"92","2/1/2023":"48","3/1/2023":"73","4/1/2023":"79","5/1/2023":"135","6/1/2023":"38","7/1/2023":"72","8/1/2023":"99","9/1/2023":"","10/1/2023":"","11/1/2023":"","12/1/2023":""}},"BPL_05":{"2021":{"username":"username-test","1/1/2021":"","2/1/2021":"","3/1/2021":"","4/1/2021":"","5/1/2021":"","6/1/2021":"","7/1/2021":"","8/1/2021":"","9/1/2021":"59","10/1/2021":"87","11/1/2021":"57","12/1/2021":"43"},"2022":{"username":"username-test","1/1/2022":"25","2/1/2022":"116","3/1/2022":"92","4/1/2022":"48","5/1/2022":"73","6/1/2022":"79","7/1/2022":"135","8/1/2022":"38","9/1/2022":"72","10/1/2022":"99","11/1/2022":"100","12/1/2022":"150"},"2023":{"username":"username-test","1/1/2023":"75","2/1/2023":"36","3/1/2023":"98","4/1/2023":"145","5/1/2023":"111","6/1/2023":"125","7/1/2023":"150","8/1/2023":"175","9/1/2023":"","10/1/2023":"","11/1/2023":"","12/1/2023":""}}};
            localStorage.setItem("username", "username-test");
            localStorage.setItem("formData", JSON.stringify(test_json));
        }
        

    </script>
</body>
