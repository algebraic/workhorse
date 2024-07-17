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
    void deleteRecord(Record record);
    // KPI updateKpi(KPI kpi, String id);
    // void deleteKpiById(String id);
    // KPI findKpiById(String id);
}