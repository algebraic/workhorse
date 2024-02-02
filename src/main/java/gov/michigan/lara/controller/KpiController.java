package gov.michigan.lara.controller;

import gov.michigan.lara.domain.KPI;
import gov.michigan.lara.util.KpiService;

import java.util.List;
import javax.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController

public class KpiController {
    @Autowired
    private KpiService kpiService;

    // Save operation
    @PostMapping("/kpi")
    public KPI saveKpi(@Valid @RequestBody KPI kpi) {
        System.out.println("testing 1");
        return kpiService.saveKpi(kpi);
    }

    // Read operation
    @GetMapping("/kpi")
    public List<KPI> fetchKpiList() {
        System.out.println("testing 2");
        return kpiService.fetchKpiList();
    }

    // Update operation
    @PutMapping("/kpi/{id}")
    public KPI updateKpi(@RequestBody KPI kpi, @PathVariable("id") Long id) {
        System.out.println("testing 3");
        return kpiService.updateKpi(kpi, id);
    }

    // Delete operation
    @DeleteMapping("/kpi/{id}")
    public String deleteKpiById(@PathVariable("id") Long id) {
        System.out.println("testing 4");
        kpiService.deleteKpiById(id);
        return "Deleted Successfully";
    }

}


// well i'll be a son of a bitch...the fetchKpiList method works at least, hell yeah!!!