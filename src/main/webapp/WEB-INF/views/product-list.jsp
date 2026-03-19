<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Products - Spring MVC CRUD</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); min-height: 100vh; }
        .navbar { background: white; padding: 1rem 2rem; box-shadow: 0 2px 10px rgba(0,0,0,0.1); display: flex; justify-content: space-between; align-items: center; }
        .nav-links a { margin-left: 20px; text-decoration: none; color: #667eea; font-weight: 500; }
        .nav-links a:hover { color: #764ba2; }
        .container { max-width: 1200px; margin: 30px auto; padding: 20px; }
        .header-card { background: white; border-radius: 10px; padding: 25px; margin-bottom: 25px; box-shadow: 0 4px 6px rgba(0,0,0,0.1); display: flex; justify-content: space-between; align-items: center; }
        .btn { padding: 10px 20px; border: none; border-radius: 5px; cursor: pointer; text-decoration: none; display: inline-block; transition: all 0.3s ease; }
        .btn-primary { background: #667eea; color: white; }
        .btn-primary:hover { background: #5a67d8; transform: translateY(-2px); }
        .btn-edit { background: #48bb78; color: white; padding: 5px 10px; font-size: 12px; margin-right: 5px; }
        .btn-delete { background: #f56565; color: white; padding: 5px 10px; font-size: 12px; }
        .btn-view { background: #4299e1; color: white; padding: 5px 10px; font-size: 12px; margin-right: 5px; }
        .btn-order { background: #ed8936; color: white; padding: 5px 10px; font-size: 12px; margin-right: 5px; }
        .table-container { background: white; border-radius: 10px; padding: 20px; box-shadow: 0 4px 6px rgba(0,0,0,0.1); overflow-x: auto; }
        table { width: 100%; border-collapse: collapse; }
        th { background: #f7fafc; padding: 15px 10px; text-align: left; font-weight: 600; color: #4a5568; border-bottom: 2px solid #e2e8f0; }
        td { padding: 15px 10px; border-bottom: 1px solid #e2e8f0; color: #4a5568; }
        tr:hover { background: #f7fafc; }
        .stock-low { color: #f56565; font-weight: bold; }
        .stock-medium { color: #ed8936; font-weight: bold; }
        .stock-high { color: #48bb78; font-weight: bold; }
        .alert { padding: 15px; border-radius: 5px; margin-bottom: 20px; }
        .alert-success { background: #c6f6d5; color: #22543d; border: 1px solid #9ae6b4; }
        .alert-error { background: #fed7d7; color: #742a2a; border: 1px solid #feb2b2; }
        .logout-btn { background: #dc3545; color: white !important; padding: 8px 15px; border-radius: 5px; }
        .search-box { margin-bottom: 20px; display: flex; gap: 10px; }
        .search-box input { flex: 1; padding: 10px; border: 2px solid #e2e8f0; border-radius: 5px; }
        .search-box button { padding: 10px 20px; background: #667eea; color: white; border: none; border-radius: 5px; cursor: pointer; }
    </style>
</head>
<body>
    <div class="navbar">
        <h2>📦 Product Management</h2>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/dashboard">Dashboard</a>
            <a href="${pageContext.request.contextPath}/users">Users</a>
            <a href="${pageContext.request.contextPath}/products">Products</a>
            <a href="${pageContext.request.contextPath}/logout" class="logout-btn">Logout</a>
        </div>
    </div>
    
    <div class="container">
        <c:if test="${not empty successMessage}">
            <div class="alert alert-success">${successMessage}</div>
        </c:if>
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-error">${errorMessage}</div>
        </c:if>
        
        <div class="header-card">
            <div>
                <h1>Products</h1>
                <p>Manage your product inventory</p>
            </div>
            <a href="${pageContext.request.contextPath}/products/add" class="btn btn-primary">➕ Add New Product</a>
        </div>
        
        <div class="search-box">
            <input type="text" id="searchInput" placeholder="Search by name, description or category...">
            <button onclick="searchProducts()">🔍 Search</button>
        </div>
        
        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Category</th>
                        <th>Price</th>
                        <th>Stock</th>
                        <th>Created</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${not empty products}">
                            <c:forEach items="${products}" var="product">
                                <tr>
                                    <td>#${product.id}</td>
                                    <td><strong>${product.name}</strong></td>
                                    <td>${product.category}</td>
                                    <td>₹<fmt:formatNumber value="${product.price}" pattern="#,##0.00"/></td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${product.stock <= 5}">
                                                <span class="stock-low">${product.stock} (Low)</span>
                                            </c:when>
                                            <c:when test="${product.stock <= 20}">
                                                <span class="stock-medium">${product.stock}</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="stock-high">${product.stock}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td><fmt:formatDate value="${product.createdDate}" pattern="dd-MM-yyyy"/></td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/products/edit/${product.id}" class="btn-edit">✏️ Edit</a>
                                        <a href="#" onclick="confirmDelete(${product.id})" class="btn-delete">🗑️ Delete</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="7" style="text-align: center; padding: 40px;">
                                    <h3>No Products Found</h3>
                                    <p>Click "Add New Product" to create one.</p>
                                </td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
    </div>
    
    <div id="deleteModal" style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.5); z-index: 1000;">
        <div style="background: white; width: 400px; margin: 200px auto; padding: 30px; border-radius: 10px; text-align: center;">
            <h3 style="color: #4a5568; margin-bottom: 15px;">Confirm Delete</h3>
            <p style="color: #718096; margin-bottom: 25px;">Are you sure you want to delete this product?</p>
            <p style="color: #f56565; font-size: 14px; margin-bottom: 20px;">This action cannot be undone!</p>
            <a href="#" id="confirmDeleteBtn" class="btn btn-delete" style="padding: 10px 30px;">Yes, Delete</a>
            <button onclick="closeDeleteModal()" class="btn" style="background: #cbd5e0; margin-left: 10px; padding: 10px 30px;">Cancel</button>
        </div>
    </div>
    
    <script>
        function confirmDelete(productId) {
            document.getElementById('confirmDeleteBtn').href = '${pageContext.request.contextPath}/products/delete/' + productId;
            document.getElementById('deleteModal').style.display = 'block';
        }
        function closeDeleteModal() {
            document.getElementById('deleteModal').style.display = 'none';
        }
        function searchProducts() {
            var keyword = document.getElementById('searchInput').value;
            if(keyword.trim() !== '') {
                window.location.href = '${pageContext.request.contextPath}/products/search?keyword=' + encodeURIComponent(keyword);
            }
        }
        setTimeout(function() {
            document.querySelectorAll('.alert').forEach(alert => alert.style.display = 'none');
        }, 3000);
    </script>
</body>
</html>