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
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import gov.michigan.lara.service.FileService;


@Controller
@ControllerAdvice
public class FileController {

    int size = 0;
    int count = 0;
    Double percent = 0.0;

    private static final Logger log = LoggerFactory.getLogger(FileController.class);
    public FileService fileService = new FileService();

    @ModelAttribute
    @GetMapping(value = "/")
    public ModelAndView test() {
        ModelAndView mav = new ModelAndView("index");
        this.size = 0;
        this.count = 0;
        mav.addObject("count", count);
        mav.addObject("size", size);
        return mav;
    }

    @ResponseBody
    @PostMapping(value = "check")
    public int uploadMultipart(@RequestParam("file") MultipartFile file) {
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

            System.out.println("Column headers: " + headers);
            System.out.println("Data rows: " + data.size());
            workbook.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return rowcount;
    }

    @ResponseBody
    @PostMapping(value = "load")
    public String load(@RequestParam("file") MultipartFile file, @RequestParam(name = "rowcount") Integer rowcount, HttpServletRequest request) throws IOException, InterruptedException, ExecutionException {
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
                System.out.println("file process completed");
                workbook.close();
            }

            // Print column headers and data
            System.out.println("Column headers: " + headers);
            // System.out.println("Data: " + data);
            System.out.println("Data size : " + data.size());
            
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
