package gov.michigan.lara.util;

import java.io.IOException;
import java.io.InputStream;
import java.util.List;

import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectReader;
import com.fasterxml.jackson.dataformat.csv.CsvMapper;
import com.fasterxml.jackson.dataformat.csv.CsvSchema;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class CsvUtils {
    private static final Logger log = LoggerFactory.getLogger(CsvUtils.class);

    public static <T> List<T> read(Class<T> clazz, InputStream stream) {
        CsvMapper mapper = new CsvMapper();
        mapper.enable(DeserializationFeature.ACCEPT_EMPTY_STRING_AS_NULL_OBJECT);
        mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, true);
        
        CsvSchema schema = mapper.schemaFor(clazz).withHeader().withColumnReordering(true);
        ObjectReader reader = mapper.readerFor(clazz).with(schema);
        log.info("reading file for " + clazz.getName());
        try {
            return reader.<T>readValues(stream).readAll();
        } catch (IOException e) {
            e.printStackTrace();
            log.error(e.getMessage());
        }
        return null;
    }
}