package gov.michigan.lara.domain;

import lombok.Data;
import java.util.List;

@Data
public class TableMetadata{
    private String tableName;
    private List<ColumnMetadata> columns;
    private List<String> primaryKeys;
    private List<ForeignKeyMetadata> foreignKeys;
    private List<IndexMetadata> indexes;
    private List<String> tablePrivileges;
    private List<String> columnPrivileges;
}