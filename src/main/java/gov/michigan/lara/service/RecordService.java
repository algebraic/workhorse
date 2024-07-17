package gov.michigan.lara.service;

import gov.michigan.lara.domain.Record;

import java.text.ParseException;
import java.util.List;

public interface RecordService {
    List<Record> getAllRecords();
    List<Record> getRecordsByKpiId(String kpiId);
    List<Record> getRecordsByKpiYear(String kpiId, int year);
    List<Integer> getKpiYears(String kpiId);
    Record saveRecord(Record record);
    Record getRecordByKpiDate(String id, String date) throws ParseException;
    Boolean deleteRecord(Record record);
}