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

            <link rel="stylesheet" href="/workhorse/css/dataEntry.css">

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

                #apiListModal dt {
                    font-family: monospace;
                    background-color: #f4f4f4;
                    color: #333;
                    padding: 0.5em;
                    border-radius: 5px;
                    margin-bottom: 5px;
                    display: inline-block;
                }

                #apiListModal dd {
                    padding-bottom: 20px;
                }

                .tableDisplay {
                    margin-bottom: 20px;
                }

                .tableDisplay td:first-child {
                    padding-right: 20px;
                }

                textarea.sql {
                    width: 600px;
                    height: 150px;
                }

                input.changed {
                    border-color: var(--bs-warning);
                }
            
                .entry_select {
                    color: black;
                    border: none;
                    font-weight: bold;
                    font-size: x-large;
                    width: 100%;
                    background: none;
                    cursor: pointer;
                }
                #kpi_title {
                    font-variant: small-caps;
                    font-size: large;
                }
                #saveRecord {
                    width:100px;
                }
                .record-data {
                    background: none;
                    border: none;
                    padding: 4px;
                }
                tr td:first-child {
                    vertical-align: middle;
                }
                table#kpi_table_entry {
                    /* width: 45% !important; */
                }
            </style>

        </head>

        <body>
            <!-- navbar -->
            <nav class="navbar navbar-expand navbar-dark bg-dark">
                <div class="container-fluid">
                    <a class="navbar-brand" href="/workhorse">
                        <img class="logo" src="/workhorse/img/small-light2.png">
                        <span class="ml-2 pt-1">WORKHORSE <small class="version">
                                <a class="nav-link" id="buildId"></a></small>
                        </span>
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
                                <li><a class="dropdown-item section hidden" id="file_operation" href="#">File Operation</a></li>
                                <li><a class="dropdown-item section" id="kpi_edit" href="#">KPI Data</a></li>
                                <li>
                                    <hr class="dropdown-divider">
                                </li>
                                <li class="text-center" style="font-variant: small-caps;">test actions</li>
                                <li>
                                    <hr class="dropdown-divider">
                                </li>
                                <li>
                                    <a class="dropdown-item" id="apiList" href="#" data-bs-toggle="modal"
                                        data-bs-target="#apiListModal">API Endpoint List</a>
                                </li>
                                <li><a class="dropdown-item section" id="analyzeDb" href="#">Analyze Database</a></li>
                                <!-- <li><a class="dropdown-item" id="exportTest" href="#">Export Test</a></li> -->
                                <!-- <li><a class="dropdown-item" id="testData" href="#">load test data</a></li> -->
                                <!-- <li><a class="dropdown-item" id="storageTest" href="#" disabled>Storage Test</a></li> -->
                                <!-- <li><a class="dropdown-item" id="onedriveAuth"
                                href="https://login.microsoftonline.com/common/oauth2/v2.0/authorize?client_id=ddcaa0f6-2021-494f-9680-d924aeb7eacd&scope=https://graph.microsoft.com/.default&response_type=token&redirect_uri=http://localhost:8080/workhorse/">OneDrive
                                auth</a></li> -->
                            </ul>
                        </li>
                    </ul>
                    <div class="dropdown me-3">
                        <a class="btn btn-primary dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            <c:out value="${displayname}" /> (<c:out value="${userbureau}" />)
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end">
                            <li><a class="dropdown-item" href="logout">logout</a></li>
                        </ul>
                    </div>
                </div>
            </nav>

            <!-- section title -->
            <div class="container-fluid mt-5">
                <h3 id="section-title hidden"></h3>
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

            <!-- data entry section -->
            <div class="container-fluid hidden" data-section="manual_entry">
                <div class="float-start" role="group" aria-label="Bureau selection">
                    <div class="accordion" id="bureau-list"></div>
                </div>
                <div class="col-lg-11 offset-lg-1 text-start">
                    <div class="row">
                        <div class="container mx-0" id="test-data"></div>
                    </div>
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

            <!-- database analyzer -->
            <div class="container-fluid hidden" data-section="analyzeDb" id="tableNames">
                <button type="button" class="btn btn-outline-primary">Master_Data</button>
                <button type="button" class="btn btn-outline-primary">Data</button>
                <button type="button" class="btn btn-outline-primary">RAW_Data</button>
                <button type="button" class="btn btn-outline-danger" id="sqlEditorBtn">SQL Editor</button>
                <div id="tableOutput"></div>
            </div>

            <!-- // zj: modal-stuff -->

            <!-- apiList modal -->
            <div class="modal fade" id="apiListModal" tabindex="-1" aria-labelledby="apiListModalLabel"
                aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h1 class="modal-title fs-5" id="apiListModalLabel">API Endpoint List</h1>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <dl>
                                <dt>/kpi</dt>
                                <dd>list all KPI's</dd>

                                <dt>/kpi/bureaus</dt>
                                <dd>list all Bureaus</dd>

                                <dt data-bureau="BCC">/kpi/bureaus/{bureau}</dt>
                                <dd>list all Areas for a given Bureau</dd>

                                <dt data-bureau="BCC" data-area="Applications">/kpi/bureaus/{bureau}/{area}</dt>
                                <dd>list all KPI's for a given Bureau and Area</dd>

                                <dt>/records</dt>
                                <dd>list all entered data</dd>

                                <dt data-kpiId="BCC_APP_02">/records/{kpiId}</dt>
                                <dd>list all entered data for a given KPI ID</dd>

                                <dt data-kpiId="BCC_APP_02" data-year="2023">/records/{kpiId}/{year}</dt>
                                <dd>list all entered data for a given KPI ID and year</dd>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>


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
                $(function() {
                    // section buttons
                    $("a.section").click(function() {
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
                        if ($this.text() == "Data Entry") {
                            ///////////////////////////////////////////////////////////
                            var $div = $("#bureau-list").empty();

                            $.ajax({
                                url: 'kpi/bureaus',
                                type: 'GET',
                                dataType: 'json',
                                success: function(response) {
                                    // admin user, show all bureaus
                                    for (var i = 0; i < response.length; i++) {
                                        var $element = '<div class="accordion-item" data-bureau="' + response[i] + '"><h2 class="accordion-header">';
                                        $element += '<button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#panel-bureau-' + i + '" aria-expanded="false" aria-controls="panel-bureau-' + i + '">' + response[i] + '</button></h2>';
                                        $element += '<div id="panel-bureau-' + i + '" class="accordion-collapse" data-bs-parent="#bureau-list"><div class="accordion-body p-0"></div></div>';
                                        $div.append($element);
                                    }
                                    // $div.append('<label for="raw-data" class="raw-data-checkbox mt-1 ms-2"><input type="checkbox" id="raw-data" name="raw-data"><small>raw data</small></label>');
                                },
                                error: function(error) {
                                    console.error('Error fetching record list:', error);
                                }
                            });
                            ///////////////////////////////////////////////////////////
                        }

                        // hacky junk to open accordion on page load
                        setTimeout(function() {
                            $("button.accordion-button:eq(0)").click();
                        }, 1000);
                        setTimeout(function() {
                            $('.accordion-body button:first').click();
                        }, 1500);

                    });
                    // zj: auto-click something on page load
                    $("a.section").eq(0).click();

                    // get current year
                    var currentYear = new Date().getFullYear();
                    var $yearInput = $('#year-input');
                    $yearInput.val(currentYear);

                    // arrow buttons for year select
                    $('.year-btn').click(function() {
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
                        formData.forEach(function(field, index) {
                            newData[kpi][year][field.name] = field.value;
                        });

                        var finalObj = $.extend(true, {}, savedData, newData);
                        localStorage.setItem('formData', JSON.stringify(finalObj));
                        alert('Form data serialized and saved to local storage.');
                    });

                    // Keyboard arrow key event listeners
                    $("#year-input").keydown(function(e) {
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
                    $("#apiList").click(function() {
                        showApiList();
                    });

                    $("#onedrive").click(function() {
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
                            success: function(jsondata) {
                                console.log("success");
                                console.log(JSON.stringify(djsondataata));
                            },
                            error: function(xhr, status, error) {
                                console.error("Error:", status, error);
                            }
                        });
                    });

                    $("#onedriveAuth").click(function() {
                        checkSignIn();
                        console.info("checking signin...");
                    });

                    // zj: kpi editing stuff
                    $("#kpiSelector").change(function() {
                        var kpiId = $(this).val();
                        console.info("kpiId=" + kpiId);
                    });

                    $("#kpiSubmit").click(function(e) {
                        e.preventDefault();
                        $("#testdiv").text("database not loaded");

                        $.ajax({
                            url: 'kpi',
                            type: 'GET',
                            dataType: 'json',
                            success: function(data) {
                                // Build the HTML table
                                var tableHtml = '<table class="table table-striped data-tables" id="kpi_table"><thead><tr>';
                                // Iterate over the fields of the first item to get column names
                                $.each(Object.keys(data[0]), function(index, fieldName) {
                                    var colName = (index > 0) ? fieldName : '';
                                    tableHtml += '<th scope="col">' + colName + '</th>';
                                });
                                tableHtml += '</tr></thead><tbody>';

                                // Iterate over each item in the JSON data and append a table row
                                $.each(data, function(index, item) {
                                    tableHtml += '<tr>';

                                    // Iterate over each field in the item and append a table cell
                                    $.each(item, function(key, value) {
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
                                            columnText: function(dt, idx, title) {
                                                return (idx + 1) + ': ' + title;
                                            }
                                        },
                                        {
                                            text: 'Reset Columns',
                                            className: "btn-sm",
                                            action: function(e, dt, node, config) {
                                                console.info("deleting dt localstorage");
                                                this.colReorder.reset();
                                                dt.columns(config.show).visible(true);
                                                localStorage.removeItem("DataTables_kpi_table_/workhorse/");
                                            }
                                        }
                                    ],
                                    initComplete: function() {
                                        // add buttons to table row
                                        var isAdmin = "blarg";
                                        $.ajax({
                                            url: 'isAdmin',
                                            type: 'GET',
                                            success: function(isAdmin) {
                                                if (isAdmin) {
                                                    $("div.toolbar").html('<button type="button" class="btn btn-outline-success btn-sm" id="kpi_addNew" title="add new KPI" data-bs-toggle="modal" data-bs-target="#kpiModal"><i class="fa-solid fa-plus"></i> KPI</button>');
                                                    // attach click event to addNew button
                                                    $("div.toolbar").on("click", "#kpi_addNew", function() {
                                                        // if actions need to happen on add...
                                                        $(":checkbox", "#kpiEditForm").attr("checked", false);
                                                    });
                                                }
                                            },
                                            error: function() {
                                                console.error('Error checking admin role');
                                            }
                                        });
                                    }
                                });
                                // post datatables-init actions
                                $("ul.pagination", "#kpi_table_paginate").addClass("pagination-sm");
                                $("table#kpi_table").on("click", "i.fa-regular", function() {
                                    var id = $(this).parent().attr("data-id");
                                    editKpi(id);
                                });

                            },
                            error: function(xhr, status, error) {
                                console.error('Error retrieving JSON data:', error);
                                // Handle error response
                            }
                        });

                    });


                    $("#saveKpi").click(function() {
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
                        $('#kpiEditForm').serializeArray().forEach(function(item) {
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
                                success: function(response) {
                                    console.log('KPI updated successfully:', response);
                                    showSuccess('KPI updated successfully:', response);
                                    // Handle success, e.g., show a success message
                                },
                                error: function(error) {
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
                                success: function(response) {
                                    console.log('KPI added successfully:', response);
                                    showSuccess('KPI added successfully:', response);
                                    // Handle success, e.g., show a success message
                                },
                                error: function(error) {
                                    alert('Error updating KPI:', error);
                                    // Handle error, e.g., show an error message
                                }
                            });
                        }


                    });

                    $("#deleteKpi").click(function() {
                        var id = $("#id", "form#kpiEditForm").val();
                        $.ajax({
                            type: 'DELETE',
                            contentType: 'application/json',
                            url: 'kpi/' + id,
                            success: function(response) {
                                console.log(response);
                                showSuccess(response);
                            },
                            error: function(error) {
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

                    $("#bureau-list").on('show.bs.collapse', function(e) {
                        var $parent = $(e.target).parent();
                        var $container = $parent.find(".accordion-body").empty();
                        var bureau = $parent.attr("data-bureau");

                        $.ajax({
                            url: 'kpi/bureaus/' + bureau,
                            type: 'GET',
                            dataType: 'json',
                            success: function(response) {
                                for (var i = 0; i < response.length; i++) {
                                    var area = response[i];
                                    $container.append('<button type="button" class="btn btn-light kpi-area-btn rounded-0" data-area="' + area + '">' + area + '</button>');
                                }
                            },
                            error: function(error) {
                                console.error('Error fetching record list:', error);
                            }
                        });

                    }).on('hide.bs.collapse', function(e) {
                        console.info("closing accordion, not sure we need this one...");
                    });

                    $("#bureau-list").on("click", ".kpi-area-btn", function() {
                        var $btn = $(this);
                        var bureau = $btn.parents(".accordion-item").attr("data-bureau");
                        var area = $btn.attr("data-area");
                        $("#test-data").empty();

                        $.ajax({
                            url: 'kpi/bureaus/' + bureau + '/' + area,
                            type: 'GET',
                            dataType: 'json',
                            success: function(response) {
                                //zj: print month table here
                                var $parent = $('#test-data').empty();
                                //assemble header row
                                var $kpiTable = "<table id='kpi_table_entry' class='table table-fixed text-nowrap table-striped-columns'><thead><tr><th scope='col'><select id='year_testing' class='entry_select'></select></th>";
                                $kpiTable += '<th scope="col" title="select KPI"><select id="kpi_testing" class="entry_select">';
                                for (var i = 0; i < response.length; i++) {
                                    $kpiTable+='<option value="' + response[i].KPI_ID + '" data-title="' + response[i].KPI_Name + '">' + response[i].KPI_ID + "</option>";
                                }
                                $kpiTable += '</select></th></tr><tr><th colspan=2 id="kpi_title"></th></tr>';
                                $kpiTable += '</thead><tbody class="table-group-divider">';
                                
                                //assemble month rows
                                var months = [
                                    'January', 'February', 'March', 'April', 'May', 'June',
                                    'July', 'August', 'September', 'October', 'November', 'December'
                                ];
                                for (var i = 0; i < months.length; i++) {
                                    var monthNumber = (i + 1).toString().padStart(2, '0'); // Convert month number to two-digit format
                                    var inputId = monthNumber + '-01'; // Create the id in the format "MM-01"
                                    var row = '<tr><td>' + months[i] + '</td>';
                                    row += '<td>' + '<input type="text" class="form-control record-data" data-month="' + inputId + '">' + '</td>';
                                    row += '</tr>';
                                    $kpiTable += row;
                                }
                                $kpiTable += '<tr><td colspan=2><button type="button" id="saveRecord" class="btn btn-outline-success" disabled="disabled">Save</button></td></tr></tbody></table>';
                                $parent.append($kpiTable);

                                // populate years
                                var $yearSelect = $("#year_testing").empty();
                                var currentYear = new Date().getFullYear();
                                var $options = "";
                                $.ajax({
                                    url: 'records/' + bureau + "/years",
                                    type: 'GET',
                                    dataType: 'json',
                                    success: function(response) {
                                        if (response.length > 0) {
                                            $.each(response, function(index, item) {
                                                $options += "<option value='" + item + "'>" + item + "</option>";
                                            });
                                        }
                                        $options += '<option id="newYear" value="~new~">add new year</option>';
                                        $yearSelect.append($options);
                                    },
                                    error: function(error) {
                                        console.error('Error fetching record list:', error);
                                    }
                                });

                                // fire change to populate data on load
                                setTimeout(function() {
                                    $("#kpi_testing").trigger('change');
                                }, 500);
                            },
                            error: function(error) {
                                console.error('Error fetching record list:', error);
                            }
                        });
                    });

                    $("#kpi_selector").change(function() {
                        var kpiId = $(this).val();
                        var $testDiv = $('#test-data').empty();
                        var rawdata = $("#raw-data").prop("checked");
                        var html = "";

                        if (rawdata) {
                            html = '<table>';
                            html += '<tr><th>ID</th><th>KPI ID</th><th>Percentage Value</th><th>Entry Date</th><th>Count Value</th></tr>';
                            $.ajax({
                                url: 'records/' + kpiId,
                                type: 'GET',
                                dataType: 'json',
                                success: function(response) {
                                    if (response.length == 0) {
                                        html += "<tr><td>no results found</td></tr></table>";
                                    } else {
                                        $.each(response, function(index, item) {
                                            html += '<tr>';
                                            html += '<td>' + item.id + '</td>';
                                            html += '<td>' + item.kpi_ID + '</td>';
                                            html += '<td>' + item.prct_VAL + '</td>';
                                            html += '<td>' + item.entrydate + '</td>';
                                            html += '<td>' + item.count_VAL + '</td>';
                                            html += '</tr>';
                                        });
                                    }
                                    html += '</table>';
                                    $testDiv.html(html);
                                },
                                error: function(error) {
                                    console.error('Error fetching record list:', error);
                                }
                            });
                        } else {
                            html = '<div class="container"><div class="row mb-3"><label for="yearSelect" class="form-label ps-0">Select Year:</label><select data-kpi="' + kpiId + '" class="form-select" id="yearSelect"></select></div><div class="row"><div class="col"><div class="row calendar-container rounded-4"></div></div></div></div>';
                            $testDiv.html(html);
                            // Populate years
                            var $yearSelect = $("#yearSelect").empty();
                            var currentYear = new Date().getFullYear();
                            // zj: actually populate years here
                            var $options = "";
                            $.ajax({
                                url: 'records/' + kpiId + "/years",
                                type: 'GET',
                                dataType: 'json',
                                success: function(response) {
                                    if (response.length > 0) {
                                        $.each(response, function(index, item) {
                                            $options += "<option value='" + item + "'>" + item + "</option>";
                                        });
                                    }
                                    $options += "<option value='" + currentYear + "'>" + currentYear + "</option>";

                                    $yearSelect.append($options).change();
                                },
                                error: function(error) {
                                    console.error('Error fetching record list:', error);
                                }
                            });

                        }
                        $testDiv.append('<input type="text" placeholder="testing">');
                    });

                    $("body").on("click", "#saveRecord", function() {
                        // Save button click event
                        var recordsToSave = [];

                        $('.changed').each(function() {
                            let $record = $(this);
                            recordsToSave.push({
                                    value: $record.val(),
                                    ogvalue: $record.attr("data-ogvalue"),
                                    date: $record.attr("id"),
                                    kpi: $("#kpi_testing").val()
                                });
                        });

                        // Send a single AJAX request to save all changed records
                        saveRecords(recordsToSave);
                    });

                    $("body").on("input", ".record-data", function() {
                        // Detect changes and highlight the fields
                        var $this = $(this);
                        var ogval = $this.attr('data-ogvalue');
                        if (($this.val() !== ogval) && (ogval !== undefined || $this.val() !== "")) {
                            $this.addClass('changed');
                        } else {
                            $this.removeClass('changed');
                        }
                        var count = $(".changed").length;
                        if (count > 0) {
                            $("#saveRecord").prop("disabled", false);
                        } else {
                            $("#saveRecord").prop("disabled", true);
                        }
                    });

                    $("body").on("change", ".entry_select", function() {
                        var val = $(this).val();
                        if (val == "~new~") {
                            var currentYear = new Date().getFullYear();
                            var year;
                            var valid = false;
                            while (!valid) {
                                year = prompt("Please enter a 4-digit year:");

                                if (year === null) {
                                    // User pressed cancel
                                    alert("No year entered. Exiting.");
                                    return;
                                }
                                if (/^\d{4}$/.test(year) && year >= 1900 && year <= (currentYear+1)) {
                                    valid = true;
                                    $("#year_testing").prepend('<option value="' + year + '">' + year + "</option>");
                                    $("#year_testing").val($("#year_testing option:first").val()).change();
                                    labelInputs(true);
                                } else {
                                    alert("Invalid input. Please enter a 4-digit year between 1900 and " + (currentYear+1) + ".");
                                }
                            }
                        } else {
                            labelInputs();
                            var kpi = $("#kpi_testing").val();
                            var year = $("#year_testing").val();
                            $("#kpi_title").text($('#kpi_testing option:selected').attr("data-title"));
                            $("input.record-data").val("");
                            $.ajax({
                                url: 'records/' + kpi + "/" + year,
                                type: 'GET',
                                dataType: 'json',
                                success: function(response) {
                                    console.info(response);
                                    $.each(response, function(index, record) {
                                        var value = record["prct_VAL"] !== null ? record["prct_VAL"] : record["count_VAL"];
                                        $("#" + record["entryDate"]).val(value).attr("data-ogvalue", value);
                                    });
                                },
                                error: function(error) {
                                    console.error('Error fetching record list:', error);
                                }
                            });
                        }
                    });

                    $("body").on("click", ".year-button", function() {
                        var $this = $(this);
                        var year = $this.text();
                        alert("year=" + year);
                        $.ajax({
                            url: 'records/' + kpi + "/" + year,
                            type: 'GET',
                            dataType: 'json',
                            success: function(response) {
                                console.info(response);
                                $.each(response, function(index, item) {
                                    console.info("item::");
                                    console.info(item);
                                    $calendarContainer.append(JSON.stringify(item) + "<br>");
                                });
                            },
                            error: function(error) {
                                console.error('Error fetching record list:', error);
                            }
                        });
                    }).on("focus", "input.month-input", function() {
                        $(this).select();
                    });

                    $("button", "#tableNames").click(function() {
                        var $btn = $(this);
                        var tableName = $btn.text();
                        console.info("click: " + tableName);

                        if (tableName == "SQL Editor") {
                            var output = '<textarea class="sql" id="input"></textarea><br>';
                            output += '<button type="button" class="btn btn-outline-danger" id="sqlEditorBtn" onclick="executeSql()">execute</button>';
                            output += '<br><textarea class="sql" id="output"></textarea>';
                            $('#tableOutput').html(output);
                        } else {

                            // start
                            $.ajax({
                                url: 'tableMetadata',
                                method: 'GET',
                                data: { tableName: tableName },
                                success: function(data) {
                                    var output = '<h4>Table Name: ' + data.tableName + '</h4>';

                                    // Columns Section
                                    output += '<table class="tableDisplay">';
                                    output += '<thead><tr><th>Column Name</th><th>Column Type</th></tr></thead><tbody>';
                                    if (data.columns.length === 0) {
                                        output += '<tr><td colspan="2">-</td></tr>';
                                    } else {
                                        data.columns.forEach(function(column) {
                                            output += '<tr><td>' + column.columnName + '</td><td>' + column.columnType + '(' + column.columnSize + ')</td></tr>';
                                        });
                                    }
                                    output += '</tbody></table>';

                                    // Primary Keys Section
                                    output += '<table class="tableDisplay">';
                                    output += '<thead><tr><th>Primary Key</th></tr></thead><tbody>';
                                    if (data.primaryKeys.length === 0) {
                                        output += '<tr><td>-</td></tr>';
                                    } else {
                                        data.primaryKeys.forEach(function(pk) {
                                            output += '<tr><td>' + pk + '</td></tr>';
                                        });
                                    }
                                    output += '</tbody></table>';

                                    // Foreign Keys Section
                                    output += '<table class="tableDisplay">';
                                    output += '<thead><tr><th>Foreign Key Name</th><th>References</th></tr></thead><tbody>';
                                    if (data.foreignKeys.length === 0) {
                                        output += '<tr><td colspan="2">-</td></tr>';
                                    } else {
                                        data.foreignKeys.forEach(function(fk) {
                                            output += '<tr><td>' + fk.fkName + '</td><td>' + fk.pkTableName + '(' + fk.pkColumnName + ')</td></tr>';
                                        });
                                    }
                                    output += '</tbody></table>';

                                    // Indexes Section
                                    output += '<table class="tableDisplay">';
                                    output += '<thead><tr><th>Index Name</th><th>Unique</th><th>Column Name</th></tr></thead><tbody>';
                                    if (data.indexes.length === 0) {
                                        output += '<tr><td colspan="3">-</td></tr>';
                                    } else {
                                        $.each(data.indexes, function(index, indexInfo) {
                                            output += '<tr><td>' + indexInfo.indexName + '</td><td>' + (indexInfo.isUnique ? 'Yes' : 'No') + '</td><td>' + indexInfo.columnName + '</td></tr>';
                                        });
                                    }
                                    output += '</tbody></table>';

                                    // Table Privileges Section
                                    output += '<table class="tableDisplay">';
                                    output += '<thead><tr><th>Table Privileges</th></tr></thead><tbody>';
                                    if (data.tablePrivileges.length === 0) {
                                        output += '<tr><td>-</td></tr>';
                                    } else {
                                        $.each(data.tablePrivileges, function(index, privilege) {
                                            output += '<tr><td>' + privilege + '</td></tr>';
                                        });
                                    }
                                    output += '</tbody></table>';

                                    // Column Privileges Section
                                    output += '<table class="tableDisplay">';
                                    output += '<thead><tr><th>Column Privileges</th></tr></thead><tbody>';
                                    if (data.columnPrivileges.length === 0) {
                                        output += '<tr><td>-</td></tr>';
                                    } else {
                                        $.each(data.columnPrivileges, function(index, privilege) {
                                            output += '<tr><td>' + privilege + '</td></tr>';
                                        });
                                    }
                                    output += '</tbody></table>';

                                    $('#tableOutput').html(output);
                                },
                                error: function(jqXHR, textStatus, errorThrown) {
                                    var errorMessage = 'An error occurred while retrieving the table metadata: ' + textStatus;
                                    if (textStatus === 'timeout') {
                                        errorMessage = 'The request timed out, database server offline or connection failed';
                                    } else if (textStatus === 'error') {
                                        errorMessage = 'Could not connect to the server. Please check your internet connection or try again later.';
                                    }

                                    $('#tableOutput').html('<div class="alert alert-danger">' + errorMessage + '</div>');
                                },
                                timeout: 5000 // Set a timeout of 5 seconds
                            });
                        }

                        // end
                    });

                    // zj: end stupidly huge script block
                });

                function saveRecords(recordsToSave) {
                    console.info(recordsToSave);
                    $.ajax({
                        type: 'POST',
                        url: 'saveOrUpdateRecords',
                        contentType: 'application/json',
                        data: JSON.stringify(recordsToSave),
                        success: function(response) {
                            console.log('Records saved/updated:', response);
                            // Optionally reset the form and original values
                            $('.changed').removeClass("changed");
                            $("#kpi_testing").change();
                            // remove new tag on save
                            $("input[data-ogvalue='~new~']").removeAttr("data-ogvalue");
                            // remove ogval's on any deleted items
                            $('input').filter(function() { return !this.value; }).removeAttr('data-ogvalue');

                        },
                        error: function(error) {
                            console.error('Error saving/updating records:', error);
                        }
                    });
                }

                function labelInputs(isNew) {
                    if (typeof isNew === 'undefined') {
                        isNew = false; // Set your default value here
                    }
                    $(".changed").removeClass('changed')
                    var year = $("#year_testing").val();
                    $("input.record-data").each(function() {
                        var $this = $(this);
                        var id = $this.attr("data-month");
                        $this.attr("id", year + "-" + id);
                        if (isNew) {
                            $this.attr("data-ogvalue", "~new~");
                        }
                    });
                }

                function executeSql() {
                    var $input = $("textarea#input");
                    var $output = $("textarea#output");
                    var query = $input.val();
                    // alert("query = " + query);
                    var encodedQuery = encodeURIComponent(query);
                    // alert("encodedQuery = " + encodedQuery);
                    var url = 'http://127.0.0.1:8080/workhorse/sql/execute?query=' + encodedQuery;
                    // alert("url: " + url);
                    var xhr = new XMLHttpRequest();
                    xhr.open('GET', url, true);
                    xhr.onreadystatechange = function() {
                        if (xhr.readyState === 4) {
                            if (xhr.status === 200) {
                                $($output).val(xhr.responseText);
                            } else if (xhr.status === 403) {
                                $($output).val("Access denied. You do not have permission to execute this query.");
                            } else {
                                $($output).val("Error: " + xhr.status + " - " + xhr.statusText);
                            }
                        }
                    };
                    xhr.send();
                }

                <!-- // zj: modal-stuff -->
                // edit kpi
                function editKpi(id) {
                    $.ajax({
                        url: 'kpi/' + id,
                        type: 'GET',
                        dataType: 'json',
                        success: function(data) {
                            $.each(data, function(key, value) {
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
                        error: function(xhr, status, error) {
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
                    toast.on('hidden.bs.toast', function() {
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
                        $.each(years, function(index, year) {
                            $("#displayData div").append("<a class='btn btn-sm year-badge btn-outline-success mx-1' title='load " + year + " data'>" + year + "</a>");
                        });
                        $("a.year-badge").click(function() {
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
                                $('input[type="text"]', ".month-data").val("").each(function() {
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
                    $('input[type="text"]', ".month-data").each(function(i) {
                        var $this = $(this);
                        $this.attr("name", i + 1 + "/1/" + year);
                    });
                }

                function highlight(button) {
                    button.addClass('btn-warning');
                    setTimeout(function() {
                        button.removeClass('btn-warning');
                    }, 100);
                }

                function showApiList() {
                    $('#apiListModal dt').each(function() {
                        var $dt = $(this);
                        var dtText = $dt.text();
                        // Regular expression to match text within curly braces
                        var regex = /{([^{}]+)}/g;
                        // Replace text within curly braces with corresponding attribute values
                        dtText = dtText.replace(regex, function(match, attributeName) {
                            var replaceValue = $dt.attr('data-' + attributeName);
                            var title = $dt.attr("title");
                            if (typeof title !== 'undefined') {
                                $dt.attr("title", title + "/" + replaceValue);
                            } else {
                                $dt.attr("title", "example: " + replaceValue);
                            }

                            return replaceValue;
                        }.bind(this));
                        // $dt.attr("title", "example " + attributeName + " = " + $dt.attr('data-' + attributeName));
                        console.info(dtText);

                        var baseUrl = "http://127.0.0.1:8080/workhorse"; http://127.0.0.1:8080/workhorse/records/BCC_APP_02/2023
                        var href = baseUrl + dtText;
                        $dt.wrapInner('<a href="' + href + '" target="_blank"></a>');


                    });

                }


            </script>
        </body>