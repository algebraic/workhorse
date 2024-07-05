package gov.michigan.lara.controller;

import java.io.IOException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.Future;

import javax.servlet.http.HttpServletRequest;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.DataFormatter;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.apache.logging.log4j.*;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import gov.michigan.lara.config.CustomUserDetails;
import gov.michigan.lara.service.FileService;


@Controller
@ControllerAdvice
public class FileController {
	private static Logger log = LogManager.getLogger(FileController.class);

    int size = 0;
    int count = 0;
    Double percent = 0.0;

    public FileService fileService = new FileService();

    @ModelAttribute
    @GetMapping(value = "/")
    public ModelAndView test(HttpServletRequest request) {
        log.info("index mapping");
        
        // // String user=request.getUserPrincipal().getName();
        // System.out.println("Logging before calling getUserPrincipal()");

        // // Retrieve the user principal
        // Principal principal = request.getUserPrincipal();
        // String username = null;
        // if (principal != null) {
        //     username = principal.getName();
        //     System.out.println("User principal name: " + username);
        //     System.out.println(principal.toString());
        // } else {
        //     System.out.println("User principal is null");
        // }

        // // Log after calling getUserPrincipal()
        // System.out.println("Logging after calling getUserPrincipal()");

        CustomUserDetails userDetails = (CustomUserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = userDetails.getUsername();
        String displayname = userDetails.getDisplayName();
        String userbureau = userDetails.getBureau();
        System.out.println("username = " + username);
        System.out.println("displayname = " + displayname);
        System.out.println("userbureau = " + userbureau);

        ModelAndView mav = new ModelAndView("index");
        this.size = 0;
        this.count = 0;
        mav.addObject("count", count);
        mav.addObject("size", size);
        mav.addObject("username", username);
        mav.addObject("displayname", displayname);
        mav.addObject("userbureau", userbureau);
        
        return mav;
    }

    @ResponseBody
    @PostMapping(value = "check")
    public int uploadMultipart(@RequestParam MultipartFile file) {
        int rowcount = 0;
        try {
            Workbook workbook = new XSSFWorkbook(file.getInputStream());
            Sheet sheet = workbook.getSheetAt(0);
            Iterator<Row> rowIterator = sheet.iterator();

            List<String> headers = new ArrayList<>();
            List<List<String>> data = new ArrayList<>();
            DataFormatter formatter = new DataFormatter();

            // Read column headers
            if (rowIterator.hasNext()) {
                Row headerRow = rowIterator.next();
                Iterator<Cell> cellIterator = headerRow.iterator();
                while (cellIterator.hasNext()) {
                    Cell cell = cellIterator.next();
                    headers.add(cell.getStringCellValue());
                }
            }

            // Read data rows
            while (rowIterator.hasNext()) {
                Row dataRow = rowIterator.next();
                Iterator<Cell> cellIterator = dataRow.iterator();
                List<String> rowData = new ArrayList<>();
                while (cellIterator.hasNext()) {
                    Cell cell = cellIterator.next();
                    rowData.add(formatter.formatCellValue(cell));
                }
                data.add(rowData);
                rowcount++;
            }

            log.info("Column headers: " + headers);
            log.info("Data rows: " + data.size());

            workbook.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return rowcount;
    }

    @ResponseBody
    @PostMapping(value = "load")
    public String load(@RequestParam MultipartFile file, @RequestParam Integer rowcount, HttpServletRequest request) throws IOException, InterruptedException, ExecutionException {
        this.size = rowcount;
        String filename = file.getOriginalFilename();

        try {
            Workbook workbook = new XSSFWorkbook(file.getInputStream());
            Sheet sheet = workbook.getSheetAt(0);
            Iterator<Row> rowIterator = sheet.iterator();

            List<String> headers = new ArrayList<>();
            List<List<String>> data = new ArrayList<>();
            DataFormatter formatter = new DataFormatter();

            // Read column headers
            if (rowIterator.hasNext()) {
                Row headerRow = rowIterator.next();
                Iterator<Cell> cellIterator = headerRow.iterator();
                while (cellIterator.hasNext()) {
                    Cell cell = cellIterator.next();
                    headers.add(cell.getStringCellValue());
                }
            }

            // Read data rows
            Future<Integer> future = null;
            while (rowIterator.hasNext()) {
                Row dataRow = rowIterator.next();
                Iterator<Cell> cellIterator = dataRow.iterator();
                List<String> rowData = new ArrayList<>();
                while (cellIterator.hasNext()) {
                    Cell cell = cellIterator.next();
                    rowData.add(formatter.formatCellValue(cell));
                }
                // do the actual thing
                future = fileService.processRow(rowData, this.count, request);
                this.count = future.get();

                Double percent = Double.valueOf(this.count) / Double.valueOf(this.size) * 100;
                this.percent = percent;
                // log.info("Total rows processed: " + this.count + "/" + this.size + " = " + this.percent + "%");

                data.add(rowData);
            }

            if (count == this.size) {
                log.info("file process completed");
                workbook.close();
            }

        } catch (IOException e) {
            e.printStackTrace();
        }
        return filename;
    }

    @ResponseBody
    @GetMapping(value = "getProgress")
    public String getProgress() {
        DecimalFormat dec = new DecimalFormat("#0");
        Double percent = Double.valueOf(this.count) / Double.valueOf(this.size) * 100;
        return dec.format(percent);
    }

}
