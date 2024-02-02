package gov.michigan.lara.util;

import gov.michigan.lara.domain.KPI;
import gov.michigan.lara.util.Repository;

import java.util.List;
import java.util.Objects;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

// Annotation
@Service
@SuppressWarnings("null")

// Class
public class KpiServiceImpl implements KpiService {

    @Autowired
    private Repository repository;

    @Override
    public KPI saveKpi(KPI kpi) {
        // TODO Auto-generated method stub
        // throw new UnsupportedOperationException("Unimplemented method 'saveKpi'");
        return repository.save(kpi);
    }

    @Override
    public List<KPI> fetchKpiList() {
        // TODO Auto-generated method stub
        // throw new UnsupportedOperationException("Unimplemented method
        // 'fetchKpiList'");
        return (List<KPI>) repository.findAll();
    }

    @Override
    public KPI updateKpi(KPI kpi, Long id) {
        // TODO Auto-generated method stub
        // throw new UnsupportedOperationException("Unimplemented method 'updateKpi'");

        KPI kpiDB = repository.findById(id).get();
/*
        private String bureau;
        private String KPI_Area;
        private String KPI_Name;
        private String KPI_ID;
        private boolean fromExcel;
        private String dataType;
        private String dataStoreType;
        private int calcDenominator;
        private String target;
        private boolean rollingAvg;
        private String access;
        private String requestedBy;
        private String sourceSystem;
        private String dataFeed;
        private String comments;
        private String devComments;
*/

        if (Objects.nonNull(kpi.getKPI_Name()) && !"".equalsIgnoreCase(kpi.getKPI_Name())) {
            kpiDB.setKPI_Name(kpi.getKPI_Name());
        }

        return repository.save(kpiDB);

    }

    @Override
    public void deleteKpiById(Long id) {
        // TODO Auto-generated method stub
        // throw new UnsupportedOperationException("Unimplemented method 'deleteKpiById'");
        repository.deleteById(id);
    }

}