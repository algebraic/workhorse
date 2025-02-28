package gov.michigan.lara.util;

import javax.persistence.AttributeConverter;
import javax.persistence.Converter;

@Converter(autoApply = false) // Set autoApply to false for class-specific usage
public class BooleanConverter implements AttributeConverter<Boolean, Object> {

    @Override
    public Object convertToDatabaseColumn(Boolean attribute) {
        if (attribute == null) {
            return "";  // Store as empty string for null values (for String mapping)
        }
        // Return "Yes" for true and empty string for false when working with String mapping
        return attribute ? "Yes" : ""; 
    }

    @Override
    public Boolean convertToEntityAttribute(Object dbData) {
        if (dbData instanceof String) {
            // Convert "Yes" to true, and empty string to false
            return "Yes".equals(dbData);
        } else if (dbData instanceof Boolean) {
            // Handle the bit (1/0) as Boolean
            return Boolean.TRUE.equals(dbData);
        } else if (dbData instanceof Integer) {
            // Handle Integer values for the bit (0/1)
            return ((Integer) dbData) == 1;
        }
        return false;  // Default case
    }
}
