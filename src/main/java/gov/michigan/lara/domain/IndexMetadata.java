package gov.michigan.lara.domain;

import lombok.Data;

@Data
public class IndexMetadata {
    private String indexName;
    private boolean isUnique;
    private String columnName;
}