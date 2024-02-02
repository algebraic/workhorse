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

                .input-group-text:last-of-type {
                    min-width: 25px;
                    text-align: center;
                    display: inline-block;
                    padding-left: 0px;
                    padding-right: 0;
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
                                <li><a class="dropdown-item section" id="manual_entry" href="#">BPL Data Entry</a></li>
                                <!-- zj: disabled pending resolution of weblogic upload problems
                            <li><a class="dropdown-item section" id="file_operation" href="#">File Operation</a></li> 
                        -->
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
                        The "<b>KPI Data</b>" action will open a form to add or edit KPI's
                    </p>
                    <p>
                        The "<b>load test data</b>" action will load the data used to set up the initial reports
                    </p>
                    <p>
                        <a href="h2">h2 testing</a>
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
                                        <option value="BFS_INSP_02">BFS_INSP_02</option>
                                        <option value="BCC_INSP_01">BCC_INSP_01</option>
                                        <option value="BCC_INSP_02">BCC_INSP_02</option>
                                        <option value="BCC_INSP_03">BCC_INSP_03</option>
                                        <option value="BCC_INSP_04">BCC_INSP_04</option>
                                        <option value="BFS_INSP_01">BFS_INSP_01</option>
                                        <option value="BFS_INSP_02">BFS_INSP_02</option>
                                        <option value="BPL_INSP_01">BPL_INSP_01</option>
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
                                    <button class="btn btn-outline-secondary year-btn" data-action="-" type="button">
                                        << /button>
                                            <input type="text" class="form-control text-center" id="year-input"
                                                readonly>
                                            <button class="btn btn-outline-secondary year-btn" data-action="+"
                                                type="button">></button>
                                </div>
                            </div>

                            <div class="row month-data">
                                <div class="col-md-4">
                                    <div class="input-group mb-3">
                                        <span class="input-group-text">January</span>
                                        <input type="text" class="form-control">
                                        <span class="input-group-text">%</span>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="input-group mb-3">
                                        <span class="input-group-text">February</span>
                                        <input type="text" class="form-control">
                                        <span class="input-group-text">%</span>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="input-group mb-3">
                                        <span class="input-group-text">March</span>
                                        <input type="text" class="form-control">
                                        <span class="input-group-text">%</span>
                                    </div>
                                </div>
                            </div>
                            <div class="row month-data">
                                <div class="col-md-4">
                                    <div class="input-group mb-3">
                                        <span class="input-group-text">April</span>
                                        <input type="text" class="form-control">
                                        <span class="input-group-text">%</span>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="input-group mb-3">
                                        <span class="input-group-text">May</span>
                                        <input type="text" class="form-control">
                                        <span class="input-group-text">%</span>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="input-group mb-3">
                                        <span class="input-group-text">June</span>
                                        <input type="text" class="form-control">
                                        <span class="input-group-text">%</span>
                                    </div>
                                </div>
                            </div>
                            <div class="row month-data">
                                <div class="col-md-4">
                                    <div class="input-group mb-3">
                                        <span class="input-group-text">July</span>
                                        <input type="text" class="form-control">
                                        <span class="input-group-text">%</span>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="input-group mb-3">
                                        <span class="input-group-text">August</span>
                                        <input type="text" class="form-control">
                                        <span class="input-group-text">%</span>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="input-group mb-3">
                                        <span class="input-group-text">September</span>
                                        <input type="text" class="form-control">
                                        <span class="input-group-text">%</span>
                                    </div>
                                </div>
                            </div>
                            <div class="row month-data">
                                <div class="col-md-4">
                                    <div class="input-group mb-3">
                                        <span class="input-group-text">October</span>
                                        <input type="text" class="form-control">
                                        <span class="input-group-text">%</span>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="input-group mb-3">
                                        <span class="input-group-text">November</span>
                                        <input type="text" class="form-control">
                                        <span class="input-group-text">%</span>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="input-group mb-3">
                                        <span class="input-group-text">December</span>
                                        <input type="text" class="form-control">
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


            <!-- kpi data entry section -->
            <div class="container-fluid hidden" data-section="kpi_edit">
                <div class="row justify-content-center">
                    <div class="col-md-8">
                        <form id="kpiEdit" class="floatLabels">
                            <input type="hidden" id="username" name="username">
                            <div class="row mb-3">
                                <div class="input-group">
                                    <select class="form-select" id="kpiSelector">
                                        <option value="BPL_01">PDM complete investigations within 120 days</option>
                                        <option value="BPL_02">PHC investigations completed within 120 days</option>
                                        <option value="BPL_03">OCC investigations completed within 120 days</option>
                                        <option value="BPL_04">Complaints received</option>
                                        <option value="BPL_05">Complaints closed</option>
                                        <option value="BFS_INSP_02">BFS_INSP_02</option>
                                        <option value="BCC_INSP_01">BCC_INSP_01</option>
                                        <option value="BCC_INSP_02">BCC_INSP_02</option>
                                        <option value="BCC_INSP_03">BCC_INSP_03</option>
                                        <option value="BCC_INSP_04">BCC_INSP_04</option>
                                        <option value="BFS_INSP_01">BFS_INSP_01</option>
                                        <option value="BFS_INSP_02">BFS_INSP_02</option>
                                        <option value="BPL_INSP_01">BPL_INSP_01</option>
                                        zj: double check, but it looks to be working...
                                        <option selected disabled hidden>Select KPI</option>
                                    </select>
                                </div>
                            </div>
                            <hr>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="Bureau" class="control-label">Bureau</label>
                                        <input type="text" class="form-control" id="Bureau" name="Bureau"
                                            placeholder="Bureau placeholder text">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="KPI_Area" class="control-label">KPI Area</label>
                                        <input type="text" class="form-control" id="KPI_Area" name="KPI_Area"
                                            placeholder="KPI Area placeholder text">
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="KPI_Name" class="control-label">KPI Name</label>
                                        <input type="text" class="form-control" id="KPI_Name" name="KPI_Name"
                                            placeholder="KPI Name placeholder text">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="KPI_ID" class="control-label">KPI ID</label>
                                        <input type="text" class="form-control" id="KPI_ID" name="KPI_ID"
                                            placeholder="KPI ID placeholder text">
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="Data_Processed_from_Dustin_Excel" class="control-label">Data
                                            Processed from Dustin Excel?</label>
                                        <input type="text" class="form-control" id="Data_Processed_from_Dustin_Excel"
                                            name="Data_Processed_from_Dustin_Excel"
                                            placeholder="Data Processed from Dustin Excel? placeholder text">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="Type" class="control-label">Type</label>
                                        <input type="text" class="form-control" id="Type" name="Type"
                                            placeholder="Type placeholder text">
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="Data_Stored_As" class="control-label">Data Stored As</label>
                                        <input type="text" class="form-control" id="Data_Stored_As"
                                            name="Data_Stored_As" placeholder="Data Stored As placeholder text">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="Denominator_for_Calculation" class="control-label">Denominator for %
                                            Calculation</label>
                                        <input type="text" class="form-control" id="Denominator_for_Calculation"
                                            name="Denominator_for_Calculation"
                                            placeholder="Denominator for % Calculation placeholder text">
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="Target" class="control-label">Target</label>
                                        <input type="text" class="form-control" id="Target" name="Target"
                                            placeholder="Target placeholder text">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="12_Month_Rolling_Avg" class="control-label">12 Month Rolling
                                            Avg</label>
                                        <input type="text" class="form-control" id="12_Month_Rolling_Avg"
                                            name="12_Month_Rolling_Avg"
                                            placeholder="12 Month Rolling Avg placeholder text">
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="Access" class="control-label">Access</label>
                                        <input type="text" class="form-control" id="Access" name="Access"
                                            placeholder="Access placeholder text">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="Requested_by" class="control-label">Requested By</label>
                                        <input type="text" class="form-control" id="Requested_by" name="Requested_by"
                                            placeholder="Requested By placeholder text">
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="Source_System" class="control-label">Source System</label>
                                        <input type="text" class="form-control" id="Source_System" name="Source_System"
                                            placeholder="Source System placeholder text">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="Data_Feed" class="control-label">Data Feed</label>
                                        <input type="text" class="form-control" id="Data_Feed" name="Data_Feed"
                                            placeholder="Data Feed placeholder text">
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="Comments" class="control-label">Comments</label>
                                        <input type="text" class="form-control" id="Comments" name="Comments"
                                            placeholder="Comments placeholder text">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="Dev_Comments" class="control-label">Dev Comments</label>
                                        <input type="text" class="form-control" id="Dev_Comments" name="Dev_Comments"
                                            placeholder="Dev Comments placeholder text">
                                    </div>
                                </div>
                            </div>

                            <br>
                            <div class="row justify-content-center">
                                <button type="button" class="btn btn-primary" id="kpiSubmit">Submit</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <!-- zj: new stuff -->


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
                    });
                    // zj: auto-click something on page load
                    // $("a.section").eq(1).click();

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
                        // blank inputs
                        $('input[type="text"]', "form#kpiEdit").val("").blur();
                        console.info("selectedKpi=" + kpiId);
                        selectedKpi = findKPIObject(kpiId);
                        if (selectedKpi != "" && selectedKpi != null) {
                            // Loop through form fields and set values
                            for (var key in selectedKpi) {
                                if (selectedKpi.hasOwnProperty(key)) {
                                    $("#" + key).val(selectedKpi[key]).blur();
                                }
                            }
                        }
                    });

                    $("#kpiSubmit").click(function (e) {
                        e.preventDefault();
                        updateJSONWithFormData($("#kpiSelector").val());
                    });
                });

                // function to update JSON with form data
                function updateJSONWithFormData(kpiId) {
                    var kpiObject = findKPIObject(kpiId);

                    var kpiData = JSON.parse(localStorage.getItem("kpiData")) || [];

                    // If KPI object is not found, create a new one with all form fields
                    if (!kpiObject) {
                        kpiObject = {};

                        // Loop through form fields and set initial values in the new KPI object
                        $("form#kpiEdit input").each(function () {
                            var fieldName = $(this).attr("id");
                            kpiObject[fieldName] = $(this).val();
                        });
                        // Add the new KPI object to the JSON array
                        kpiData.push(kpiObject);
                    } else {
                        var index = kpiData.findIndex(function (kpi) {
                            return kpi.KPI_ID === kpiId;
                        });
                        console.info("index=" + index);
                        // Loop through form fields and update values in the existing KPI object
                        $("form#kpiEdit input").each(function () {
                            var fieldName = $(this).attr("id");
                            var $val = $(this).val();
                            console.info("setting " + fieldName + " = " + $val);
                            kpiObject[fieldName] = $val;
                        });
                        kpiData[index] = kpiObject;
                    }
                    console.debug("debugging...");
                    localStorage.setItem('kpiData', JSON.stringify(kpiData));
                }

                // function to find KPI object by KPI_ID
                function findKPIObject(kpiId) {
                    var kpiData = localStorage.getItem('kpiData');
                    if (kpiData) {
                        var formDataObject = JSON.parse(kpiData);
                        return formDataObject.find(function (item) {
                            return item.KPI_ID === kpiId;
                        });
                    }
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