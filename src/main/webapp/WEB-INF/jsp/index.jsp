<!doctype html>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="en">

<head>
    <title>WORKHORSE</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- zj: 112803, SOM security started blocking cdn.jsdelivr.net!? -->
    <!-- <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"
integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN"
crossorigin="anonymous"> -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.2/css/bootstrap.min.css"
        integrity="sha512-b2QcS5SsA8tZodcDtGRELiGv5SaKSk1vDHDaQRda0htPYWZ6046lr3kJ5bAAQdpV2mmA/4v0wQF9MyU6/pDIAg=="
        crossorigin="anonymous" referrerpolicy="no-referrer" />

    <link rel="stylesheet" href="/workhorse/css/style.css">
    <link rel="stylesheet" href="/workhorse/css/loading.io.css">
    <link rel="stylesheet" href="/workhorse/css/floatLabels.css">
    <link
        href="https://cdn.datatables.net/v/bs5/dt-1.13.8/b-2.4.2/b-colvis-2.4.2/b-html5-2.4.2/cr-1.7.0/r-2.5.0/sr-1.3.0/datatables.min.css"
        rel="stylesheet">

    <style>
        /* zj: datatables css stuff */
        .dataTables_filter {
            text-align: left !important;
        }

        div.dt-buttons {
            float: right;
        }

        div#kpi_table_wrapper {
            font-size: small;
        }

        #kpi_table_paginate {
            position: relative;
            top: -20px;
        }

        .modal-body label {
            min-width: 150px;
            text-align: right !important;
            font-weight: bold;
        }
        .modal-body input[type=text] {
            width: 60%;
            margin-bottom: 8px;
        }

        #kpi_addNew {
            position: relative;
            top: -31px;
            left: 226px;
        }

        /* font-awesome styles */
        i.fa-regular {
            font-size: large;
        }

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

        .input-group-text:last-of-type {
            min-width: 25px;
            text-align: center;
            display: inline-block;
            padding-left: 0px;
            padding-right: 0;
        }

        .data-tables th,
        .data-tables td {
            white-space: nowrap;
        }
    </style>

</head>

