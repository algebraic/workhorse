package gov.michigan.lara.controller;

import gov.michigan.lara.domain.Record;
import gov.michigan.lara.service.RecordService;

import java.lang.reflect.Field;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController

public class RecordController{

    private static Logger log=LogManager.getLogger();

    @Autowired
    private RecordService recordService;

    // // Save operation
    // @PostMapping("/kpi")
    // public KPI saveKpi(@Valid @RequestBody KPI kpi){
    // return kpiService.saveKpi(kpi);
    // }

    // Read operation
    @GetMapping("/records")
    public List<Record> getAllRecords(){
        return recordService.getAllRecords();
    }

    @GetMapping("/records/{kpiId}")
    public List<Record> getRecordsByKpiId(@PathVariable String kpiId){
        return recordService.getRecordsByKpiId(kpiId);
    }

    @GetMapping("/records/{kpiId}/{year}")
    public List<Record> getRecordsByKpiYear(@PathVariable String kpiId, @PathVariable int year){
        return recordService.getRecordsByKpiYear(kpiId, year);
    }

    @GetMapping("/records/{kpiId}/years")
    public List<Integer> getKpiYears(@PathVariable String kpiId){
        System.out.println("### getKpiYears?");
        return recordService.getKpiYears(kpiId);
    }

    // // Update operation
    // @PutMapping("/kpi/{id}")
    // public KPI updateKpi(@RequestBody KPI kpi,@PathVariable("id") String id){
    // return kpiService.updateKpi(kpi,id);
    // }

    // // Delete operation
    // @DeleteMapping("/kpi/{id}")
    // public String deleteKpiById(@PathVariable("id") String id){
    // kpiService.deleteKpiById(id);
    // return "Deleted Successfully";
    // }

    // // Find by ID operation
    // @GetMapping("/kpi/{id}")
    // public KPI findKpiById(@PathVariable("id") String id){
    // return kpiService.findKpiById(id);
    // }

}