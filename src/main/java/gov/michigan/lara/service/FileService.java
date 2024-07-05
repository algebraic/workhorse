package gov.michigan.lara.service;

import java.util.List;
import java.util.concurrent.Future;

import jakarta.servlet.http.HttpServletRequest;

import org.apache.logging.log4j.*;
import org.springframework.scheduling.annotation.Async;
import org.springframework.scheduling.annotation.AsyncResult;
import org.springframework.stereotype.Service;

@SuppressWarnings("deprecation")
@Service
public class FileService {

    int size = 0;
    int count = 0;

    private static Logger log = LogManager.getLogger(FileService.class);

    @Async
    public Future<Integer> processRow(List<String> rowData, Integer n, HttpServletRequest request) {
        n++;
        try {
            log.info(">>> process row data: " + rowData.toString());
            // Thread.sleep(1); // sleep for 10 milliseconds
        } catch (Exception e) {
            log.error("@@@ error: " + e.getMessage());
        } finally {

        }
        return new AsyncResult<Integer>(n);
    }
}