<body>
    <!-- navbar -->
    <nav class="navbar navbar-expand navbar-dark bg-dark">
        <div class="container-fluid">
            <a class="navbar-brand" href="/workhorse">
                <img class="logo" src="/workhorse/img/small-light2.png">
                <span class="ml-2 pt-1">WORKHORSE<small class="version"><a class="nav-link"
                            id="buildId"></a></small>
            </a>
            <!-- <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
        aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button> -->
            <ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-5">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown"
                        aria-expanded="false">
                        Select Action
                    </a>
                    <ul class="dropdown-menu" data-bs-theme="dark">
                        <li><a class="dropdown-item section" id="manual_entry" href="#">Data Entry</a></li>
                                <!-- zj: disabled pending resolution of weblogic upload problems-->
                                <li><a class="dropdown-item section hidden" id="file_operation" href="#">File
                                        Operation</a></li>

                        <li><a class="dropdown-item section" id="kpi_edit" href="#">KPI Data</a></li>
                        <li>
                            <hr class="dropdown-divider">
                        </li>
                        <li class="text-center" style="font-variant: small-caps;">test actions</li>
                        <li>
                            <hr class="dropdown-divider">
                        </li>
                        <!-- <li><a class="dropdown-item" id="exportTest" href="#">Export Test</a></li> -->
                        <li><a class="dropdown-item" id="testData" href="#">load test data</a></li>
                        <!-- <li><a class="dropdown-item" id="storageTest" href="#" disabled>Storage Test</a></li> -->
                        <li><a class="dropdown-item" id="onedriveAuth"
                                href="https://login.microsoftonline.com/common/oauth2/v2.0/authorize?client_id=ddcaa0f6-2021-494f-9680-d924aeb7eacd&scope=https://graph.microsoft.com/.default&response_type=token&redirect_uri=http://localhost:8080/workhorse/">OneDrive
                                auth</a></li>
                    </ul>
                </li>
            </ul>
            <!-- <div class="collapse navbar-collapse" id="navbarSupportedContent">
        
    </div> -->
        </div>
    </nav>

    <!-- section title -->
    <div class="container-fluid my-5">
        <h3 id="section-title"></h3>
        <div class="instructions">
            <p><b><u>BPL Reporting Data Entry proof-of-concept</u></b></p>
            <p>The main idea is a web-based form for data collection. Click the menu above and click "<b>BPL
                    Data Entry</b>" to test the form.
                <br>Saving data saves to the browser's local storage, no data is currently being trasnsmitted or
                saved in any way.
            </p>
            <p>
                        The "<b>KPI Data</b>" action will show all the currently loaded KPI's once the database is
                        loaded.<br>
                <small>(KPI input is currently disabled for testing)</small>
            </p>
            <p>
                The "<b>load test data</b>" action will load the data used to set up the initial reports
            </p>
            <p>
                <a href="/workhorse/h2" target="_blank">h2 testing</a>
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
                                        <input type="file" name="fileinput" id="fileinput"
                                            class="form-control-file">
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
        <div class="btn-group-vertical float-start" role="group" aria-label="Bureau selection">
            <button type="button" class="btn btn-primary test-load">BCC</button>
            <button type="button" class="btn btn-primary test-load">BFS</button>
            <button type="button" class="btn btn-primary test-load">BPL</button>
            <button type="button" class="btn btn-primary test-load">CSCL</button>
        </div>
        <div class="col-xs-10">
            <div class="container" id="test-data"></div>
        </div>
    </div>
    

    <!-- kpi data entry section -->
    <div class="container-fluid hidden" data-section="kpi_edit">
        <div class="row justify-content-center">
            <div class="col-md-12">
                <form id="kpiEdit" class="floatLabels">
                    <input type="hidden" id="username" name="username">
                    <div class="row justify-content-center" id="testdiv"></div>

                    <br>
                    <div class="col-xs-1">
                        <button type="button" class="btn btn-sm btn-secondary" id="kpiSubmit">reload</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <!-- zj: new stuff -->
    

            <!-- // zj: modal-stuff -->
            <!-- kpi modal edit -->
            <div class="modal fade" id="kpiModal" tabindex="-1" aria-labelledby="kpiModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h1 class="modal-title fs-5" id="kpiModalLabel">KPI Entry</h1>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <form id="kpiEditForm">
                                <input type="hidden" id="id" name="id">
                                <label for="bureau">bureau</label>
                                <input type="text" id="bureau" name="bureau" class="required">
                                <br>
                                <label for="historicalData">historicalData</label>
                                <input type="text" id="historicalData" name="historicalData">
                                <br>
                                <label for="dataType">dataType</label>
                                <input type="text" id="dataType" name="dataType">
                                <br>
                                <label for="dataStoreType">dataStoreType</label>
                                <input type="text" id="dataStoreType" name="dataStoreType">
                                <br>
                                <label for="calcDenominator">calcDenominator</label>
                                <input type="text" id="calcDenominator" name="calcDenominator">
                                <br>
                                <label for="target">target</label>
                                <input type="text" id="target" name="target">
                                <br>
                                <label for="rollingAvg">rollingAvg</label>
                                <input type="hidden" name="rollingAvg" value="false">
                                <input type="checkbox" id="rollingAvg" name="rollingAvg" value="true">
                                <br>
                                <label for="access">access</label>
                                <input type="text" id="access" name="access">
                                <br>
                                <label for="requestedBy">requestedBy</label>
                                <input type="text" id="requestedBy" name="requestedBy">
                                <br>
                                <label for="sourceSystem">sourceSystem</label>
                                <input type="text" id="sourceSystem" name="sourceSystem">
                                <br>
                                <label for="dataFeed">dataFeed</label>
                                <input type="text" id="dataFeed" name="dataFeed">
                                <br>
                                <label for="comments">comments</label>
                                <input type="text" id="comments" name="comments">
                                <br>
                                <label for="devComments">devComments</label>
                                <input type="text" id="devComments" name="devComments">
                                <br>
                                <label for="kpi_ID">kpi_ID</label>
                                <input type="text" id="kpi_ID" name="kpi_ID">
                                <br>
                                <label for="kpi_Area">kpi_Area</label>
                                <input type="text" id="kpi_Area" name="kpi_Area">
                                <br>
                                <label for="kpi_Name">kpi_Name</label>
                                <input type="text" id="kpi_Name" name="kpi_Name" class="required">
                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-danger" id="deleteKpi">Delete</button>
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                            <button type="button" class="btn btn-primary" id="saveKpi">Save</button>
                        </div>
                    </div>
                </div>
            </div>


    <!-- footer -->
    <div class="container-fluid">
        <div class="row fixed-bottom">
            <div class="col-lg-12 text-center">
                <div class="alert-dark bg-dark my-0 p-0" id="footer">
                    <small style="top: 10px; position: relative;" class="flash-text" id="footer-text">
                        Web-based Organization and Reporting Kit for High-level Operations and Reliable
                        Systematic Extraction
                    </small>
                    <!-- <h6 class="card-title flash-text"></h6> -->
                    <div class="progress d-none" id="progress" style="height: 50px">
                        <div class="progress-bar progress-bar-striped progress-bar-animated bg-info"
                            id="progressbar" role="progressbar" aria-valuenow="0" aria-valuemin="0"
                            aria-valuemax="100" style="width: 0%;"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script type="text/javascript"
        src="https://alcdn.msauth.net/browser/2.25.0/js/msal-browser.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"
        integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo=" crossorigin="anonymous"></script>
    <!-- zj: 112803, SOM security started blocking cdn.jsdelivr.net!? -->
    <!-- <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
