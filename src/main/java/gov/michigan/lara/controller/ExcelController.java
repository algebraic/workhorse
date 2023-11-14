package gov.michigan.lara.controller;

import org.apache.logging.log4j.*;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;


@Controller
@ControllerAdvice
public class ExcelController {
	private static Logger log = LogManager.getLogger(ExcelController.class);

    @ModelAttribute
    @GetMapping(value = "/export")
    public void exportToExcel() {
        log.info("export mapping");
    }

}
