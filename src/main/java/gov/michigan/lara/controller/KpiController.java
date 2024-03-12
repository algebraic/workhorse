package gov.michigan.lara.controller;

import gov.michigan.lara.domain.KPI;
import gov.michigan.lara.util.KpiService;

import java.util.List;
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

}

// well i'll be a son of a bitch...the fetchKpiList method works at least, hell
// yeah!!!