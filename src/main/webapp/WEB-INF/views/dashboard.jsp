<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Spring MVC CRUD</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
        }
        
        /* Navbar Styles */
        .navbar {
            background: rgba(255, 255, 255, 0.95);
            padding: 1rem 2rem;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: sticky;
            top: 0;
            z-index: 100;
        }
        
        .navbar h2 {
            color: #333;
            font-size: 1.5rem;
        }
        
        .nav-links {
            display: flex;
            gap: 20px;
            align-items: center;
        }
        
        .nav-links a {
            text-decoration: none;
            color: #667eea;
            font-weight: 500;
            padding: 8px 15px;
            border-radius: 8px;
            transition: all 0.3s ease;
        }
        
        .nav-links a:hover {
            background: #667eea;
            color: white;
        }
        
        .logout-btn {
            background: #dc3545;
            color: white !important;
        }
        
        .logout-btn:hover {
            background: #c82333 !important;
        }
        
        .username-badge {
            background: #e9ecef;
            padding: 8px 15px;
            border-radius: 20px;
            color: #495057;
            font-weight: 500;
        }
        
        /* Main Container */
        .container {
            max-width: 1200px;
            margin: 30px auto;
            padding: 0 20px;
        }
        
        /* Welcome Card */
        .welcome-card {
            background: white;
            border-radius: 15px;
            padding: 30px;
            margin-bottom: 30px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            animation: slideDown 0.5s ease-out;
        }
        
        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        .welcome-card h1 {
            color: #333;
            margin-bottom: 10px;
            font-size: 2.2rem;
        }
        
        .welcome-card p {
            color: #666;
            line-height: 1.6;
            font-size: 1.1rem;
        }
        
        .welcome-time {
            color: #667eea;
            font-weight: 500;
            margin-top: 10px;
        }
        
        /* Stats Grid */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 25px;
            margin-bottom: 30px;
        }
        
        .stat-card {
            background: white;
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
            animation: fadeIn 0.5s ease-out;
        }
        
        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 15px rgba(0,0,0,0.2);
        }
        
        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        .stat-icon {
            font-size: 2.5rem;
            margin-bottom: 15px;
        }
        
        .stat-number {
            font-size: 2.5rem;
            font-weight: bold;
            color: #667eea;
            margin-bottom: 5px;
        }
        
        .stat-label {
            color: #666;
            font-size: 1rem;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        
        /* Quick Actions Grid */
        .section-title {
            color: white;
            font-size: 1.8rem;
            margin: 40px 0 20px;
            text-shadow: 0 2px 4px rgba(0,0,0,0.2);
        }
        
        .actions-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 25px;
            margin-bottom: 40px;
        }
        
        .action-card {
            background: white;
            border-radius: 15px;
            padding: 25px;
            text-decoration: none;
            color: #333;
            transition: all 0.3s ease;
            animation: fadeIn 0.5s ease-out;
            border: 2px solid transparent;
        }
        
        .action-card:hover {
            transform: translateY(-5px);
            border-color: #667eea;
            box-shadow: 0 8px 15px rgba(0,0,0,0.2);
        }
        
        .action-icon {
            font-size: 3rem;
            margin-bottom: 15px;
        }
        
        .action-title {
            font-size: 1.3rem;
            font-weight: 600;
            margin-bottom: 10px;
        }
        
        .action-desc {
            color: #666;
            font-size: 0.9rem;
            line-height: 1.5;
        }
        
        /* Recent Activity Table */
        .activity-section {
            background: white;
            border-radius: 15px;
            padding: 25px;
            margin-bottom: 30px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }
        
        .activity-section h3 {
            color: #333;
            margin-bottom: 20px;
            font-size: 1.5rem;
        }
        
        .activity-table {
            width: 100%;
            border-collapse: collapse;
        }
        
        .activity-table th {
            text-align: left;
            padding: 15px 10px;
            background: #f8f9fa;
            color: #495057;
            font-weight: 600;
            border-radius: 8px 8px 0 0;
        }
        
        .activity-table td {
            padding: 15px 10px;
            border-bottom: 1px solid #e9ecef;
            color: #666;
        }
        
        .activity-table tr:hover {
            background: #f8f9fa;
        }
        
        .status-badge {
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
        }
        
        .status-active {
            background: #d4edda;
            color: #155724;
        }
        
        .status-pending {
            background: #fff3cd;
            color: #856404;
        }
        
        .status-completed {
            background: #cce5ff;
            color: #004085;
        }
        
        /* Footer */
        .footer {
            text-align: center;
            padding: 20px;
            color: white;
            font-size: 0.9rem;
        }
        
        /* Responsive */
        @media (max-width: 768px) {
            .navbar {
                flex-direction: column;
                gap: 15px;
                text-align: center;
            }
            
            .nav-links {
                flex-wrap: wrap;
                justify-content: center;
            }
            
            .welcome-card h1 {
                font-size: 1.8rem;
            }
            
            .stats-grid {
                grid-template-columns: 1fr;
            }
            
            .actions-grid {
                grid-template-columns: 1fr;
            }
            
            .activity-table {
                font-size: 14px;
            }
        }
    </style>
