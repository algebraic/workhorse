package gov.michigan.lara.controller;

import gov.michigan.lara.config.UserDetailsUtil;
import gov.michigan.lara.domain.KPI;
import gov.michigan.lara.domain.Record;
import gov.michigan.lara.service.KpiService;
import gov.michigan.lara.service.RecordService;

import java.math.BigDecimal;
import java.text.ParseException;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.Date;
import java.util.List;
import java.util.Map;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController

public class RecordController{

    private static Logger log=LogManager.getLogger();

    @Autowired
    private RecordService recordService;

    @Autowired
    private KpiService kpiService;

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
            if (ogvalue == null || ogvalue.equals("~new~")) {
                //brand new record, just save
                saveObject.setKpiId(kpiId);
                saveObject.setKpi(kpi);
                saveObject.setCreatedDate(new Date());
                saveObject.setCreatedBy(UserDetailsUtil.getCurrentUsername());
                
                // convert dateStr to LocalDate
                LocalDate localDate = LocalDate.parse(date);
                Date recorddate = Date.from(localDate.atStartOfDay(ZoneId.systemDefault()).toInstant());
                saveObject.setEntryDate(recorddate);

                // figure out % or #
                System.out.println(kpi.getDataType());
                if (kpi.getDataType().equals("PRCT")) {
                    saveObject.setPRCT_VAL(new BigDecimal(value));
                } else if (kpi.getDataType().equals("COUNT")) {
                    saveObject.setCOUNT_VAL(Integer.parseInt(value));
                } else {
                    System.out.println("unknown datatype: " + kpi.getDataType());
                    log.error("unknown datatype: " + kpi.getDataType());
                }
                log.info("saving record: " + recordService.saveRecord(saveObject));

            } else {
                // update existing record
                Record ogrecord = recordService.getRecordByKpiDate(kpiId, date);

                if (value == "") {
                    log.info("deleting record: " + recordService.deleteRecord(ogrecord));
                } else {
                    if (kpi.getDataType().equals("PRCT")) {
                        ogrecord.setPRCT_VAL(new BigDecimal(value));
                    } else if (kpi.getDataType().equals("COUNT")) {
                        ogrecord.setCOUNT_VAL(Integer.parseInt(value));
                    } else {
                        System.out.println("unknown datatype: " + kpi.getDataType());
                        log.error("unknown datatype: " + kpi.getDataType());
                    }
                    ogrecord.setLastModifiedBy(UserDetailsUtil.getCurrentUsername());
                    ogrecord.setLastModifiedDate(new Date());
                    log.info("saving record: " + recordService.saveRecord(ogrecord));
                }
            }
        }
        System.err.println(records);
        return "1";
    }

}