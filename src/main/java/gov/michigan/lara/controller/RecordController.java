package gov.michigan.lara.controller;

import gov.michigan.lara.config.UserDetailsUtil;
import gov.michigan.lara.domain.KPI;
import gov.michigan.lara.domain.Record;
import gov.michigan.lara.service.KpiService;
import gov.michigan.lara.service.KpiServiceImpl;
import gov.michigan.lara.service.RecordService;

import java.math.BigDecimal;
import java.text.ParseException;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.stream.Collectors;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController

public class RecordController{

    private static Logger log=LogManager.getLogger();

    @Autowired
    private RecordService recordService;

    @Autowired
    private KpiService kpiService;

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

    @PostMapping("/saveOrUpdateRecords")
    public String saveOrUpdateRecords(@RequestBody List<Map<String, String>> records) throws ParseException{
        for (Map<String, String> record : records) {
            String value = record.get("value");
            String ogvalue = record.get("ogvalue");
            String date = record.get("date");
            String kpiId = record.get("kpi");

            KPI kpi = kpiService.findKpiById(kpiId);
            Record saveObject = new Record();
            if (ogvalue == null) {
                //brand new record, just save
                saveObject.setKpiId(kpiId);
                saveObject.setKpi(kpi);
                saveObject.setCreatedDate(new Date());
                saveObject.setCreatedBy(UserDetailsUtil.getCurrentUsername());
                
                // Convert dateStr to LocalDate
                LocalDate localDate = LocalDate.parse(date);
                Date recorddate = Date.from(localDate.atStartOfDay(ZoneId.systemDefault()).toInstant());
                saveObject.setEntryDate(recorddate);

                // figure out % or #
                System.out.println(kpi.getDataType());
                if (kpi.getDataType().equals("PRCT")) {
                    System.out.println("NEW RECORD: trying string to bigdecimal...");
                    saveObject.setPRCT_VAL(new BigDecimal(value));
                } else if (kpi.getDataType().equals("COUNT")) {
                    System.out.println("trying string to integer...");
                    saveObject.setCOUNT_VAL(Integer.parseInt(value));
                } else {
                    System.out.println("unknown datatype: " + kpi.getDataType());
                }
                System.out.println("attempting save...");
                recordService.saveRecord(saveObject);
            } else {
                // update existing record
                System.out.println("kpiId=" + kpiId);
                System.out.println("date=" + date);
                Record ogrecord = recordService.getRecordByKpiDate(kpiId, date);

                if (value == "") {
                    System.out.println("### trying to delete: " + ogrecord.toString());
                    recordService.deleteRecord(ogrecord);
                    return "deleted record";
                }

                System.out.println(ogrecord.toString());
                if (kpi.getDataType().equals("PRCT")) {
                    System.out.println("EXISTING: trying string to bigdecimal...");
                    ogrecord.setPRCT_VAL(new BigDecimal(value));
                } else if (kpi.getDataType().equals("COUNT")) {
                    System.out.println("trying string to integer...");
                    ogrecord.setCOUNT_VAL(Integer.parseInt(value));
                } else {
                    System.out.println("unknown datatype: " + kpi.getDataType());
                }
                ogrecord.setLastModifiedBy(UserDetailsUtil.getCurrentUsername());
                ogrecord.setLastModifiedDate(new Date());
                recordService.saveRecord(ogrecord);
            }
            

        }
        System.err.println(records);
        return "yay";
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