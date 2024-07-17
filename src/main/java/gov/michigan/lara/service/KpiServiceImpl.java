package gov.michigan.lara.service;

import gov.michigan.lara.config.UserDetailsUtil;
import gov.michigan.lara.dao.KpiRepository;
import gov.michigan.lara.domain.KPI;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class KpiServiceImpl implements KpiService{

    private static Logger log=LogManager.getLogger();

    @Autowired
    private KpiRepository repository;

    @Override
    public KPI saveKpi(KPI kpi){
        return repository.save(kpi);
    }

    @Override
    public List<KPI> fetchKpiList(){
        return (List<KPI>)repository.findAll();
    }

    @Override
    public KPI updateKpi(KPI kpi,String id){
        log.info("testing log");
        log.info(kpi);
        System.out.println("kpi: "+id);
        System.out.println(kpi);

        KPI kpiDB=repository.findById(id).get();
        kpiDB.setBureau(kpi.getBureau());
        kpiDB.setKPI_Area(kpi.getKPI_Area());
        kpiDB.setKPI_Name(kpi.getKPI_Name());
        kpiDB.setKPI_ID(kpi.getKPI_ID());
        kpiDB.setHistoricalData(kpi.getHistoricalData());
        kpiDB.setDataType(kpi.getDataType());
        kpiDB.setDataStoreType(kpi.getDataStoreType());
        kpiDB.setCalcDenominator(kpi.getCalcDenominator());
        kpiDB.setTarget(kpi.getTarget());
        kpiDB.setRollingAvg(kpi.getRollingAvg());
        kpiDB.setAccess(kpi.getAccess());
        kpiDB.setRequestedBy(kpi.getRequestedBy());
        kpiDB.setSourceSystem(kpi.getSourceSystem());
        kpiDB.setDataFeed(kpi.getDataFeed());
        kpiDB.setComments(kpi.getComments());

        // if (Objects.nonNull(kpi.getKPI_Name()) &&
        // !"".equalsIgnoreCase(kpi.getKPI_Name())) {
        // kpiDB.setKPI_Name(kpi.getKPI_Name());
        // }

        return repository.save(kpiDB);

    }

    @Override
    public void deleteKpiById(String id){
        repository.deleteById(id);
    }

    @Override
    public KPI findKpiById(String id){
        return repository.findById(id).get();
    }

    @Override
    public String getKpiDataType(String kpiId){
        return repository.getKpiDataType(kpiId);
    }

    @Override
    public List<String> getBureauList(){
        return repository.getBureauList(UserDetailsUtil.getCurrentUserBureau());
    }

    @Override
    public List<String> getKpiAreasByBureau(String bureau){
        return repository.getKpiAreaByBureau(bureau);
    }

    @Override
    public List<Map<String,String>> getKpiIdsByArea(String bureau,String area){

        List<Object[]> results=repository.getKpiIdsByArea(bureau,area);
        List<Map<String,String>> keyValuePairs=new ArrayList<>();

        for(Object[] result:results){
            Map<String,String> pair=new HashMap<>();
            pair.put("KPI_ID",result[0].toString());
            pair.put("KPI_Name",result[1].toString());
            keyValuePairs.add(pair);
        }

        return keyValuePairs;
    }

}