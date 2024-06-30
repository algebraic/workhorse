package gov.michigan.lara.service;

import gov.michigan.lara.domain.Record;

import java.util.List;

public interface RecordService {
    List<Record> getAllRecords();
    List<Record> getRecordsByKpiId(String kpiId);
    List<Record> getRecordsByKpiYear(String kpiId, int year);
    List<Integer> getKpiYears(String kpiId);
    // KPI saveKpi(KPI kpi);
    // KPI updateKpi(KPI kpi, String id);
    // void deleteKpiById(String id);
    // KPI findKpiById(String id);
}