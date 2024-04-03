package gov.michigan.lara.service;

import gov.michigan.lara.domain.KPI;
import java.util.List;

public interface KpiService {

    KPI saveKpi(KPI kpi);
    List<KPI> fetchKpiList();
    KPI updateKpi(KPI kpi, Long id);
    void deleteKpiById(Long id);
    KPI findKpiById(Long id);

    List<String> getBureauList();
    List<String> getKpiAreasByBureau(String bureau);
}