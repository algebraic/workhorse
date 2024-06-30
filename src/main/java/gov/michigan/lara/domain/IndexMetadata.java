package gov.michigan.lara.domain;

import lombok.Data;
import java.util.List;

@Data
public class IndexMetadata {
    private String indexName;
    private boolean isUnique;
    private String columnName;
}