<!doctype html>

<%@ page isErrorPage="true" %>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="en">

    <head>
        <title>WORKHORSE</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.2/css/bootstrap.min.css"
            integrity="sha512-b2QcS5SsA8tZodcDtGRELiGv5SaKSk1vDHDaQRda0htPYWZ6046lr3kJ5bAAQdpV2mmA/4v0wQF9MyU6/pDIAg=="
            crossorigin="anonymous" referrerpolicy="no-referrer" />

        <link rel="stylesheet" href="/workhorse/css/style.css">

    </head>

    <body>
        <jsp:include page="/WEB-INF/jsp/includes/navbar.jsp" />

        <br>

        <div class="container-fluid">
            <h1 class="mt-1">Error :(</h1>
            <p class="lead">Sorry, something went wrong.</p>
            <p>Error Code: ${statusCode}</p>
            <p>Error Message: ${message}</p>
            <p>${exception}</p>
            <a href="/workhorse" class="btn btn-primary">Go Home</a>
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

        <script src="https://code.jquery.com/jquery-3.4.1.min.js"
            integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo=" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/2.9.2/umd/popper.min.js"
            integrity="sha512-2rNj2KJ+D8s1ceNasTIex6z4HWyOnEYLVC3FigGOmyQCZc2eBXKgOxQmo3oKLHyfcj53uz4QMsRCWNbLd32Q1g=="
            crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.2/js/bootstrap.min.js"
            integrity="sha512-WW8/jxkELe2CAiE4LvQfwm1rajOS8PHasCCx+knHG0gBHt8EXxS6T6tJRTGuDQVnluuAvMxWF4j8SNFDKceLFg=="
            crossorigin="anonymous" referrerpolicy="no-referrer"></script>

            <script src="/workhorse/js/index.js"></script>
            <script src="/workhorse/js/jquery.numericInput.js"></script>
            <script src="/workhorse/js/floatLabels.js"></script>
            <script src="/workhorse/js/navbar.js"></script>
            <script
                src="https://cdn.datatables.net/v/bs5/dt-1.13.8/b-2.4.2/b-colvis-2.4.2/b-html5-2.4.2/cr-1.7.0/r-2.5.0/sr-1.3.0/datatables.min.js"></script>
            <script src="https://kit.fontawesome.com/208550a0ca.js" crossorigin="anonymous"></script>

        <script src="https://kit.fontawesome.com/208550a0ca.js" crossorigin="anonymous"></script>

        <script>
            $(function() {
                console.info("error page");
            });
        </script>

    </body>

</html>