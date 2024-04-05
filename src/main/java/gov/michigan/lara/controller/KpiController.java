package gov.michigan.lara.controller;

import gov.michigan.lara.domain.KPI;
import gov.michigan.lara.service.KpiService;

import java.util.List;
import java.util.Map;

import javax.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController

public class KpiController{
    @Autowired
    private KpiService kpiService;

    // Save operation
    @PostMapping("/kpi")
    public KPI saveKpi(@Valid @RequestBody KPI kpi){
        return kpiService.saveKpi(kpi);
    }

    // Read operation
    @GetMapping("/kpi")
    public List<KPI> fetchKpiList(){
        return kpiService.fetchKpiList();
    }

    // Update operation
    @PutMapping("/kpi/{id}")
    public KPI updateKpi(@RequestBody KPI kpi,@PathVariable("id") Long id){
        return kpiService.updateKpi(kpi,id);
    }

    // Delete operation
    @DeleteMapping("/kpi/{id}")
    public String deleteKpiById(@PathVariable("id") Long id){
        kpiService.deleteKpiById(id);
        return "Deleted Successfully";
    }

    // Find by ID operation
    @GetMapping("/kpi/{id}")
    public KPI findKpiById(@PathVariable("id") Long id){
        return kpiService.findKpiById(id);
    }

    // get distinct bureau's from entered kpi's
    @GetMapping("/kpi/bureaus")
    public List<String> getBureauList(){
        return kpiService.getBureauList();
    }

    // get distinct kpi areas from given bureau
    @GetMapping("/kpi/bureaus/{bureau}")
    public List<String> getKpiAreasByBureau(@PathVariable("bureau") String bureau){
        return kpiService.getKpiAreasByBureau(bureau);
    }

    // get distinct kpi ids from given bureau/area
    @GetMapping("/kpi/bureaus/{bureau}/{area}")
    public List<Map<String,String>> getKpiIdsByArea(@PathVariable("bureau") String bureau,@PathVariable("area") String area){
        return kpiService.getKpiIdsByArea(bureau, area);
    }

}