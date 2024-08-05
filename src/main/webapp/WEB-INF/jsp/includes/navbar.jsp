<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!-- navbar -->
<nav class="navbar navbar-expand navbar-dark bg-dark">
    <div class="container-fluid">
        <a class="navbar-brand" href="/workhorse">
            <img class="logo" src="/workhorse/img/small-light2.png">
            <span class="ml-2 pt-1">WORKHORSE <small class="version">
                    <a class="nav-link" id="buildId"></a></small>
            </span>
        </a>
        <h3 id="section-title"></h3>
        <ul class="navbar-nav mb-2 mb-lg-0 ms-auto me-5">
            <li class="nav-item dropdown float-end">
                <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                    <i class="fa-solid fa-user-gear pe-2"></i><c:out value="${displayname}" />
                </a>
                <ul class="dropdown-menu" data-bs-theme="dark">
                    <li><a class="dropdown-item section" id="manual_entry" href="#">Data Entry</a></li>
                    <li><a class="dropdown-item section" id="kpi_edit" href="#">KPI Data</a></li>
                    <li><a class="dropdown-item section" id="user_edit" href="#">User Data</a></li>
                    <hr class="dropdown-divider">
                    <li><a class="dropdown-item" id="apiList" href="#" data-bs-toggle="modal" data-bs-target="#apiListModal">API Endpoint List</a></li>
                    <li><a class="dropdown-item section" id="analyzeDb" href="#">Analyze Database</a></li>
                    <hr class="dropdown-divider">
                    <li><a class="dropdown-item section" id="user_profile" href="#">User Profile</a></li>
                    
                    <!-- logout -->
                    <li>
                        <form id="logoutForm" action="${pageContext.request.contextPath}/logout" method="post">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                            <a class="dropdown-item" href="#" onclick="document.getElementById('logoutForm').submit();">logout</a>
                        </form>
                    </li>
                </ul>
            </li>
        </ul>
    </div>
</nav>

<script>
    $(function() {

    });
</script>