<%@ page import="com.Major.Entity.UserEntity"%>
<%@ page import="com.Major.DAO.UserDAO"%>
<%@ page import="java.util.List"%>
<%
    session = request.getSession(false);
    if (session == null || session.getAttribute("user") == null) {
        response.sendRedirect("login");
        return;
    }

    UserEntity user = (UserEntity) session.getAttribute("user");

    if (user.getStatus() != 2) {
        response.sendRedirect("404.jsp");
        return;
    }

    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Team Members</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #00b075;
            --secondary-color: #008a5e;
        }

        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #e4e8f0 100%);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            padding: 20px;
            min-height: 100vh;
        }

        .card-container {
            max-width: 1200px;
            margin: 30px auto;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
            border-radius: 12px;
            background: white;
            overflow: hidden;
        }

        .card-header {
            background: linear-gradient(to right, var(--primary-color), var(--secondary-color));
            color: white;
            padding: 20px 25px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .card-header h2 {
            margin: 0;
            font-size: 1.8rem;
            font-weight: 700;
        }

        .btn-custom {
            background: linear-gradient(to right, var(--primary-color), var(--secondary-color));
            border: none;
            padding: 8px 20px;
            border-radius: 50px;
            font-weight: 500;
            letter-spacing: 0.5px;
            transition: all 0.3s;
            box-shadow: 0 4px 15px rgba(0, 176, 117, 0.3);
            color: white !important;
        }

        .btn-custom:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(0, 176, 117, 0.4);
            background: linear-gradient(to right, var(--secondary-color), var(--primary-color));
        }

        .table-custom thead {
            background-color: rgba(0, 176, 117, 0.1);
            color: var(--secondary-color);
        }

        .table-custom thead th {
            border-bottom: 2px solid var(--primary-color);
            padding: 15px;
            font-weight: 600;
            text-align: center;
        }

        .table-custom tbody td {
            text-align: center;
            padding: 12px 15px;
            border-color: rgba(0, 0, 0, 0.05);
        }

        .table-custom tbody tr:hover {
            background-color: rgba(0, 176, 117, 0.05);
        }

        .empty-message {
            padding: 30px;
            text-align: center;
            color: #6c757d;
        }

        @media (max-width: 768px) {
            .card-header {
                flex-direction: column;
                gap: 15px;
                text-align: center;
            }

            .table-custom thead {
                display: none;
            }

            .table-custom tbody tr {
                display: block;
                margin-bottom: 20px;
                border: 1px solid #dee2e6;
                border-radius: 8px;
            }

            .table-custom tbody td {
                display: block;
                text-align: right;
                padding-left: 50%;
                position: relative;
                border: none;
                border-bottom: 1px solid #dee2e6;
            }

            .table-custom tbody td:before {
                content: attr(data-label);
                position: absolute;
                left: 15px;
                width: calc(50% - 15px);
                font-weight: 600;
                text-align: left;
                color: var(--secondary-color);
            }

            .table-custom tbody td:last-child {
                border-bottom: none;
            }
        }
    </style>
</head>
<body>
    <div class="card-container">
        <div class="card-header">
            <h2><i class="fas fa-users"></i> Team Members</h2>
            <button onclick="history.back()" class="btn btn-custom">
                <i class="fas fa-arrow-left"></i> Back
            </button>
        </div>
        <div class="table-responsive">
            <table class="table table-custom table-hover mb-0">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Phone</th>
                        <th>State</th>
                        <th>Status</th>
                        <th>Approve</th>
                        <th>Terminate</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        UserDAO dao = new UserDAO();
                        List<UserEntity> member = dao.teamMember();

                        if (member != null && !member.isEmpty()) {
                            for (UserEntity scheme : member) {
                    %>
                    <tr>
                        <td data-label="ID"><%= scheme.getId() %></td>
                        <td data-label="Name"><%= scheme.getName() %></td>
                        <td data-label="Email"><%= scheme.getEmail() %></td>
                        <td data-label="Phone"><%= scheme.getPhone() %></td>
                        <td data-label="State"><%= scheme.getState() %></td>
                        <td data-label="Status"><%= scheme.getStatus() %></td>
                        <td data-label="Approve">
                            <form action="Approve" method="post">
                                <input type="hidden" name="id" value="<%= scheme.getId() %>">
                                <button type="submit" class="btn btn-custom btn-sm">Approve</button>
                            </form>
                        </td>
                        <td data-label="Terminate">
                            <form action="Remove" method="post" onsubmit="return confirm('Are you sure you want to terminate this member?');">
                                <input type="hidden" name="id" value="<%= scheme.getId() %>">
                                <button type="submit" class="btn btn-danger btn-sm">
                                    <i class="fas fa-trash"></i> Terminate
                                </button>
                            </form>
                        </td>
                    </tr>
                    <%
                            }
                        } else {
                    %>
                    <tr>
                        <td colspan="8" class="empty-message">
                            <i class="fas fa-inbox"></i><br>
                            No team members found.
                        </td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