crossorigin="anonymous"></script> -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/2.9.2/umd/popper.min.js"
        integrity="sha512-2rNj2KJ+D8s1ceNasTIex6z4HWyOnEYLVC3FigGOmyQCZc2eBXKgOxQmo3oKLHyfcj53uz4QMsRCWNbLd32Q1g=="
        crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.2/js/bootstrap.min.js"
        integrity="sha512-WW8/jxkELe2CAiE4LvQfwm1rajOS8PHasCCx+knHG0gBHt8EXxS6T6tJRTGuDQVnluuAvMxWF4j8SNFDKceLFg=="
        crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <script
        src="https://cdn.jsdelivr.net/npm/@microsoft/microsoft-graph-client@3.0.0/dist/esm/index.js"></script>

    <script src="/workhorse/js/index.js"></script>
    <script src="/workhorse/js/jquery.numericInput.js"></script>
    <script src="/workhorse/js/floatLabels.js"></script>
            <script
                src="https://cdn.datatables.net/v/bs5/dt-1.13.8/b-2.4.2/b-colvis-2.4.2/b-html5-2.4.2/cr-1.7.0/r-2.5.0/sr-1.3.0/datatables.min.js"></script>
    <script src="https://kit.fontawesome.com/208550a0ca.js" crossorigin="anonymous"></script>
    
    <script>
        $(function () {
            // section buttons
            $("a.section").click(function () {
                $("div.instructions").addClass("hidden");
                $("div[data-section]").addClass("hidden");
                var $this = $(this);
                var section = $this.attr("id");
                $('div[data-section="' + section + '"]').removeClass("hidden");
                $("#section-title").text($this.text());
                // section-specific actions
                if ($this.text() == "KPI Data") {
                    $("#kpiSubmit").click();
                }
                if ($this.text() == "BPL Data Entry") {
                    var kpiSelect = $('#kpiName');
                    kpiSelect.empty(); // Clear existing options
                    ///////////////////////////////////////////////////////////
                    $.ajax({
                        url: 'kpi',  // Replace with the actual URL of your controller mapping
                        type: 'GET',
                        dataType: 'json',
                        success: function(data) {
                            console.info(data);
                            // Populate the select element with fetched data
                            $.each(data, function (index, kpi) {
                                // Create an option element for each KPI
                                var option = $('<option>', {
                                    value: kpi.kpi_ID, // Use the 'id' property for the option value
                                    text: kpi.kpi_Name // Use the 'kpi_ID' property for the option text
                                });

                                // Append the option to the select element
                                kpiSelect.append(option);
                            });
                        },
                        error: function (error) {
                            console.error('Error fetching KPI list:', error);
                        }
                    });
                    ///////////////////////////////////////////////////////////
                }
            });
            // zj: auto-click something on page load
            $("a.section").eq(0).click();

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
            }).focus(function () {
                $yearInput.focus();
            });

            // modify on select
            $("#kpiName").change(function () {
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

            $("#storageTest").click(function () {
                // get previously saved data
                $("#displayData div").empty();
                var savedData = JSON.parse(localStorage.getItem('formData'));
                kpi = $("#kpiName").val();
                if (savedData.hasOwnProperty(kpi)) {
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
                }
            });

            // submit
            $("form#manualEntry").submit(function (e) {
                e.preventDefault();
                var $form = $(this);

                // prompt for username & save to localstorage
                if ("username" in localStorage) {
                    $("#username").val(localStorage.getItem("username"));
                } else {
                    var username = prompt("Please enter your username");
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
                    $("input[type='text']").eq(0).focus();
                    // zj: fix that ^
                }
            });

            // set field attributes on load
            setFieldAttributes();
            // load any saved data on initial pageload
            $("#kpiName").change();

            // test data button
            $("#testData").click(function () {
                loadTestData();
            });

            $("#onedrive").click(function () {
                console.log("onedrive auth 3");
                // Your application's client ID
                var clientId = "ddcaa0f6-2021-494f-9680-d924aeb7eacd";

                // Your OneDrive API scope
                var scope = "onedrive.readwrite";

                // Your redirect URI
                var redirectUri = "http://localhost:8080/workhorse/";

                // The authorization endpoint
                var authEndpoint = "https://login.microsoftonline.com/common/oauth2/v2.0/authorize";

                // Build the authorization URL
                var authUrl = authEndpoint +
                    "?client_id=" + encodeURIComponent(clientId) +
                    "&scope=" + encodeURIComponent(scope) +
                    "&response_type=token" +
                    "&redirect_uri=" + encodeURIComponent(redirectUri);

                var testurl = "https://login.microsoftonline.com/common/oauth2/v2.0/authorize?client_id=ddcaa0f6-2021-494f-9680-d924aeb7eacd&scope=onedrive.readwrite&response_type=token&redirect_uri=http://localhost:8080/workhorse/";
                $.ajax({
                    type: 'GET',
                    crossDomain: true,
                    dataType: 'json',
                    url: testurl,
                    success: function (jsondata) {
                        console.log("success");
                        console.log(JSON.stringify(djsondataata));
                    },
                    error: function (xhr, status, error) {
                        console.error("Error:", status, error);
                    }
                });
            });

            $("#onedriveAuth").click(function () {
                checkSignIn();
                console.info("checking signin...");
            });

            // zj: kpi editing stuff
            $("#kpiSelector").change(function () {
                var kpiId = $(this).val();
                console.info("kpiId=" + kpiId);
            });

            $("#kpiSubmit").click(function (e) {
                e.preventDefault();
                $("#testdiv").text("database not loaded");

                $.ajax({
                    url: 'kpi',
                    type: 'GET',
                    dataType: 'json',
                    success: function (data) {
                        // Build the HTML table
                        var tableHtml = '<table class="table table-striped data-tables" id="kpi_table"><thead><tr>';
                        // Iterate over the fields of the first item to get column names
                        $.each(Object.keys(data[0]), function (index, fieldName) {
                            var colName = (index > 0) ? fieldName : '';
                            tableHtml += '<th scope="col">' + colName + '</th>';
                        });
                        tableHtml += '</tr></thead><tbody>';

                        // Iterate over each item in the JSON data and append a table row
                        $.each(data, function (index, item) {
                            tableHtml += '<tr>';

                            // Iterate over each field in the item and append a table cell
                            $.each(item, function (key, value) {
                                // Add the scope="row" attribute to the first <td> element
                                if (key === Object.keys(item)[0]) {
                                    tableHtml += '<td scope="row" data-id="' + value + '"><i class="fa-regular fa-pen-to-square" alt="edit" data-bs-toggle="modal" data-bs-target="#kpiModal"></i></td>';
                                } else {
                                    tableHtml += '<td>' + value + '</td>';
                                }
                            });
                            tableHtml += '</tr>';
                        });

                        tableHtml += '</tbody></table>';
                        $('#testdiv').html(tableHtml);
                        $("table#kpi_table").DataTable({
                            scrollX: true,
                            colReorder: true,
                            colReorder: {
                                // order: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]
                            },
                            columnDefs: [
                                { "targets": [2, 6, 7, 8], visible: false },
                                { "targets": [0], orderable: false }
                            ],
                            stateSave: true,
                            dom: 'Bf<"toolbar">rtip',
                            buttons: [
                                {
                                    extend: 'colvis',
                                    className: "btn-sm",
                                    columnText: function (dt, idx, title) {
                                        return (idx + 1) + ': ' + title;
                                    }
                                },
                                {
                                    text: 'Reset Columns',
                                    className: "btn-sm",
                                    action: function (e, dt, node, config) {
                                        console.info("deleting dt localstorage");
                                        this.colReorder.reset();
                                        dt.columns(config.show).visible(true);
                                        localStorage.removeItem("DataTables_kpi_table_/workhorse/");
                                    }
                                }
                            ],
                            initComplete: function () {
                                // add edit buttons to table row
                                $("div.toolbar").html('<button type="button" class="btn btn-outline-success btn-sm" id="kpi_addNew" title="add new KPI" data-bs-toggle="modal" data-bs-target="#kpiModal"><i class="fa-solid fa-plus"></i> KPI</button>');
                                // attach click event to addNew button
                                $("div.toolbar").on("click", "#kpi_addNew", function () {
                                    // if actions need to happen on add...
                                    $(":checkbox", "#kpiEditForm").attr("checked", false);

                                    // for the whole "add new" thing we'll need to do some validation...
                                    // diff between editing adn adding...
                                });
                            }
                        });
                        // post datatables-init actions
                        $("ul.pagination", "#kpi_table_paginate").addClass("pagination-sm");
                        $("table#kpi_table").on("click", "i.fa-regular", function () {
                            var id = $(this).parent().attr("data-id");
                            editKpi(id);
                        });

                    },
                    error: function (xhr, status, error) {
                        console.error('Error retrieving JSON data:', error);
                        // Handle error response
                    }
                });

            });


            $("#saveKpi").click(function () {
                $(".error").removeClass("error");
                var $form = $("form#kpiEditForm");
                var id = $("#id", $form).val();
                var kpiData = {};
                
                // validate required fields
                $("input.required").each(function() {
                    if ($(this).val().trim() === '') {
                        $(this).addClass('error');
                    } else {
                        $(this).removeClass('error');
                    }
                });
                if ($(".error").length > 0) {
                    return;
                }
                $('#kpiEditForm').serializeArray().forEach(function (item) {
                    kpiData[item.name] = item.value;
                });
                console.info("kpiData::");
                console.info(JSON.stringify(kpiData));
                
                var operationType = $("#id").val() ? "update" : "new";
                
                // zj: left off here - differentiate between controller methods
                if (operationType == "update") {
                    console.info("updating...");
                    $.ajax({
                        type: 'PUT',
                        url: 'kpi/' + id,
                        contentType: 'application/json',
                        data: JSON.stringify(kpiData),
                        success: function (response) {
                            console.log('KPI updated successfully:', response);
                            showSuccess('KPI updated successfully:', response);
                            // Handle success, e.g., show a success message
                        },
                        error: function (error) {
                            alert('Error updating KPI:', error);
                            // Handle error, e.g., show an error message
                        }
                    });
                } else if (operationType == "new") {
                    console.info("saving new...");
                    $.ajax({
                        type: 'POST',
                        url: 'kpi/',
                        contentType: 'application/json',
                        data: JSON.stringify(kpiData),
                        success: function (response) {
                            console.log('KPI added successfully:', response);
                            showSuccess('KPI added successfully:', response);
                            // Handle success, e.g., show a success message
                        },
                        error: function (error) {
                            alert('Error updating KPI:', error);
                            // Handle error, e.g., show an error message
                        }
                    });
                }


            });

            $("#deleteKpi").click(function () {
                var id = $("#id", "form#kpiEditForm").val();
                $.ajax({
                    type: 'DELETE',
                    contentType: 'application/json',
                    url: 'kpi/' + id,
                    success: function (response) {
                        console.log(response);
                        showSuccess(response);
                    },
                    error: function (error) {
                        alert("error deleting KPI:", error);
                        console.error('Error deleting KPI:', error);
                        // Handle error, e.g., show an error message
                    }
                });

            });

            $("#kpiModal").on('hidden.bs.modal', function() {
                console.info("closing modal, reset form");
                $("form#kpiEditForm")[0].reset();
            });

            $(".test-load").click(function() {
                $.ajax({
                    url: 'records',
                    type: 'GET',
                    dataType: 'json',
                    success: function(response) {
                        var $testDiv = $('#test-data');
                        for (var i = 0; i < response.length; i++) {
                            var record = response[i];
                            var recordLine = '';
                            for (var key in record) {
                                if (record.hasOwnProperty(key)) {
                                    recordLine += key + ': ' + record[key] + ' | ';
                                }
                            }
                            // Append the record line to the test-div
                            console.info("recordLine=" + recordLine);
                            $testDiv.append('<div>' + recordLine + '</div>');
                        }
                    },
                    error: function(error) {
                        console.error('Error fetching record list:', error);
                    }
                });
            });
            

        });

        <!-- // zj: modal-stuff -->
        // edit kpi
        function editKpi(id) {
            $.ajax({
                url: 'kpi/' + id,
                type: 'GET',
                dataType: 'json',
                success: function (data) {
                    $.each(data, function (key, value) {
                        // handle booleans
                        if (value === true || value === false) {
                            console.info(key + " -- " + value + " (BOOLEAN)");
                            $("#" + key).attr("checked", value);
                        } else {
                            console.info(key + " -- " + value);
                            $("#" + key).val(value);
                        }
                        // var $element = "<input id='" + key + "' name='" + key + "' value='" + value + "'>";
                        // $("div.modal-body", "#kpiModal").append($element + "<br>");
                    });

                },
                error: function (xhr, status, error) {
                    alert("ERROR");
                    console.error('Error retrieving JSON data:', error);
                    // Handle error response
                }
            });
        }

                function showSuccess(message) {
                        $('#kpiModal').modal('hide');
                        $("#kpiSubmit").click();

                        // Create a new toast element
                        var toast = $('<div class="toast bg-success text-white" role="alert" aria-live="assertive" aria-atomic="true" data-delay="8000" style="position: absolute; top: 100px; left: 50%; transform: translateX(-50%);"><div class="toast-body">' + message + '</div></div>');

                        // Append the toast to the body
                        $('body').append(toast);

                        // Show the toast
                        toast.toast('show');

                        // Remove the toast after it is hidden
                        toast.on('hidden.bs.toast', function () {
                            toast.remove();
                        });
                    }

        // zj: msal stuff
        function checkSignIn() {
            console.info("starting checkSignIn function");
            // Configuration for MSAL using the common endpoint
            const msalConfig = {
                auth: {
                    // clientId: 'your-client-id', // This is required but can be any valid client ID
                    clientId: 'ddcaa0f6-2021-494f-9680-d924aeb7eacd',
                    authority: 'https://login.microsoftonline.com/common',
                    redirectUri: 'http://localhost:8080/workhorse/',
                },
                cache: {
                    cacheLocation: 'localStorage',
                }
            };

            // Instantiate MSAL
            const myMSALObj = new Msal.UserAgentApplication(msalConfig);

            // Check if user is signed in
            const user = myMSALObj.getAccount();

            if (user) {
                // User is signed in
                alert('Signed in as ' + user.username);
            } else {
                // User is not signed in, prompt for login
                signIn(myMSALObj);
            }
        }

        // Sign in function
        function signIn(msalObj) {
            msalObj.loginPopup().then(response => {
                // Successful login
                alert('Signed in as ' + response.account.username);
            }).catch(error => {
                // Handle errors
                console.error(error);
            });
        }

        // zj: end msal stuff


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
            // blank inputs & apply numeric-input plugin
            $('input[type="text"]', ".month-data").val("").numeric();
            // populate form data for given kpi/year
            var savedData = localStorage.getItem('formData');
            if (savedData) {
                var formDataObject = JSON.parse(savedData);
                if (formDataObject.hasOwnProperty(kpi)) {
                    if (formDataObject[kpi][year]) {
                        $('input[type="text"]', ".month-data").val("").each(function () {
                            var fieldName = $(this).attr('name');
                            $(this).val(formDataObject[kpi][year][fieldName]);
                        });
                    } else {
                        $('input[type="text"]', ".month-data").val("");
                    }
                }
            }
        }

        function setFieldAttributes() {
            // set form attributes
            var year = $("#year-input").val();
            $('input[type="text"]', ".month-data").each(function (i) {
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
            var test_json = { "BPL_01": { "2021": { "username": "username-test", "1/1/2021": "", "2/1/2021": "", "3/1/2021": "", "4/1/2021": "", "5/1/2021": "", "6/1/2021": "", "7/1/2021": "", "8/1/2021": "", "9/1/2021": "68", "10/1/2021": "78", "11/1/2021": "63", "12/1/2021": "68" }, "2022": { "username": "username-test", "1/1/2022": "76", "2/1/2022": "76", "3/1/2022": "63", "4/1/2022": "76", "5/1/2022": "79", "6/1/2022": "87", "7/1/2022": "77", "8/1/2022": "80", "9/1/2022": "83", "10/1/2022": "80", "11/1/2022": "85", "12/1/2022": "63" }, "2023": { "username": "username-test", "1/1/2023": "76", "2/1/2023": "76", "3/1/2023": "50", "4/1/2023": "77", "5/1/2023": "90", "6/1/2023": "95", "7/1/2023": "63", "8/1/2023": "85", "9/1/2023": "77", "10/1/2023": "78", "11/1/2023": "84", "12/1/2023": "79" } }, "BPL_02": { "2021": { "username": "username-test", "1/1/2021": "", "2/1/2021": "", "3/1/2021": "", "4/1/2021": "", "5/1/2021": "", "6/1/2021": "", "7/1/2021": "", "8/1/2021": "", "9/1/2021": "77", "10/1/2021": "78", "11/1/2021": "84", "12/1/2021": "79" }, "2022": { "username": "username-test", "1/1/2022": "83", "2/1/2022": "60", "3/1/2022": "69", "4/1/2022": "81", "5/1/2022": "73", "6/1/2022": "68", "7/1/2022": "71", "8/1/2022": "83", "9/1/2022": "66", "10/1/2022": "84", "11/1/2022": "88", "12/1/2022": "79" }, "2023": { "username": "username-test", "1/1/2023": "76", "2/1/2023": "83", "3/1/2023": "85", "4/1/2023": "81", "5/1/2023": "83", "6/1/2023": "81", "7/1/2023": "86", "8/1/2023": "80", "9/1/2023": "", "10/1/2023": "", "11/1/2023": "", "12/1/2023": "" } }, "BPL_03": { "2021": { "username": "username-test", "1/1/2021": "", "2/1/2021": "", "3/1/2021": "", "4/1/2021": "", "5/1/2021": "", "6/1/2021": "", "7/1/2021": "", "8/1/2021": "", "9/1/2021": "58", "10/1/2021": "68", "11/1/2021": "68", "12/1/2021": "67" }, "2022": { "username": "username-test", "1/1/2022": "73", "2/1/2022": "85", "3/1/2022": "90", "4/1/2022": "97", "5/1/2022": "88", "6/1/2022": "90", "7/1/2022": "90", "8/1/2022": "92", "9/1/2022": "90", "10/1/2022": "98", "11/1/2022": "95", "12/1/2022": "100" }, "2023": { "username": "username-test", "1/1/2023": "95", "2/1/2023": "99", "3/1/2023": "100", "4/1/2023": "98", "5/1/2023": "100", "6/1/2023": "96", "7/1/2023": "100", "8/1/2023": "95", "9/1/2023": "", "10/1/2023": "", "11/1/2023": "", "12/1/2023": "" } }, "BPL_04": { "2021": { "username": "username-test", "1/1/2021": "", "2/1/2021": "", "3/1/2021": "", "4/1/2021": "", "5/1/2021": "", "6/1/2021": "", "7/1/2021": "", "8/1/2021": "", "9/1/2021": "100", "10/1/2021": "150", "11/1/2021": "75", "12/1/2021": "36" }, "2022": { "username": "username-test", "1/1/2022": "98", "2/1/2022": "145", "3/1/2022": "250", "4/1/2022": "145", "5/1/2022": "78", "6/1/2022": "42", "7/1/2022": "59", "8/1/2022": "87", "9/1/2022": "57", "10/1/2022": "43", "11/1/2022": "25", "12/1/2022": "116" }, "2023": { "username": "username-test", "1/1/2023": "92", "2/1/2023": "48", "3/1/2023": "73", "4/1/2023": "79", "5/1/2023": "135", "6/1/2023": "38", "7/1/2023": "72", "8/1/2023": "99", "9/1/2023": "", "10/1/2023": "", "11/1/2023": "", "12/1/2023": "" } }, "BPL_05": { "2021": { "username": "username-test", "1/1/2021": "", "2/1/2021": "", "3/1/2021": "", "4/1/2021": "", "5/1/2021": "", "6/1/2021": "", "7/1/2021": "", "8/1/2021": "", "9/1/2021": "59", "10/1/2021": "87", "11/1/2021": "57", "12/1/2021": "43" }, "2022": { "username": "username-test", "1/1/2022": "25", "2/1/2022": "116", "3/1/2022": "92", "4/1/2022": "48", "5/1/2022": "73", "6/1/2022": "79", "7/1/2022": "135", "8/1/2022": "38", "9/1/2022": "72", "10/1/2022": "99", "11/1/2022": "100", "12/1/2022": "150" }, "2023": { "username": "username-test", "1/1/2023": "75", "2/1/2023": "36", "3/1/2023": "98", "4/1/2023": "145", "5/1/2023": "111", "6/1/2023": "125", "7/1/2023": "150", "8/1/2023": "175", "9/1/2023": "", "10/1/2023": "", "11/1/2023": "", "12/1/2023": "" } } };
            localStorage.setItem("username", "username-test");
            localStorage.setItem("formData", JSON.stringify(test_json));
        }


    </script>
</body>