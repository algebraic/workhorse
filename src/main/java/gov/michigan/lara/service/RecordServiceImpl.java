package gov.michigan.lara.service;

import gov.michigan.lara.dao.RecordRepository;
import gov.michigan.lara.domain.Record;
import gov.michigan.lara.domain.RecordId;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
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

    @Override
    public Record saveRecord(Record record) {
        log.info("saving record: " + record);
        return repository.save(record);
    }

    @Override
    public Record getRecordByKpiDate(String id, String datestring) throws ParseException{
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        Date date = new java.sql.Date(formatter.parse(datestring).getTime());
        System.out.println("getRecordByKpiDate id=" + id);
        System.out.println("getRecordByKpiDate date=" + date);
        System.out.println("getRecordByKpiDate datestring=" + datestring);
        Record existingRecord = repository.getRecordByKpiDate(id, date);
        if (existingRecord != null) {
            System.out.println("existingRecord:" + existingRecord.toString());
        }
        return existingRecord;
    }

    @Override
    public Boolean deleteRecord(Record record){
        RecordId recordId = new RecordId(record.getKpiId(), record.getEntryDate());
        try {
            log.info("deleting record: " + record.toString());
            repository.deleteById(recordId);
            return true;
          }
          catch(Exception e) {
            e.printStackTrace();
            return false;
          }
            
    }
}