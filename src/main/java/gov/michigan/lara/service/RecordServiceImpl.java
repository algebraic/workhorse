package gov.michigan.lara.service;

import gov.michigan.lara.dao.RecordRepository;
import gov.michigan.lara.domain.RecordCount;

import java.util.List;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

// Annotation
@Service
@SuppressWarnings("null")

// Class
public class RecordServiceImpl implements RecordService {

    private static Logger log = LogManager.getLogger();

    @Autowired
    private RecordRepository repository;

    @Override
    public List<RecordCount> fetchRecordList() {
        return (List<RecordCount>) repository.findAll();
    }
}