<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Details - Spring MVC CRUD</title>
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
            max-width: 800px;
            margin: 50px auto;
            padding: 20px;
        }
        
        .profile-card {
            background: white;
            border-radius: 10px;
            padding: 30px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }
        
        .profile-header {
            display: flex;
            align-items: center;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 2px solid #e2e8f0;
        }
        
        .avatar {
            width: 80px;
            height: 80px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 20px;
            color: white;
            font-size: 32px;
            font-weight: bold;
        }
        
        .profile-title h2 {
            color: #333;
            margin-bottom: 5px;
        }
        
        .profile-title p {
            color: #718096;
        }
        
        .info-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
            margin-bottom: 30px;
        }
        
        .info-item {
            padding: 15px;
            background: #f7fafc;
            border-radius: 8px;
        }
        
        .info-item .label {
            font-size: 12px;
            color: #718096;
            margin-bottom: 5px;
        }
        
        .info-item .value {
            font-size: 16px;
            color: #333;
            font-weight: 500;
        }
        
        .status-badge {
            display: inline-block;
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
        }
        
        .status-active {
            background: #c6f6d5;
            color: #22543d;
        }
        
        .status-inactive {
            background: #fed7d7;
            color: #742a2a;
        }
        
        .action-buttons {
            text-align: center;
            margin-top: 20px;
        }
        
        .btn {
            padding: 12px 30px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            margin: 0 5px;
            transition: all 0.3s ease;
        }
        
        .btn-edit {
            background: #48bb78;
            color: white;
        }
        
        .btn-edit:hover {
            background: #38a169;
        }
        
        .btn-back {
            background: #667eea;
            color: white;
        }
        
        .btn-back:hover {
            background: #5a67d8;
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
        <h2>👤 User Profile</h2>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/dashboard">Dashboard</a>
            <a href="${pageContext.request.contextPath}/users">User List</a>
            <a href="${pageContext.request.contextPath}/logout" class="logout-btn">Logout</a>
        </div>
    </div>
    
    <div class="container">
        <div class="profile-card">
            <div class="profile-header">
                <div class="avatar">
                    ${user.fullName.charAt(0)}
                </div>
                <div class="profile-title">
                    <h2>${user.fullName}</h2>
                    <p>@${user.username}</p>
                </div>
            </div>
            
            <div class="info-grid">
                <div class="info-item">
                    <div class="label">User ID</div>
                    <div class="value">#${user.id}</div>
                </div>
                
                <div class="info-item">
                    <div class="label">Username</div>
                    <div class="value">${user.username}</div>
                </div>
                
                <div class="info-item">
                    <div class="label">Email</div>
                    <div class="value">${user.email}</div>
                </div>
                
                <div class="info-item">
                    <div class="label">Role</div>
                    <div class="value">${user.role}</div>
                </div>
                
                <div class="info-item">
                    <div class="label">Status</div>
                    <div class="value">
                        <span class="status-badge ${user.status == 'ACTIVE' ? 'status-active' : 'status-inactive'}">
                            ${user.status}
                        </span>
                    </div>
                </div>
                
                <div class="info-item">
                    <div class="label">Created Date</div>
                    <div class="value">
                        <fmt:formatDate value="${user.createdDate}" pattern="dd MMMM yyyy, hh:mm a"/>
                    </div>
                </div>
            </div>
            
            <div class="action-buttons">
                <a href="${pageContext.request.contextPath}/users/edit/${user.id}" class="btn btn-edit">✏️ Edit User</a>
                <a href="${pageContext.request.contextPath}/users" class="btn btn-back">← Back to List</a>
            </div>
        </div>
    </div>
</body>
</html>