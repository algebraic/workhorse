package gov.michigan.lara.service;

import gov.michigan.lara.domain.RecordCount;

import java.util.List;

public interface RecordService {
    List<RecordCount> fetchRecordList();

    // KPI saveKpi(KPI kpi);
    // KPI updateKpi(KPI kpi, Long id);
    // void deleteKpiById(Long id);
    // KPI findKpiById(Long id);
}