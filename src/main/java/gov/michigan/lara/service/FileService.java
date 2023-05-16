package gov.michigan.lara.service;

import java.util.List;
import java.util.concurrent.Future;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.scheduling.annotation.Async;
import org.springframework.scheduling.annotation.AsyncResult;
import org.springframework.stereotype.Service;

@Service
public class FileService {

    int size = 0;
    int count = 0;

    private static final Logger log = LoggerFactory.getLogger(FileService.class);

    @Async
    public Future<Integer> processRow(List<String> rowData, Integer n, HttpServletRequest request) {
        n++;
        try {
            // System.out.println(">>> process row data: " + rowData.toString());
            // Thread.sleep(1); // sleep for 10 milliseconds
        } catch (Exception e) {
            log.error("@@@ error: " + e.getMessage());
        } finally {
            
        }
        return new AsyncResult<Integer>(n);
    }
}