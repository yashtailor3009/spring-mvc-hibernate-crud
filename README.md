# 🌱 Spring MVC Hibernate CRUD Application

A complete **CRUD (Create, Read, Update, Delete)** web application built with **Spring MVC**, **Hibernate**, and **JSTL**. This project demonstrates a fully functional user management system with login authentication and session management.

## 🚀 Features

### ✅ **Implemented Features**
- User Registration and Login with Session Management
- Complete CRUD Operations (Create, Read, Update, Delete)
- JSTL Tags for dynamic JSP pages
- Hibernate ORM with MySQL database
- Transaction Management
- Search Functionality
- Responsive UI with modern CSS
- Logout with Session Invalidation

### 📊 **Database Relationships**
- Single table `users` with complete CRUD
- (Extendable for foreign key relationships)

## 🛠️ **Technologies Used**

| Technology | Version |
|------------|---------|
| Java | 11 |
| Spring MVC | 5.3.30 |
| Hibernate Core | 5.6.15.Final |
| MySQL | 8.0 |
| JSP with JSTL | 1.2 |
| Maven | 3.8+ |
| Apache Tomcat | 9.0 |
| HTML/CSS | - |

## 📁 **Project Structure**
```
spring-mvc-hibernate-crud/
├── src/
│ ├── main/
│ │ ├── java/
│ │ │ └── com/
│ │ │ └── springmvc/
│ │ │ ├── controller/
│ │ │ │ ├── HomeController.java
│ │ │ │ ├── LoginController.java
│ │ │ │ ├── UserController.java
│ │ │ │ └── TestController.java
│ │ │ ├── service/
│ │ │ │ ├── UserService.java
│ │ │ │ └── UserServiceImpl.java
│ │ │ ├── dao/
│ │ │ │ ├── UserDAO.java
│ │ │ │ └── UserDAOImpl.java
│ │ │ ├── model/
│ │ │ │ └── UserEntity.java
│ │ │ └── util/
│ │ └── resources/
│ └── webapp/
│ ├── WEB-INF/
│ │ ├── views/
│ │ │ ├── login.jsp
│ │ │ ├── dashboard.jsp
│ │ │ ├── user-list.jsp
│ │ │ ├── user-form.jsp
│ │ │ └── user-view.jsp
│ │ ├── spring-servlet.xml
│ │ └── web.xml
│ └── index.html
├── pom.xml
└── README.md
```



## 🗄️ **Database Schema**

```sql
CREATE DATABASE spring_crud_db;

USE spring_crud_db;

CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    full_name VARCHAR(100),
    role VARCHAR(20) DEFAULT 'USER',
    status VARCHAR(20) DEFAULT 'ACTIVE',
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Sample Data
INSERT INTO users (username, password, email, full_name, role) VALUES
('admin', 'admin123', 'admin@example.com', 'Administrator', 'ADMIN'),
('john', 'john123', 'john@example.com', 'John Doe', 'USER'),
('jane', 'jane123', 'jane@example.com', 'Jane Smith', 'USER');
```

⚙️ Setup Instructions
Prerequisites
Java 11 or higher

MySQL 8.0

Apache Tomcat 9.0

Maven 3.6+

NetBeans/Eclipse/IntelliJ IDEA

Step 1: Clone the Repository
git clone https://github.com/yashtailor3009/spring-mvc-hibernate-crud.git

Step 2: Create Database
Run the SQL script above in MySQL Workbench

Step 3: Update Database Credentials
Edit spring-servlet.xml:
<property name="url" value="jdbc:mysql://localhost:3306/spring_crud_db?useSSL=false&amp;serverTimezone=UTC&amp;allowPublicKeyRetrieval=true"/>
<property name="username" value="root"/>
<property name="password" value="YOUR_PASSWORD"/>

Step 4: Build with Maven
mvn clean install

Step 5: Deploy to Tomcat
Copy WAR file from target/ to Tomcat's webapps/ folder

OR use NetBeans: Right-click → Deploy

Step 6: Access Application
http://localhost:8080/spring-mvc-hibernate-crud-1.0-SNAPSHOT/login

🔑 Default Users
Username	Password	Role
admin	admin123	ADMIN
john	john123	USER
jane	jane123	USER

## 📸 Screenshots
  
  Login Page
  <img width="960" height="445" alt="image" src="https://github.com/user-attachments/assets/4feadece-d3ac-4c43-8f13-07dd3066cc1c" />

  Dashboard
  <img width="949" height="410" alt="image" src="https://github.com/user-attachments/assets/498dd83e-cc57-44eb-be16-c07309440388" />
  <br>
  
  <img width="948" height="443" alt="image" src="https://github.com/user-attachments/assets/88ff21fa-8ed6-4d33-a58b-9fca2bfd8c42" />

  User List
  <img width="948" height="443" alt="image" src="https://github.com/user-attachments/assets/23962f5d-3893-4bea-b7c4-9016822bbc5d" />


## 🎯 Key Endpoints

| URL | Method | Description |
|-----|--------|-------------|
| `/login` | GET / POST | Login page |
| `/dashboard` | GET | User dashboard |
| `/users` | GET | List all users |
| `/users/add` | GET | Add user form |
| `/users/save` | POST | Save new user |
| `/users/edit/{id}` | GET | Edit user form |
| `/users/update` | POST | Update user |
| `/users/delete/{id}` | GET | Delete user |
| `/users/view/{id}` | GET | View user details |
| `/logout` | GET | Logout |

## 🧪 Testing
Run the test endpoints:   
http://localhost:8080/spring-mvc-hibernate-crud-1.0-SNAPSHOT/test
<br>

http://localhost:8080/spring-mvc-hibernate-crud-1.0-SNAPSHOT/test-db

## 🤝 Contributing
Fork the repository

Create your feature branch (git checkout -b feature/AmazingFeature)

Commit changes (git commit -m 'Add AmazingFeature')

Push to branch (git push origin feature/AmazingFeature)

Open a Pull Request

## 📄 License
This project is licensed under the MIT License - see the LICENSE file for details.

## 👨‍💻 Author
Yash Tailor

GitHub: @yashtailor3009

Linkedin: https://www.linkedin.com/in/yash-tailor-054373342/

## 🙏 Acknowledgments
Spring Framework Documentation

Hibernate ORM Documentation

MySQL Documentation

NetBeans IDE
