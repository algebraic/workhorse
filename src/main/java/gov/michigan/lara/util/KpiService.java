package gov.michigan.lara.util;

import gov.michigan.lara.domain.KPI;
import java.util.List;

public interface KpiService {

    // Save operation
    KPI saveKpi(KPI kpi);
 
    // Read operation
    List<KPI> fetchKpiList();
 
    // Update operation
    KPI updateKpi(KPI kpi, Long id);
 
    // Delete operation
    void deleteKpiById(Long id);

}