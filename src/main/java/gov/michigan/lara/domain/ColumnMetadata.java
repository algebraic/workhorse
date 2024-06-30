package gov.michigan.lara.domain;

import lombok.Data;

@Data
public class ColumnMetadata {
    private String columnName;
    private String columnType;
    private int columnSize;
}
