package gov.michigan.lara.service;

import gov.michigan.lara.dao.RecordRepository;
import gov.michigan.lara.domain.Record;

import java.util.List;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

// Annotation
@Service


// Class
public class RecordServiceImpl implements RecordService {

    private static Logger log = LogManager.getLogger();

    @Autowired
    private RecordRepository repository;

    @Override
    public List<Record> getAllRecords() {
        return (List<Record>) repository.findAll();
    }

    @Override
    public List<Record> getRecordsByKpiId(String kpiId){
        return repository.getRecordsByKpiId(kpiId);
    }

    @Override
    public List<Record> getRecordsByKpiYear(String kpiId, int year) {
        return repository.getRecordsByKpiYear(kpiId, year);
    }

    @Override
    public List<Integer> getKpiYears(String kpiId) {
        return repository.getKpiYears(kpiId);
    }
}