<%@ page import="com.Major.Entity.UserEntity"%>
<%@ page import="com.Major.DAO.UserDAO"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Scheme Details</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #00b075;
            --secondary-color: #008a5e;
            --accent-color: #00d394;
            --light-color: #f8f9fa;
            --dark-color: #212529;
        }
        
        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #e4e8f0 100%);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            min-height: 100vh;
            padding-bottom: 50px;
        }
        
        .card-container {
            max-width: 900px;
            margin: 40px auto;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            border-radius: 15px;
            overflow: hidden;
            border: none;
        }
        
        .card-header {
            background: linear-gradient(to right, var(--primary-color), var(--secondary-color));
            color: white;
            padding: 25px;
            position: relative;
        }
        
        .card-header h1 {
            font-weight: 700;
            margin: 0;
            font-size: 2.2rem;
        }
        
        .card-body {
            padding: 0;
        }
        
        .detail-item {
            display: flex;
            padding: 20px 25px;
            border-bottom: 1px solid rgba(0, 0, 0, 0.05);
            transition: all 0.3s ease;
        }
        
        .detail-item:hover {
            background-color: rgba(0, 176, 117, 0.05);
        }
        
        .detail-label {
            width: 200px;
            font-weight: 600;
            color: var(--secondary-color);
            display: flex;
            align-items: center;
        }
        
        .detail-label i {
            margin-right: 10px;
            font-size: 1.1rem;
            color: var(--primary-color);
        }
        
        .detail-value {
            flex: 1;
            color: var(--dark-color);
            display: flex;
            align-items: center;
        }
        
        .url-link {
            color: var(--primary-color);
            text-decoration: none;
            font-weight: 500;
            transition: all 0.2s;
            display: inline-flex;
            align-items: center;
        }
        
        .url-link:hover {
            color: var(--secondary-color);
            text-decoration: underline;
        }
        
        .url-link i {
            margin-left: 8px;
            font-size: 0.9rem;
        }
        
        .back-btn {
            background: linear-gradient(to right, var(--primary-color), var(--secondary-color));
            border: none;
            padding: 10px 25px;
            border-radius: 50px;
            font-weight: 500;
            letter-spacing: 0.5px;
            transition: all 0.3s;
            box-shadow: 0 4px 15px rgba(0, 176, 117, 0.3);
            display: inline-flex;
            align-items: center;
            color: white;
        }
        
        .back-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(0, 176, 117, 0.4);
            color: white;
        }
        
        .back-btn i {
            margin-right: 8px;
        }
        
        .date-badge {
            background-color: rgba(0, 211, 148, 0.2);
            color: var(--secondary-color);
            padding: 5px 12px;
            border-radius: 50px;
            font-size: 0.85rem;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
        }
        
        .date-badge i {
            margin-right: 5px;
            font-size: 0.8rem;
        }
        
        @media (max-width: 768px) {
            .detail-item {
                flex-direction: column;
            }
            
            .detail-label {
                width: 100%;
                margin-bottom: 8px;
            }
            
            .card-header h1 {
                font-size: 1.8rem;
            }
        }
    </style>
</head>
<body>
    <%
        String schemeId = request.getParameter("schemeId");
        UserDAO dao = new UserDAO();
        UserEntity scheme = dao.detailScheme(schemeId);
    %>
    
    <div class="card-container">
        <div class="card-header">
            <h1><i class="fas fa-info-circle"></i> Scheme Details</h1>
        </div>
        <div class="card-body">
            <div class="detail-item">
                <div class="detail-label">
                    <i class="fas fa-heading"></i> Title
                </div>
                <div class="detail-value">
                    <%= scheme.getTitle() %>
                </div>
            </div>
            
            <div class="detail-item">
                <div class="detail-label">
                    <i class="fas fa-map-marker-alt"></i> State
                </div>
                <div class="detail-value">
                    <%= scheme.getState() %>
                </div>
            </div>
            
            <div class="detail-item">
                <div class="detail-label">
                    <i class="far fa-calendar-alt"></i> Duration
                </div>
                <div class="detail-value">
                    <span class="date-badge"><i class="fas fa-play"></i> <%= scheme.getStart_date() %></span>
                    <span class="mx-2">to</span>
                    <span class="date-badge"><i class="fas fa-stop"></i> <%= scheme.getEnd_date() %></span>
                </div>
            </div>
            
            <div class="detail-item">
                <div class="detail-label">
                    <i class="fas fa-user-tie"></i> Author
                </div>
                <div class="detail-value">
                    <%= scheme.getAuthor() %>
                </div>
            </div>
            
            <div class="detail-item">
                <div class="detail-label">
                    <i class="fas fa-align-left"></i> Description
                </div>
                <div class="detail-value">
                    <%= scheme.getDescription() %>
                </div>
            </div>
            
            <div class="detail-item">
                <div class="detail-label">
                    <i class="fas fa-link"></i> More Information
                </div>
                <div class="detail-value">
                    <a href="<%= scheme.getUrl() %>" class="url-link" target="_blank">
                        Visit Official Page <i class="fas fa-external-link-alt"></i>
                    </a>
                </div>
            </div>
        </div>
    </div>
    
    <div class="text-center mt-4">
        <button onclick="history.back()" class="back-btn">
            <i class="fas fa-arrow-left"></i> Back to Previous Page
        </button>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>