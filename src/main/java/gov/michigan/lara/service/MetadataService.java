package gov.michigan.lara.service;


import gov.michigan.lara.domain.TableMetadata;
import gov.michigan.lara.domain.ColumnMetadata;
import gov.michigan.lara.domain.ForeignKeyMetadata;
import gov.michigan.lara.domain.IndexMetadata;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

@Service
public class MetadataService {

    private final JdbcTemplate jdbcTemplate;

    @Autowired
    public MetadataService(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    public TableMetadata getTableMetadata(String tableName) throws SQLException {
        TableMetadata tableMetadata = new TableMetadata();
        tableMetadata.setTableName(tableName);

        List<ColumnMetadata> columnMetadataList = new ArrayList<>();
        List<String> primaryKeyList = new ArrayList<>();
        List<ForeignKeyMetadata> foreignKeyMetadataList = new ArrayList<>();
        List<IndexMetadata> indexMetadataList = new ArrayList<>();
        List<String> tablePrivilegeList = new ArrayList<>();
        List<String> columnPrivilegeList = new ArrayList<>();

        DataSource dataSource=jdbcTemplate.getDataSource();
        Connection connection=null;
        DatabaseMetaData metaData=null;
        if (dataSource != null) {
            connection=dataSource.getConnection();
            if(connection!=null){
                metaData=connection.getMetaData();
            }else{
                // Handle the case when connection is null
                throw new IllegalStateException("database connection is null");
            }
        }else{
            // Handle the case when dataSource is null
            throw new IllegalStateException("dataSource is null");
        }

        // Columns information
        ResultSet columns = metaData.getColumns(null, null, tableName, null);
        while (columns.next()) {
            ColumnMetadata columnMetadata = new ColumnMetadata();
            columnMetadata.setColumnName(columns.getString("COLUMN_NAME"));
            columnMetadata.setColumnType(columns.getString("TYPE_NAME"));
            columnMetadata.setColumnSize(columns.getInt("COLUMN_SIZE"));
            columnMetadataList.add(columnMetadata);
        }
        tableMetadata.setColumns(columnMetadataList);

        // Primary key information
        ResultSet primaryKeys = metaData.getPrimaryKeys(null, null, tableName);
        while (primaryKeys.next()) {
            primaryKeyList.add(primaryKeys.getString("COLUMN_NAME"));
        }
        tableMetadata.setPrimaryKeys(primaryKeyList);

        // Foreign key information
        ResultSet foreignKeys = metaData.getImportedKeys(null, null, tableName);
        while (foreignKeys.next()) {
            ForeignKeyMetadata foreignKeyMetadata = new ForeignKeyMetadata();
            foreignKeyMetadata.setFkName(foreignKeys.getString("FKCOLUMN_NAME"));
            foreignKeyMetadata.setPkTableName(foreignKeys.getString("PKTABLE_NAME"));
            foreignKeyMetadata.setPkColumnName(foreignKeys.getString("PKCOLUMN_NAME"));
            foreignKeyMetadataList.add(foreignKeyMetadata);
        }
        tableMetadata.setForeignKeys(foreignKeyMetadataList);

        // Index information
        ResultSet indexes = metaData.getIndexInfo(null, null, tableName, false, false);
        while (indexes.next()) {
            IndexMetadata indexMetadata = new IndexMetadata();
            indexMetadata.setIndexName(indexes.getString("INDEX_NAME"));
            indexMetadata.setUnique(!indexes.getBoolean("NON_UNIQUE"));
            indexMetadata.setColumnName(indexes.getString("COLUMN_NAME"));
            indexMetadataList.add(indexMetadata);
        }
        tableMetadata.setIndexes(indexMetadataList);

        // Table privileges
        ResultSet tablePrivileges = metaData.getTablePrivileges(null, null, tableName);
        while (tablePrivileges.next()) {
            tablePrivilegeList.add(tablePrivileges.getString("PRIVILEGE"));
        }
        tableMetadata.setTablePrivileges(tablePrivilegeList);

        // Column privileges
        ResultSet columnPrivileges = metaData.getColumnPrivileges(null, null, tableName, null);
        while (columnPrivileges.next()) {
            columnPrivilegeList.add(columnPrivileges.getString("COLUMN_NAME") + " - " + columnPrivileges.getString("PRIVILEGE"));
        }
        tableMetadata.setColumnPrivileges(columnPrivilegeList);

        return tableMetadata;
    }
}
