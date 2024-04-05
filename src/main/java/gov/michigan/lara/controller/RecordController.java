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
    public List<Record> fetchRecordCounts(){
        List<Record> testlist = recordService.fetchRecordList();

        for (Record record : testlist) {
            Class<?> recordClass = record.getClass();
            Field[] fields = recordClass.getDeclaredFields();
            for (Field field : fields) {
                field.setAccessible(true); // Allows accessing private fields
                try {
                    Object value = field.get(record);
                    // log.info(field.getName() + ": " + value);
                } catch (IllegalAccessException e) {
                    log.error("Error accessing field: " + field.getName(), e);
                }
            }
        }
        return testlist;
    }

    @GetMapping("/records/{kpiId}")
    public List<Record> getKpiIdsByArea(@PathVariable("kpiId") String kpiId){
        List<Record> testlist = recordService.getRecordsByKpiId(kpiId);

        for (Record record : testlist) {
            Class<?> recordClass = record.getClass();
            Field[] fields = recordClass.getDeclaredFields();
            for (Field field : fields) {
                field.setAccessible(true); // Allows accessing private fields
                try {
                    Object value = field.get(record);
                    // log.info(field.getName() + ": " + value);
                } catch (IllegalAccessException e) {
                    log.error("Error accessing field: " + field.getName(), e);
                }
            }
        }
        return testlist;
    }

    // // Update operation
    // @PutMapping("/kpi/{id}")
    // public KPI updateKpi(@RequestBody KPI kpi,@PathVariable("id") Long id){
    // return kpiService.updateKpi(kpi,id);
    // }

    // // Delete operation
    // @DeleteMapping("/kpi/{id}")
    // public String deleteKpiById(@PathVariable("id") Long id){
    // kpiService.deleteKpiById(id);
    // return "Deleted Successfully";
    // }

    // // Find by ID operation
    // @GetMapping("/kpi/{id}")
    // public KPI findKpiById(@PathVariable("id") Long id){
    // return kpiService.findKpiById(id);
    // }

}