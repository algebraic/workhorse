package gov.michigan.lara.controller;


import gov.michigan.lara.domain.TableMetadata;
import gov.michigan.lara.service.MetadataService;

import java.sql.SQLException;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@PreAuthorize("hasRole('ROLE_ADMIN')")
public class MetadataController {

    private final MetadataService metadataService;

    public MetadataController(MetadataService metadataService) {
        this.metadataService = metadataService;
    }

    @GetMapping("/tableMetadata")
    public TableMetadata getTableMetadata(@RequestParam String tableName) {
        try {
            return metadataService.getTableMetadata(tableName);
        } catch (SQLException e) {
            e.printStackTrace();
            return null; // Handle this appropriately in a real application
        }
    }
}
