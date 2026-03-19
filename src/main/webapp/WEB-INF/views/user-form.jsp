<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Form - Spring MVC CRUD</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
        }
        
        .navbar {
            background: white;
            padding: 1rem 2rem;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .nav-links a {
            margin-left: 20px;
            text-decoration: none;
            color: #667eea;
            font-weight: 500;
        }
        
        .container {
            max-width: 600px;
            margin: 50px auto;
            padding: 20px;
        }
        
        .form-card {
            background: white;
            border-radius: 10px;
            padding: 30px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }
        
        .form-card h2 {
            color: #333;
            margin-bottom: 10px;
        }
        
        .form-card p {
            color: #666;
            margin-bottom: 30px;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 5px;
            color: #4a5568;
            font-weight: 500;
        }
        
        .form-group input,
        .form-group select {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e2e8f0;
            border-radius: 5px;
            font-size: 14px;
            transition: border-color 0.3s ease;
        }
        
        .form-group input:focus,
        .form-group select:focus {
            outline: none;
            border-color: #667eea;
        }
        
        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }
        
        .btn {
            padding: 12px 30px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            font-weight: 500;
            transition: all 0.3s ease;
        }
        
        .btn-primary {
            background: #667eea;
            color: white;
        }
        
        .btn-primary:hover {
            background: #5a67d8;
            transform: translateY(-2px);
        }
        
        .btn-secondary {
            background: #cbd5e0;
            color: #4a5568;
            margin-left: 10px;
        }
        
        .btn-secondary:hover {
            background: #a0aec0;
        }
        
        .error {
            color: #f56565;
            font-size: 12px;
            margin-top: 5px;
        }
        
        .logout-btn {
            background: #dc3545;
            color: white !important;
            padding: 8px 15px;
            border-radius: 5px;
        }
    </style>
</head>
<body>
    <div class="navbar">
        <h2>📝 User Form</h2>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/dashboard">Dashboard</a>
            <a href="${pageContext.request.contextPath}/users">User List</a>
            <a href="${pageContext.request.contextPath}/logout" class="logout-btn">Logout</a>
        </div>
    </div>
    
    <div class="container">
        <div class="form-card">
            <h2><c:choose>
                <c:when test="${empty user.id}">Add New User</c:when>
                <c:otherwise>Edit User</c:otherwise>
            </c:choose></h2>
            <p>Please fill in the user details below</p>
            
            <form:form action="${pageContext.request.contextPath}/users/${empty user.id ? 'save' : 'update'}" 
                       method="post" 
                       modelAttribute="user">
                
                <c:if test="${not empty user.id}">
                    <form:hidden path="id"/>
                </c:if>
                
                <div class="form-row">
                    <div class="form-group">
                        <label for="username">Username *</label>
                        <form:input path="username" id="username" required="true"/>
                        <form:errors path="username" cssClass="error"/>
                    </div>
                    
                    <div class="form-group">
                        <label for="password">Password *</label>
                        <form:password path="password" id="password" required="${empty user.id}"/>
                        <form:errors path="password" cssClass="error"/>
                        <c:if test="${not empty user.id}">
                            <small style="color: #718096;">Leave blank to keep current password</small>
                        </c:if>
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="email">Email *</label>
                    <form:input path="email" id="email" type="email" required="true"/>
                    <form:errors path="email" cssClass="error"/>
                </div>
                
                <div class="form-group">
                    <label for="fullName">Full Name *</label>
                    <form:input path="fullName" id="fullName" required="true"/>
                    <form:errors path="fullName" cssClass="error"/>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label for="role">Role</label>
                        <form:select path="role" id="role">
                            <form:option value="USER">User</form:option>
                            <form:option value="ADMIN">Admin</form:option>
                            <form:option value="MANAGER">Manager</form:option>
                        </form:select>
                    </div>
                    
                    <div class="form-group">
                        <label for="status">Status</label>
                        <form:select path="status" id="status">
                            <form:option value="ACTIVE">Active</form:option>
                            <form:option value="INACTIVE">Inactive</form:option>
                            <form:option value="LOCKED">Locked</form:option>
                        </form:select>
                    </div>
                </div>
                
                <div style="text-align: center; margin-top: 30px;">
                    <button type="submit" class="btn btn-primary">
                        <c:choose>
                            <c:when test="${empty user.id}">Create User</c:when>
                            <c:otherwise>Update User</c:otherwise>
                        </c:choose>
                    </button>
                    <a href="${pageContext.request.contextPath}/users" class="btn btn-secondary">Cancel</a>
                </div>
            </form:form>
        </div>
    </div>
</body>
</html>