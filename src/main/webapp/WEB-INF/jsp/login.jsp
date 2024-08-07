<!doctype html>

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

        <style>
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

        .login-container {
            max-width: 400px;
            margin: auto;
            padding-top: 50px;
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
            </div>
        </nav>

        <br>

        <c:choose>
            <c:when test="${title == 'Login'}">
                <c:set var="formAction" value="login"/>
            </c:when>
            <c:otherwise>
                <c:set var="formAction" value="changePassword"/>
            </c:otherwise>
        </c:choose>

        <div class="container-fluid">
            <div class="container login-container">
                <div class="card">
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${title == 'Login'}">
                                <h3 class="card-title text-center">${title}</h3>
                                <form action="login" method="post">
                                    <div class="mb-3">
                                        <label for="username" class="form-label">Username</label>
                                        <input type="text" class="form-control" id="username" name="username" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="password" class="form-label">Password</label>
                                        <input type="password" class="form-control" id="password" name="password" required>
                                    </div>
                                    <div class="d-grid">
                                        <button type="submit" class="btn btn-primary">Login</button>
                                    </div>
                            </c:when>
                            <c:otherwise>
                                <div class="callout callout-warning"><strong>${title}</strong></div>
                                <form action="changePassword" method="post">
                                    <div class="mb-3">
                                        <label for="newPassword" class="form-label">New Password</label>
                                        <input type="password" id="newPassword" name="newPassword" class="form-control" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="confirmNewPassword" class="form-label">Confirm New Password</label>
                                        <input type="password" id="confirmNewPassword" name="confirmNewPassword" class="form-control" required>
                                    </div>
                                    <div class="d-grid">
                                        <input type="hidden" name="userId" value="${id}">
                                        <button type="submit" class="btn btn-primary">Change Password</button>
                                    </div>
                            </c:otherwise>
                        </c:choose>
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                </form>
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

        <script src="https://code.jquery.com/jquery-3.4.1.min.js"
            integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo=" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/2.9.2/umd/popper.min.js"
            integrity="sha512-2rNj2KJ+D8s1ceNasTIex6z4HWyOnEYLVC3FigGOmyQCZc2eBXKgOxQmo3oKLHyfcj53uz4QMsRCWNbLd32Q1g=="
            crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.2/js/bootstrap.min.js"
            integrity="sha512-WW8/jxkELe2CAiE4LvQfwm1rajOS8PHasCCx+knHG0gBHt8EXxS6T6tJRTGuDQVnluuAvMxWF4j8SNFDKceLFg=="
            crossorigin="anonymous" referrerpolicy="no-referrer"></script>

        <script src="https://kit.fontawesome.com/208550a0ca.js" crossorigin="anonymous"></script>


    </body>

</html>