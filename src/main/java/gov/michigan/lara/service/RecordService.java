package gov.michigan.lara.service;

import gov.michigan.lara.domain.Record;

import java.util.List;

public interface RecordService {
    List<Record> fetchRecordList();
    List<Record> getRecordsByKpiId(String kpiId);
    // KPI saveKpi(KPI kpi);
    // KPI updateKpi(KPI kpi, Long id);
    // void deleteKpiById(Long id);
    // KPI findKpiById(Long id);
}