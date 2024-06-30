package gov.michigan.lara.domain;

import lombok.Data;

@Data
public class ForeignKeyMetadata {
    private String fkName;
    private String pkTableName;
    private String pkColumnName;
}
