package com.ejemplo;

import static spark.Spark.*;

import java.sql.*;
import java.util.*;
import com.google.gson.Gson;

public class App {

    public static void main(String[] args) {
        port(8080);

        get("/clientes", (req, res) -> {
            List<Map<String, Object>> clientes = new ArrayList<>();

            String dbUser = System.getenv("DB_USER");
            String dbPass = System.getenv("DB_PASSWORD");
            String dbHost = System.getenv("DB_HOST");

            String jdbcUrl = "jdbc:mysql:///clientes?cloudSqlInstance=" + dbHost +
                    "&socketFactory=com.google.cloud.sql.mysql.SocketFactory&useSSL=false";

            try (Connection conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPass);
                 PreparedStatement stmt = conn.prepareStatement("SELECT * FROM clientes");
                 ResultSet rs = stmt.executeQuery()) {

                while (rs.next()) {
                    Map<String, Object> cliente = new HashMap<>();
                    cliente.put("id", rs.getInt("id"));
                    cliente.put("nombre", rs.getString("nombre"));
                    cliente.put("correo", rs.getString("correo"));
                    clientes.add(cliente);
                }

            } catch (SQLException e) {
                res.status(500);
                return "Error al conectar a la base de datos: " + e.getMessage();
            }

            res.type("application/json");
            return new Gson().toJson(clientes);
        });
    }
}