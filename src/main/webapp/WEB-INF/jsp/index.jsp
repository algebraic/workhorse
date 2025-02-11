<!doctype html>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="en">

    <head>
        <title>WORKHORSE</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        
        <meta name="_csrf" content="${_csrf.token}"/>
        <meta name="_csrf_header" content="${_csrf.headerName}"/>
        
        <!-- <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.2/css/bootstrap.min.css"
            integrity="sha512-b2QcS5SsA8tZodcDtGRELiGv5SaKSk1vDHDaQRda0htPYWZ6046lr3kJ5bAAQdpV2mmA/4v0wQF9MyU6/pDIAg=="
            crossorigin="anonymous" referrerpolicy="no-referrer" /> -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">

        <link rel="stylesheet" href="/workhorse/css/style.css">
        <link rel="stylesheet" href="/workhorse/css/loading.io.css">
        <link rel="stylesheet" href="/workhorse/css/floatLabels.css">
        <link
            href="https://cdn.datatables.net/v/bs5/dt-1.13.8/b-2.4.2/b-colvis-2.4.2/b-html5-2.4.2/cr-1.7.0/r-2.5.0/sr-1.3.0/datatables.min.css"
            rel="stylesheet">

        <link rel="stylesheet" href="/workhorse/css/dataEntry.css">

    </head>

    <body>
        
        <jsp:include page="/WEB-INF/jsp/includes/navbar.jsp" />

        <br>

        <!-- data entry section -->
        <div class="container-fluid hidden" data-section="manual_entry">
            <div class="float-start" role="group" aria-label="Bureau selection">
                <div class="accordion" id="bureau-list"></div>
            </div>
            <div class="col-lg-11 offset-lg-1">
                <div class="row justify-content-center align-items-center position-relative" style="min-height: 200px; left:-95px" id="loadingSpinner">
                    <div class="spinner-grow text-success" role="status">
                        <span class="visually-hidden">Loading...</span>
                    </div>
                </div>
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
                            <button type="button" class="btn btn-sm btn-secondary reload-btn" id="kpiSubmit">reload</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        
        <!-- user data section -->
        <div class="container-fluid hidden" data-section="user_edit">
            <div class="row justify-content-center">
                <div class="col-md-12">
                    <form id="userEdit" class="floatLabels">
                        <input type="hidden" id="username" name="username">
                        <div class="row justify-content-center" id="userEditDiv"></div>
                            user data
                        <br>
                        <div class="col-xs-1">
                            <button type="button" class="btn btn-sm btn-secondary reload-btn" id="userSubmit">reload</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- user profile section -->
        <div class="container-fluid hidden" data-section="user_profile">
            <div class="container mt-1 ms-0">
                <div class="row">
                    <div class="col-md-6 ps-3">
                        <form id="userProfileForm" data-profile="true">
                            <input type="hidden" id="id" name="id" value="<c:out value='${userDetails.id}' />">
                            
                            <div class="mb-3">
                                <label for="displayName" class="form-label">Display Name</label>
                                <input type="text" id="displayName" name="displayName" class="form-control" value="<c:out value='${userDetails.displayName}' />">
                            </div>

                            <div class="mb-3">
                                <label for="email" class="form-label">Email</label>
                                <input type="text" id="email" name="email" class="form-control" value="<c:out value='${userDetails.email}' />" disabled>
                            </div>
                            
                            <div class="mb-3">
                                <label for="username" class="form-label">Username</label>
                                <input type="text" id="username" name="username" class="form-control" value="<c:out value='${userDetails.username}' />" disabled>
                            </div>
                            
                            <div class="mb-3 hidden">
                                <label for="password" class="form-label">Password</label>
                                <input type="password" id="password" name="password" class="form-control" value="<c:out value='${userDetails.password}' />">
                            </div>
                            
                            <div class="mb-3">
                                <label for="bureau" class="form-label">Bureau</label>
                                <c:choose>
                                    <c:when test="${userDetails.bureau == '*'}">
                                        <c:set var="bureau" value="Administrator"/>
                                    </c:when>
                                    <c:otherwise>
                                        <c:set var="bureau" value="${userDetails.bureau}"/>
                                    </c:otherwise>
                                </c:choose>
                                <input type="text" id="bureau" name="bureau" class="form-control" value="<c:out value='${bureau}' />" disabled>
                            </div>
                            
                            <div class="mb-3 form-check">
                                <input class="form-check-input" type="checkbox" value="true" id="disabled" name="disabled" disabled>
                                <label class="form-check-label" for="disabled">Disabled</label>
                            </div>
                            
                            <div class="d-flex">
                                <button type="button" class="btn btn-primary me-2" id="updateDisplayName">Save</button>
                                <a type="button" class="btn btn-outline-success" id="changePassword" href="auth/changePassword">Change Password</a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            
        </div>

        <!-- database analyzer -->
        <div class="container-fluid hidden" data-section="analyzeDb" id="tableNames">
            <button type="button" class="btn btn-outline-primary">Master_Data</button>
            <button type="button" class="btn btn-outline-primary">Data</button>
            <button type="button" class="btn btn-outline-primary">RAW_Data</button>
            <button type="button" class="btn btn-outline-primary">users</button>
            <button type="button" class="btn btn-outline-danger" id="sqlEditorBtn">SQL Editor</button>
            <div id="tableOutput"></div>
        </div>

        <!-- // zj: modal-stuff -->

        <!-- password reset Confirmation Modal -->
        <div class="modal fade" id="resetPasswordModal" tabindex="-1" aria-labelledby="confirmationModalLabel" aria-hidden="true">
            <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                <h5 class="modal-title" id="confirmationModalLabel">Confirm Password Reset</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <p class="mb-2">This action is destructive and will reset the user's password - a new system-generated password will be emailed to the user.</p>
                    <p>Are you sure you want to proceed?</p>
                </div>
                <div class="modal-footer">
                <button type="button" class="btn btn-secondary" id="cancelResetPassword">Cancel</button>
                <button type="button" class="btn btn-danger" id="proceedResetPassword">Yes, Reset Password</button>
                </div>
            </div>
            </div>
        </div>

        <!-- apiList modal -->
        <div class="modal fade" id="apiListModal" tabindex="-1" aria-labelledby="apiListModalLabel" aria-hidden="true">
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
                        <!-- <button type="button" class="btn btn-danger" id="deleteKpi">Delete</button> -->
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        <button type="button" class="btn btn-primary" id="saveKpi">Save</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- user modal edit -->
        <div class="modal fade" id="userModal" tabindex="-1" aria-labelledby="userModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="userModalLabel">User Entry</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form id="userEditForm">
                            <input type="hidden" id="id" name="id">
                            <label for="email">email</label>
                            <input type="email" id="email" name="email" class="required" data-bs-toggle="popover" data-bs-trigger="manual" data-bs-custom-class="error-popover" data-bs-placement="top" data-bs-content="">
                            <br>
                            <label for="username">username</label>
                            <input type="text" id="username" name="username" class="required">
                            <br>
                            <label for="displayName">displayName</label>
                            <input type="text" id="displayName" name="displayName" class="required">
                            <br>
                            <label for="bureau">bureau</label>
                            <select id="bureau" name="bureau" class="required">
                                <option value="*">Admin</option>
                            </select>
                            <br>
                            <label for="disabled">disabled</label>
                            <input class="form-check-input" type="checkbox" value="true" id="disabled" name="disabled">
                            <br>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Close</button>
                        <button type="button" class="btn btn-outline-danger" id="showResetPasswordModal">Reset Password</button>
                        <button type="button" class="btn btn-outline-primary" id="saveUser">Save</button>
                    </div>
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
        <!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/2.9.2/umd/popper.min.js"
            integrity="sha512-2rNj2KJ+D8s1ceNasTIex6z4HWyOnEYLVC3FigGOmyQCZc2eBXKgOxQmo3oKLHyfcj53uz4QMsRCWNbLd32Q1g=="
            crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.2/js/bootstrap.min.js"
            integrity="sha512-WW8/jxkELe2CAiE4LvQfwm1rajOS8PHasCCx+knHG0gBHt8EXxS6T6tJRTGuDQVnluuAvMxWF4j8SNFDKceLFg=="
            crossorigin="anonymous" referrerpolicy="no-referrer"></script> -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
        <script
            src="https://cdn.jsdelivr.net/npm/@microsoft/microsoft-graph-client@3.0.0/dist/esm/index.js"></script>

        <script src="/workhorse/js/index.js"></script>
        <script src="/workhorse/js/jquery.numericInput.js"></script>
        <script src="/workhorse/js/floatLabels.js"></script>
        <script src="/workhorse/js/navbar.js"></script>
        <script
            src="https://cdn.datatables.net/v/bs5/dt-1.13.8/b-2.4.2/b-colvis-2.4.2/b-html5-2.4.2/cr-1.7.0/r-2.5.0/sr-1.3.0/datatables.min.js"></script>
        <script src="https://kit.fontawesome.com/208550a0ca.js" crossorigin="anonymous"></script>

        <script>
            $(function() {
                // get current year
                var currentYear = new Date().getFullYear();
                var $yearInput = $('#year-input');
                $yearInput.val(currentYear);

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


                // set field attributes on load
                setFieldAttributes();
                // load any saved data on initial pageload
                $("#kpiName").change();

                // test data button
                $("#apiList").click(function() {
                    showApiList();
                });


                // zj: kpi editing
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
                                language: {
                                    search: 'filter:'
                                },
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
                                    $.ajax({
                                        url: 'isAdmin',
                                        type: 'GET',
                                        success: function(isAdmin) {
                                            if (isAdmin) {
                                                $("div.toolbar").html('<button type="button" class="btn btn-outline-success btn-sm" id="kpi_addNew" title="add new KPI" data-bs-toggle="modal" data-bs-target="#Modal"><i class="fa-solid fa-plus"></i> KPI</button>');
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
                                console.info("kpi edit: " + id);
                                editKpi(id);
                            });

                        },
                        error: function(xhr, status, error) {
                            console.error('Error retrieving JSON data:', error);
                            // Handle error response
                        }
                    });

                });

                //////////////// zj: user datatables //////////////////////////////////////
                $("#userSubmit").click(function(e) {
                    e.preventDefault();
                    $("#userEditDiv").text("database not loaded");

                    $.ajax({
                        url: 'users',
                        type: 'GET',
                        dataType: 'json',
                        success: function(data) {
                            // Build the HTML table
                            var tableHtml = '<table class="table table-striped data-tables" id="user_table"><thead><tr>';
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
                                        tableHtml += '<td scope="row" data-id="' + value + '"><i class="fa-regular fa-pen-to-square" alt="edit" data-bs-toggle="modal" data-bs-target="#userModal"></i></td>';
                                    } else {
                                        tableHtml += '<td>' + value + '</td>';
                                    }
                                });
                                tableHtml += '</tr>';
                            });

                            tableHtml += '</tbody></table>';
                            $('#userEditDiv').html(tableHtml);
                            $("table#user_table").DataTable({
                                columnDefs: [
                                    {
                                        target: 4,
                                        visible: false,
                                        searchable: false
                                    },
                                    {
                                        target: 0,
                                        orderable: false,
                                        searchable: false
                                    },
                                    { width: '25%', targets: [1,2,3] }
                                ],
                                scrollX: true,
                                colReorder: true,
                                // stateSave: true,
                                dom: 'f<"toolbar">rtip',
                                language: {
                                    search: 'filter:'
                                },
                                initComplete: function() {
                                    // add buttons to table row
                                    $.ajax({
                                        url: 'isAdmin',
                                        type: 'GET',
                                        success: function(isAdmin) {
                                            if (isAdmin) {
                                                $("div.toolbar").html('<button type="button" class="btn btn-outline-success btn-sm" id="user_addNew" title="add new user" data-bs-toggle="modal" data-bs-target="#userModal"><i class="fa-solid fa-user-plus"></i></button>');
                                                // attach click event to addNew button
                                                $("div.toolbar").on("click", "#user_addNew", function() {
                                                    console.info("new button, reset form");
                                                    var $form = $("form#userEditForm");
                                                    $(".error").removeClass("error");
                                                    $form[0].reset();
                                                    $("#showResetPasswordModal").hide();
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
                            $("ul.pagination", "#user_table_paginate").addClass("pagination-sm");
                            $("table#user_table").on("click", "i.fa-regular", function() {
                                var id = $(this).parent().attr("data-id");
                                console.info("user edit: " + id);
                                editUser(id);
                            });

                        },
                        error: function(xhr, status, error) {
                            console.error('Error retrieving JSON data:', error);
                            // Handle error response
                        }
                    });

                });
                //////////////// zj: user datatables //////////////////////////////////////

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

                // reset password stuff
                $("#userModal").on("click", "#showResetPasswordModal", function() {
                    $('#userModal').modal('hide');
                    $('#resetPasswordModal').modal('show');
                });
                $("#resetPasswordModal").on("click", "#cancelResetPassword", function() {
                    $('#userModal').modal('show');
                    $('#resetPasswordModal').modal('hide');
                });
                $("#proceedResetPassword").click(function() {
                    var $button = $(this);
                    // Add a loading spinner to the button text
                    var originalText = $button.html();
                    $button.html('<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> Working...');

                    var csrfToken = $("meta[name='_csrf']").attr("content");
                    var csrfHeader = $("meta[name='_csrf_header']").attr("content");
                    var id = $("#id", '#userModal').val();
                    
                    // Make the AJAX call
                    $.ajax({
                        url: 'resetPassword', // Update with your endpoint URL
                        method: 'POST',
                        data: { id: id }, // Update with necessary data
                        beforeSend: function(xhr) {
                            xhr.setRequestHeader(csrfHeader, csrfToken);
                        },
                        success: function(response) {
                            // Handle success response
                            console.log(response); // You can remove this

                            // Restore button text and show success message
                            $button.html(originalText);
                            $('#successModal').modal('show');
                            
                            // Optional: Close the original modal if needed
                            $('#resetPasswordModal').modal('hide');
                        },
                        error: function(xhr, status, error) {
                            // Handle error response
                            console.error(error);
                            
                            // Restore button text and re-enable the button
                            $button.html(originalText);
                            $button.prop('disabled', false);
                            
                            // Optionally show an error message to the user
                            alert('An error occurred while resetting the password. Please try again.');
                        }
                    });
                });
                
                // save user
                $("#userModal").on("click", "#saveUser", function() {
                    $(".error").removeClass("error");
                    var $btn = $(this);
                    
                    // var $form = $(this).parents("form");
                    var $form = $("form#userEditForm");
                    // zj: not sure if this was broken or something...

                    var id = $("#id", $form).val();
                    var userData = {};

                    // validate required fields
                    $("input.required", $form).each(function() {
                        if ($(this).val().trim() === '') {
                            $(this).addClass('error');
                        } else {
                            $(this).removeClass('error');
                        }
                    });
                    if ($(".error").length > 0) {
                        return;
                    }
                    $form.serializeArray().forEach(function(item) {
                        userData[item.name] = item.value;
                    });
                    console.info("userData: " + JSON.stringify(userData));

                    var token = $("meta[name='_csrf']").attr("content");
                    var header = $("meta[name='_csrf_header']").attr("content");

                    var operationType = $("#id", $form).val() ? "update" : "new";
                    if (operationType == "update") {
                        console.info("updating user");
                        
                        var fromProfile = $form.attr("data-profile");
                        var url = 'user/' + id;
                        if (typeof fromProfile !== 'undefined' && fromProfile !== false) {
                            url += "?profileUpdate=true";
                        }

                        $.ajax({
                            type: 'PUT',
                            url: url,
                            contentType: 'application/json',
                            data: JSON.stringify(userData),
                            beforeSend: function(xhr) {
                                xhr.setRequestHeader(header, token);
                            },
                            success: function(response) {
                                console.log('User updated successfully:', response);
                                showSuccess('User updated successfully:', response);
                                // Handle success, e.g., show a success message
                            },
                            error: function(error) {
                                alert('Error updating user:', error);
                                console.info(error);
                                // Handle error, e.g., show an error message
                            }
                        });
                    } else if (operationType == "new") {
                        console.info("saving new user");
                        // Add a loading spinner to the button text
                        var originalText = $btn.html();
                        $btn.html('<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> Working...').prop("disabled", "disabled");

                        // check if email exists before saving user
                        var $email = $("#email", $form).popover('hide').popover('dispose');
                        var duplicateEmail = false;
                        var email = $email.val();
                        if (email) {
                            $.ajax({
                                url: 'users/exists',
                                type: 'GET',
                                data: { email: email },
                                success: function(response) {
                                    if (response) {
                                        $email.addClass('error');
                                        $email.attr('data-bs-content', 'address already in use');
                                        $email.popover('show');
                                        $btn.html(originalText).prop("disabled", false);
                                        // Auto-hide the popover after 5 seconds
                                        setTimeout(function() {
                                            $email.popover('hide');
                                        }, 5000);

                                        // Hide the popover when the field is changed
                                        $email.on('input', function() {
                                            $email.popover('hide');
                                        });
                                    } else {
                                        $email.removeClass('error');
                                        $email.popover('hide').popover('dispose');
                                        // cover form with semi-transparent overlay during saving
                                        var overlay = $('<div id="loadingOverlay" class="position-absolute w-100 h-100 bg-light" style="opacity: 0.7; top: 0; left: 0; z-index: 10;">' +
                                                        '<div class="d-flex justify-content-center align-items-center h-100">' +
                                                        '<div class="spinner-grow" role="status">' +
                                                        '<span class="sr-only">Loading...</span>' +
                                                        '</div></div></div>');
                                        $(".modal-body", "#userModal").append(overlay); // Append overlay to modal body
                                        
                                        // do the thing
                                        if (!duplicateEmail) {
                                            $.ajax({
                                                type: 'POST',
                                                url: 'user',
                                                contentType: 'application/json',
                                                data: JSON.stringify(userData),
                                                beforeSend: function(xhr) {
                                                    xhr.setRequestHeader(header, token);
                                                },
                                                success: function(response) {
                                                    console.log('user added successfully:', response.toString());
                                                    showSuccess('user added successfully: ' + response.toString());
                                                    // Handle success, e.g., show a success message
                                                },
                                                error: function(error) {
                                                    alert('Error saving user:', error);
                                                },
                                                complete: function() {
                                                    // Restore button text and show success message
                                                    $("#loadingOverlay").remove(); // Remove the overlay
                                                    $btn.html(originalText).prop("disabled", false);
                                                }
                                            });
                                        } else {
                                            console.info("don't save");
                                        }
                                    }
                                },
                                error: function() {
                                    $email.addClass('error');
                                    $email.attr('data-bs-content', 'An error occurred');
                                    $email.popover('show');
                                }
                            });
                        }
                    }
                });

                // user edit modal load event
                $(".modal").on('shown.bs.modal', function() {
                    $("#bureau", "#userModal").empty().append('<option value="*">Admin</option>');
                    $.ajax({
                        url: 'kpi/bureaus',
                        type: 'GET',
                        dataType: 'json',
                        success: function(response) {
                            for (var i = 0; i < response.length; i++) {
                                $("#bureau", "#userModal").append('<option value="'+ response[i] + '">'+ response[i] + '</option>');
                            }
                        },
                        error: function(error) {
                            console.error('Error fetching record list:', error);
                        }
                    });
                });

                $(".modal").on('hidden.bs.modal', function() {
                    var $form = $(this).find("form");
                    $(".error").removeClass("error");
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
                    // prevent fouc
                    $("#test-data").hide();
                    $("#loadingSpinner").show();

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
                            $kpiTable += '</select></th></tr><tr class="table-success"><th colspan=2 id="kpi_title"></th></tr>';
                            $kpiTable += '</thead><tbody class="table-group-divider">';
                            
                            //assemble month rows
                            var months = [
                                'January', 'February', 'March', 'April', 'May', 'June',
                                'July', 'August', 'September', 'October', 'November', 'December'
                            ];
                            for (var i = 0; i < months.length; i++) {
                                var monthNumber = (i + 1).toString().padStart(2, '0'); // Convert month number to two-digit format
                                var inputId = monthNumber + '-01'; // Create the id in the format "MM-01"
                                var row = '<tr><td class="border-start border-light-subtle">' + months[i] + '</td>';
                                row += '<td class="p-1">' + '<div class="input-group"><span class="input-group-text">#</span><input type="text" inputmode="numeric" class="form-control record-data" data-month="' + inputId + '"></div>' + '</td>';
                                row += '</tr>';
                                $kpiTable += row;
                            }

                            $kpiTable += '<tr><td colspan=2 class="border-bottom-0 text-center px-0"><button type="button" id="saveRecord" class="btn btn-outline-success w-100" disabled="disabled">Save</button></td></tr></tbody></table>';
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

                $("#userModal").on("change", "#email", function() {
                    var $username = $("#username", "#userModal");
                    if ($username.val() == "") {
                        var name = $(this).val().match(/^([^@]*)@/)[1];
                        console.info("set username to " + name);
                        $("#username", "#userModal").val(name);
                    }
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
                    // prevent fouc
                    $("#test-data").hide();
                    $("#loadingSpinner").show();

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
                                // prevent fouc
                                $("#test-data").show();
                                $("#loadingSpinner").hide();
                                $("#year_testing").val($("#year_testing option:first").val()).change();
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
                                // reset the data-ogvalue attributes
                                $("input.record-data").each(function() {
                                    var $input = $(this);
                                    if ($input.val() == "") {
                                        $input.removeAttr("data-ogvalue");
                                    }
                                });
                            },
                            error: function(error) {
                                console.error('Error fetching record list:', error);
                            },
                            complete: function() {
                                // prevent fouc
                                $("#test-data").show();
                                $("#loadingSpinner").hide();
                            }
                        });
                    }
                });

                $("body").on("click", ".year-button", function() {
                    var $this = $(this);
                    var year = $this.text();
                    
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

                $("#updateDisplayName").click(function() {
                    var id = $("#userProfileForm #id").val();
                    var displayName = $("#userProfileForm #displayName").val();
                    var csrfToken = $("meta[name='_csrf']").attr("content");
                    var csrfHeader = $("meta[name='_csrf_header']").attr("content");
                    $.ajax({
                        url: 'updateDisplayName/' + id,
                        type: 'PUT',
                        data: { displayName: displayName },
                        beforeSend: function(xhr) {
                            xhr.setRequestHeader(csrfHeader, csrfToken);
                        },
                        success: function(user) {
                            showSuccess("Updated successfully");
                        },
                        error: function() {
                            alert('ERROR: failed to update display name');
                        }
                    });
                });

                // show message onload if present
                if ("${successMessage}") {
                    showSuccess("${successMessage}");
                } 
                
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
                $(".changed").removeClass('changed');
                var year = $("#year_testing").val();

                // check datatype
                var kpiId = $("#kpi_testing").val();
                var datatype = "";
                $.ajax({
                    url: '/workhorse/kpi/' + kpiId + '/data', // Adjust if your context-path is different
                    type: 'GET',
                    success: function(response) {
                        datatype = response;
                    },
                    error: function(xhr, status, error) {
                        console.error("Error fetching KPI Data Type: " + error);
                        alert("Error fetching KPI Data Type: " + error);
                    },
                    complete: function() {
                        // set datatype
                        var dataSymbol = "?";
                        if (datatype === "PRCT") {
                            dataSymbol = "%";
                        } else if (datatype === "COUNT") {
                            dataSymbol = "#";
                        } else {
                            console.info("Unexpected KPI Data Type: " + datatype);
                            alert("Unexpected KPI Data Type: " + datatype);
                        }

                        $("input.record-data").each(function() {
                            var $this = $(this).numeric();
                            var id = $this.attr("data-month");
                            $this.attr("id", year + "-" + id);
                            $this.prev(".input-group-text").html(dataSymbol);
                            if (isNew) {
                                $this.attr("data-ogvalue", "~new~");
                            }
                        });
                    }
                });

            }

            function executeSql() {
                var $input = $("textarea#input");
                var $output = $("textarea#output");
                var query = $input.val();
                var encodedQuery = encodeURIComponent(query);
                var url = 'http://127.0.0.1:8080/workhorse/sql/execute?query=' + encodedQuery;
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
                                $("#" + key).attr("checked", value);
                            } else {
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

            // edit user (this should probably become "load user" and go from there...?)
            function editUser(id) {
                $.ajax({
                    url: 'user/' + id,
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
                                console.info('$("#' + key + '").val("' + value + '");');
                                $("#" + key, "#userEditForm").val(value);
                                // zj: fix the couple broken fields
                            }
                        });
                        // disable email & username fields if it's an admin update from user data (keeps us from breaking data)
                        var editId = $("#id", "#userEditForm");
                        if (editId.val() != "") {
                            $("#username, #email", "#userEditForm").prop("disabled", true);
                        }
                        $("#showResetPasswordModal").show();
                    },
                    error: function(xhr, status, error) {
                        alert("ERROR");
                        console.error('Error retrieving JSON data:', error);
                        // Handle error response
                    }
                });
            }

            function showSuccess(message) {
                $('.modal.fade.show').modal('hide');
                $(".reload-btn:visible").click();

                // Create a new toast element
                var toast = $('<div class="toast bg-success text-white" role="alert" aria-live="assertive" aria-atomic="true" data-delay="8000" style="position: absolute; top: 100px; left: 50%; transform: translateX(-50%);"><div class="toast-body text-center">' + message + '</div></div>');

                // Append the toast to the body
                $('body').append(toast);

                // Show the toast
                toast.toast('show');

                // Remove the toast after it is hidden
                toast.on('hidden.bs.toast', function() {
                    toast.remove();
                });

                // Clear the session variable via AJAX
                $.ajax({
                    type: "POST",
                    url: "auth/reset",
                    success: function() {
                        console.log("Success message cleared from session.");
                    },
                    error: function() {
                        console.error("Failed to clear success message from session.");
                    }
                });

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

</html>