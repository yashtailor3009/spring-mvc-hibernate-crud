<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=yes">
    <title>Login - Spring MVC CRUD</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, sans-serif;
        }
        
        body {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 20px;
        }
        
        .login-container {
            width: 100%;
            max-width: 420px;  /* Reduced from 450px */
            background: rgba(255, 255, 255, 0.98);
            backdrop-filter: blur(10px);
            border-radius: 24px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.2);
            overflow: hidden;
            animation: slideUp 0.5s ease-out;
        }
        
        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        .login-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 35px 25px;  /* Reduced padding */
            text-align: center;
            color: white;
        }
        
        .login-header h1 {
            font-size: 28px;  /* Reduced from 32px */
            margin-bottom: 8px;
            font-weight: 600;
        }
        
        .login-header p {
            font-size: 14px;
            opacity: 0.9;
        }
        
        .login-form {
            padding: 30px 25px;  /* Reduced padding */
        }
        
        .form-group {
            margin-bottom: 20px;  /* Reduced from 25px */
        }
        
        .form-group label {
            display: block;
            margin-bottom: 6px;
            color: #4a5568;
            font-weight: 500;
            font-size: 14px;
        }
        
        .input-wrapper {
            position: relative;
            display: flex;
            align-items: center;
        }
        
        .input-icon {
            position: absolute;
            left: 14px;
            color: #a0aec0;
            font-size: 16px;
            z-index: 1;
        }
        
        .form-group input {
            width: 100%;
            padding: 14px 14px 14px 42px;  /* Adjusted padding */
            border: 2px solid #e2e8f0;
            border-radius: 12px;
            font-size: 15px;
            transition: all 0.3s ease;
            background: white;
        }
        
        .form-group input:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }
        
        .form-group input::placeholder {
            color: #cbd5e0;
            font-size: 14px;
        }
        
        .password-toggle {
            position: absolute;
            right: 14px;
            cursor: pointer;
            color: #a0aec0;
            font-size: 18px;
            z-index: 1;
            background: white;
            padding: 0 5px;
        }
        
        .password-toggle:hover {
            color: #667eea;
        }
        
        .remember-forgot {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
            flex-wrap: wrap;
            gap: 10px;
        }
        
        .remember {
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .remember input[type="checkbox"] {
            width: 16px;
            height: 16px;
            cursor: pointer;
            accent-color: #667eea;
        }
        
        .remember label {
            color: #4a5568;
            font-size: 14px;
            cursor: pointer;
        }
        
        .forgot-link {
            color: #667eea;
            text-decoration: none;
            font-size: 14px;
            font-weight: 500;
        }
        
        .forgot-link:hover {
            text-decoration: underline;
        }
        
        .btn-login {
            width: 100%;
            padding: 15px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        
        .btn-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(102, 126, 234, 0.3);
        }
        
        .btn-login:active {
            transform: translateY(0);
        }
        
        .demo-credentials {
            margin-top: 25px;
            padding: 18px;
            background: #f8fafc;
            border-radius: 14px;
            border: 1px dashed #cbd5e0;
        }
        
        .demo-credentials h3 {
            color: #4a5568;
            font-size: 14px;
            margin-bottom: 12px;
            text-align: center;
            font-weight: 600;
        }
        
        .credential-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 8px 0;
            border-bottom: 1px solid #e2e8f0;
            font-size: 13px;
        }
        
        .credential-item:last-child {
            border-bottom: none;
        }
        
        .credential-role {
            font-weight: 600;
            color: #667eea;
            background: #e9ecfe;
            padding: 4px 10px;
            border-radius: 20px;
            font-size: 12px;
        }
        
        .credential-details {
            color: #2d3748;
            font-family: monospace;
            background: #edf2f7;
            padding: 4px 10px;
            border-radius: 20px;
        }
        
        .alert {
            padding: 14px;
            border-radius: 12px;
            margin-bottom: 20px;
            font-size: 14px;
            display: flex;
            align-items: center;
            gap: 8px;
            position: relative;
        }
        
        .alert-error {
            background: #fff5f5;
            color: #c53030;
            border: 1px solid #fed7d7;
        }
        
        .alert-success {
            background: #f0fff4;
            color: #22543d;
            border: 1px solid #c6f6d5;
        }
        
        .close-btn {
            margin-left: auto;
            cursor: pointer;
            opacity: 0.5;
            font-size: 18px;
            padding: 0 5px;
        }
        
        .close-btn:hover {
            opacity: 1;
        }
        
        .test-link {
            text-align: center;
            margin-top: 18px;
        }
        
        .test-link a {
            color: #a0aec0;
            text-decoration: none;
            font-size: 13px;
            transition: color 0.3s ease;
        }
        
        .test-link a:hover {
            color: #667eea;
        }
        
        /* Small mobile devices */
        @media (max-width: 480px) {
            body {
                padding: 12px;
            }
            
            .login-container {
                max-width: 100%;
                border-radius: 20px;
            }
            
            .login-header {
                padding: 30px 20px;
            }
            
            .login-header h1 {
                font-size: 24px;
            }
            
            .login-form {
                padding: 25px 20px;
            }
            
            .remember-forgot {
                flex-direction: column;
                align-items: flex-start;
            }
            
            .credential-item {
                flex-direction: column;
                align-items: flex-start;
                gap: 6px;
            }
            
            .credential-details {
                width: 100%;
                text-align: center;
            }
        }
        
        /* Landscape mode */
        @media (max-height: 600px) and (orientation: landscape) {
            body {
                align-items: flex-start;
                padding: 15px;
            }
            
            .login-container {
                max-width: 400px;
            }
            
            .login-header {
                padding: 20px;
            }
            
            .login-header h1 {
                font-size: 22px;
            }
            
            .login-form {
                padding: 20px;
            }
            
            .form-group {
                margin-bottom: 12px;
            }
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="login-header">
            <h1>🔐 Welcome Back!</h1>
            <p>Sign in to access your dashboard</p>
        </div>
        
        <div class="login-form">
            <!-- Display error message -->
            <c:if test="${not empty error}">
                <div class="alert alert-error">
                    <span>⚠️</span>
                    <span>${error}</span>
                    <span class="close-btn" onclick="this.parentElement.style.display='none'">✕</span>
                </div>
            </c:if>
            
            <!-- Display success message (like logout) -->
            <c:if test="${not empty message}">
                <div class="alert alert-success">
                    <span>✅</span>
                    <span>${message}</span>
                    <span class="close-btn" onclick="this.parentElement.style.display='none'">✕</span>
                </div>
            </c:if>
            
            <form action="${pageContext.request.contextPath}/login" method="post" id="loginForm">
                <div class="form-group">
                    <label for="username">Username</label>
                    <div class="input-wrapper">
                        <span class="input-icon">👤</span>
                        <input type="text" id="username" name="username" 
                               placeholder="Enter your username" required autofocus>
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="password">Password</label>
                    <div class="input-wrapper">
                        <span class="input-icon">🔒</span>
                        <input type="password" id="password" name="password" 
                               placeholder="Enter your password" required>
                        <span class="password-toggle" onclick="togglePassword()">👁️</span>
                    </div>
                </div>
                
                <div class="remember-forgot">
                    <div class="remember">
                        <input type="checkbox" id="remember" name="remember">
                        <label for="remember">Remember me</label>
                    </div>
                    <a href="#" class="forgot-link">Forgot Password?</a>
                </div>
                
                <button type="submit" class="btn-login">
                    <span>Sign In</span>
                </button>
            </form>
            
            <!-- Demo credentials for testing -->
            <div class="demo-credentials">
                <h3>📋 Demo Credentials</h3>
                <div class="credential-item">
                    <span class="credential-role">Admin</span>
                    <span class="credential-details">admin / admin123</span>
                </div>
                <div class="credential-item">
                    <span class="credential-role">User 1</span>
                    <span class="credential-details">john / john123</span>
                </div>
                <div class="credential-item">
                    <span class="credential-role">User 2</span>
                    <span class="credential-details">jane / jane123</span>
                </div>
            </div>
            
            <div class="test-link">
                <a href="${pageContext.request.contextPath}/test">⚡ Test Spring Configuration</a>
            </div>
        </div>
    </div>
    
    <script>
        // Toggle password visibility
        function togglePassword() {
            const passwordInput = document.getElementById('password');
            const toggleBtn = document.querySelector('.password-toggle');
            
            if (passwordInput.type === 'password') {
                passwordInput.type = 'text';
                toggleBtn.textContent = '🔓';
            } else {
                passwordInput.type = 'password';
                toggleBtn.textContent = '👁️';
            }
        }
        
        // Form validation
        document.getElementById('loginForm').addEventListener('submit', function(e) {
            const username = document.getElementById('username').value.trim();
            const password = document.getElementById('password').value.trim();
            
            if (!username || !password) {
                e.preventDefault();
                alert('Please fill in all fields');
            }
        });
        
        // Auto-hide alerts after 5 seconds
        setTimeout(function() {
            document.querySelectorAll('.alert').forEach(alert => {
                alert.style.display = 'none';
            });
        }, 5000);
        
        // Handle orientation change
        window.addEventListener('orientationchange', function() {
            setTimeout(function() {
                window.scrollTo(0, 0);
            }, 100);
        });
    </script>
</body>
</html>