</head>
<body>
    <!-- Navigation Bar -->
    <div class="navbar">
        <h2>📊 Spring MVC CRUD Dashboard</h2>
        <div class="nav-links">
            <span class="username-badge">👤 ${sessionScope.username}</span>
            <a href="${pageContext.request.contextPath}/dashboard">Home</a>
            <a href="${pageContext.request.contextPath}/users">Users</a>
            <a href="${pageContext.request.contextPath}/products">Products</a>
            <a href="${pageContext.request.contextPath}/logout" class="logout-btn">Logout</a>
        </div>
    </div>
    
    <!-- Main Container -->
    <div class="container">
        <!-- Welcome Card -->
        <div class="welcome-card">
            <h1>Welcome back, <c:out value="${sessionScope.username}" default="User"/>! 👋</h1>
            <p>This is your dashboard. You can manage users, products, and view system statistics from here.</p>
            <div class="welcome-time">
                <fmt:formatDate value="<%= new java.util.Date() %>" pattern="EEEE, dd MMMM yyyy - hh:mm a"/>
            </div>
        </div>
        
        <!-- Statistics Cards -->
        <div class="stats-grid">
            <div class="stat-card" style="animation-delay: 0.1s">
                <div class="stat-icon">👥</div>
                <div class="stat-number">${totalUsers}</div>
                <div class="stat-label">Total Users</div>
            </div>
            
            <div class="stat-card" style="animation-delay: 0.2s">
                <div class="stat-icon">📦</div>
                <div class="stat-number">${totalProducts}</div>
                <div class="stat-label">Total Products</div>
            </div>
            
            <div class="stat-card" style="animation-delay: 0.3s">
                <div class="stat-icon">🛒</div>
                <div class="stat-number">${totalOrders}</div>
                <div class="stat-label">Total Orders</div>
            </div>
            
            <div class="stat-card" style="animation-delay: 0.4s">
                <div class="stat-icon">✅</div>
                <div class="stat-number">${activeUsers}</div>
                <div class="stat-label">Active Users</div>
            </div>
        </div>
        
        <!-- Quick Actions -->
        <h2 class="section-title">⚡ Quick Actions</h2>
        <div class="actions-grid">
            <a href="${pageContext.request.contextPath}/users/add" class="action-card">
                <div class="action-icon">👤➕</div>
                <div class="action-title">Add New User</div>
                <div class="action-desc">Create a new user account with roles and permissions</div>
            </a>
            
            <a href="${pageContext.request.contextPath}/products/add" class="action-card">
                <div class="action-icon">📦➕</div>
                <div class="action-title">Add New Product</div>
                <div class="action-desc">Add a new product to your inventory</div>
            </a>
            
            <a href="${pageContext.request.contextPath}/users" class="action-card">
                <div class="action-icon">📋</div>
                <div class="action-title">View All Users</div>
                <div class="action-desc">Manage existing users, edit or delete records</div>
            </a>
            
            <a href="${pageContext.request.contextPath}/products" class="action-card">
                <div class="action-icon">📦📋</div>
                <div class="action-title">View All Products</div>
                <div class="action-desc">Browse and manage your product catalog</div>
            </a>
        </div>
        
        <!-- Recent Activity -->
        <div class="activity-section">
            <h3>📝 Recent Activity</h3>
            <table class="activity-table">
                <thead>
                    <tr>
                        <th>Time</th>
                        <th>User</th>
                        <th>Action</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${not empty recentActivities}">
                            <c:forEach items="${recentActivities}" var="activity">
                                <tr>
                                    <td><fmt:formatDate value="${activity.timestamp}" pattern="HH:mm:ss"/></td>
                                    <td>${activity.username}</td>
                                    <td>${activity.action}</td>
                                    <td>
                                        <span class="status-badge status-${activity.statusClass}">
                                            ${activity.status}
                                        </span>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="4" style="text-align: center; padding: 30px; color: #999;">
                                    No recent activity to display
                                </td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
    </div>
    
    <!-- Footer -->
    <div class="footer">
        <p>&copy; 2026 Spring MVC Hibernate CRUD Application. All rights reserved.</p>
    </div>
</body>
</html>