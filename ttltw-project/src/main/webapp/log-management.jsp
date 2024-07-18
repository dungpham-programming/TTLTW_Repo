<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>DDD. Admin - Quản lý log</title>
    <jsp:include page="/common/admin/using-resource-header.jsp"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.0.1/styles/default.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.0.1/highlight.min.js"></script>
    <script>hljs.highlightAll();</script>
</head>
<body class="sb-nav-fixed">
<jsp:include page="/common/admin/top-header.jsp"/>
<div id="layoutSidenav">
    <jsp:include page="/common/admin/left-navigation.jsp"/>
    <div id="layoutSidenav_content" class="gray-bg">
        <main>
            <div class="container-fluid px-4">
                <h1 class="mt-4">Quản lý log</h1>
                <ol class="breadcrumb mb-4">
                    <li class="breadcrumb-item active">DDD. Administrator</li>
                </ol>
                <div class="card mb-4 mt-4">
                    <div class="card-header">
                        <i class="fas fa-table me-1"></i>
                        Quản lý log
                    </div>
                    <div class="list-button">
                        
                    </div>
                    <div class="card">
                        <div class="card-body">
                            <table id="logData" class="table table-striped" style="width:100%">
                                <thead>
                                <tr>
                                    <th>#</th>
                                    <th>IP</th>
                                    <th>Quốc gia</th>
                                    <th>Cấp độ</th>
                                    <th>Thông tin log</th>
                                    <th>Giá tri trước đó</th>
                                    <th>Giá trị hiện tại</th>
                                    <th>Tạo ngày</th>
                                    <th>Tạo bởi</th>
                                    <th>Chức năng</th>
                                </tr>
                                </thead>
                                <tbody>
                                </tbody>
                                <tfoot>
                                <tr>
                                    <th>#</th>
                                    <th>IP</th>
                                    <th>Quốc gia</th>
                                    <th>Cấp độ</th>
                                    <th>Thông tin log</th>
                                    <th>Giá tri trước đó</th>
                                    <th>Giá trị hiện tại</th>
                                    <th>Tạo ngày</th>
                                    <th>Tạo bởi</th>
                                    <th>Chức năng</th>
                                </tr>
                                </tfoot>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>
</div>

<!-- Modal -->
<div class="modal fade" id="showJsonData" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-scrollable modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5">Thông tin của cột</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <p class="json-content"></p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/common/admin/using-resource-footer.jsp"/>
<script src="<c:url value="/templates/logic-datatable/admin/datatable-log.js"/>"></script>
<script src="<c:url value="/templates/logic-datatable/service-logic.js"/>"></script>
<script src="<c:url value="/templates/modal/show-modal.js"/>"></script>
</body>
</html>