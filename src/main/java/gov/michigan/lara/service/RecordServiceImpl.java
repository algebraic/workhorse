package gov.michigan.lara.service;

import gov.michigan.lara.dao.RecordRepository;
import gov.michigan.lara.domain.KPI;
import gov.michigan.lara.domain.RecordCount;

import java.util.List;
import java.util.Objects;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

// Annotation
@Service
@SuppressWarnings("null")

// Class
public class RecordServiceImpl implements RecordService {

    private static Logger log = LogManager.getLogger();

    @Autowired
    private RecordRepository repository;

    // @Override
    // public KPI saveKpi(KPI kpi) {
    //     // TODO Auto-generated method stub
    //     // throw new UnsupportedOperationException("Unimplemented method 'saveKpi'");
    //     return repository.save(kpi);
    // }

    @Override
    public List<RecordCount> fetchRecordList() {
        // TODO Auto-generated method stub
        // throw new UnsupportedOperationException("Unimplemented method
        // 'fetchKpiList'");
        return (List<RecordCount>) repository.findAll();
    }

    // @Override
    // public KPI updateKpi(KPI kpi, Long id) {
    //     // TODO Auto-generated method stub
    //     // throw new UnsupportedOperationException("Unimplemented method 'updateKpi'");
    //     log.info("testing log");
    //     log.info(kpi);
    //     System.out.println("kpi " + Long.toString(id));
    //     System.out.println(kpi);

    //     KPI kpiDB = repository.findById(id).get();
    //     kpiDB.setBureau(kpi.getBureau());
    //     kpiDB.setKPI_Area(kpi.getKPI_Area());
    //     kpiDB.setKPI_Name(kpi.getKPI_Name());
    //     kpiDB.setKPI_ID(kpi.getKPI_ID());
    //     kpiDB.setHistoricalData(kpi.getHistoricalData());
    //     kpiDB.setDataType(kpi.getDataType());
    //     kpiDB.setDataStoreType(kpi.getDataStoreType());
    //     kpiDB.setCalcDenominator(kpi.getCalcDenominator());
    //     kpiDB.setTarget(kpi.getTarget());
    //     kpiDB.setRollingAvg(kpi.getRollingAvg());
    //     kpiDB.setAccess(kpi.getAccess());
    //     kpiDB.setRequestedBy(kpi.getRequestedBy());
    //     kpiDB.setSourceSystem(kpi.getSourceSystem());
    //     kpiDB.setDataFeed(kpi.getDataFeed());
    //     kpiDB.setComments(kpi.getComments());
    //     kpiDB.setDevComments(kpi.getDevComments());

    //     // if (Objects.nonNull(kpi.getKPI_Name()) && !"".equalsIgnoreCase(kpi.getKPI_Name())) {
    //     //     kpiDB.setKPI_Name(kpi.getKPI_Name());
    //     // }

    //     return repository.save(kpiDB);

    // }

    // @Override
    // public void deleteKpiById(Long id) {
    //     // TODO Auto-generated method stub
    //     // throw new UnsupportedOperationException("Unimplemented method 'deleteKpiById'");
    //     repository.deleteById(id);
    // }

    // @Override
    // public KPI findKpiById(Long id) {
    //     // TODO Auto-generated method stub
    //     // throw new UnsupportedOperationException("Unimplemented method 'deleteKpiById'");
    //     return repository.findById(id).get();
    // }

}