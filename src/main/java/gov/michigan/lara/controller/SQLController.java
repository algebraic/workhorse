package gov.michigan.lara.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.sql.DataSource;
import java.sql.*;
import java.util.*;


@RestController
@RequestMapping("/sql")
public class SQLController {

    @Autowired
    private DataSource dataSource;

    @GetMapping("/execute")
    public Map<String, Object> executeSQLQuery(@RequestParam String query) {
        System.out.println("### query = " + query);
        Map<String, Object> response = new HashMap<>();
        try (Connection connection = dataSource.getConnection();
             Statement statement = connection.createStatement()) {
            ResultSet resultSet = statement.executeQuery(query);
            ResultSetMetaData metaData = resultSet.getMetaData();
            int columnCount = metaData.getColumnCount();

            List<Map<String, String>> rows = new ArrayList<>();
            while (resultSet.next()) {
                Map<String, String> row = new HashMap<>();
                for (int i = 1; i <= columnCount; i++) {
                    row.put(metaData.getColumnName(i), resultSet.getString(i));
                }
                rows.add(row);
            }
            response.put("status", "success");
            response.put("data", rows);
        } catch (SQLException e) {
            e.printStackTrace();
            response.put("status", "error");
            response.put("message", "Error executing SQL query: " + e.getMessage());
        }
        return response;
    }
}
