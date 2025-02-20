package gov.michigan.lara.controller;

import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.sql.DataSource;

import org.apache.logging.log4j.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import gov.michigan.lara.security.CustomUserDetails;
import gov.michigan.lara.security.UserDetailsUtil;
import gov.michigan.lara.service.FileService;


@Controller
public class FileController {
	private static Logger log = LogManager.getLogger(FileController.class);

    int size = 0;
    int count = 0;
    Double percent = 0.0;

    public FileService fileService = new FileService();

    @Autowired
    private DataSource dataSource;

    @ModelAttribute
    @GetMapping(value = "/")
    public ModelAndView test(HttpServletRequest request) {
        log.info("index mapping");
        
        String username = UserDetailsUtil.getCurrentUsername();
        String userbureau = UserDetailsUtil.getCurrentUserBureau();
        String displayname = UserDetailsUtil.getCurrentUserDisplayName();

        CustomUserDetails userDetails = UserDetailsUtil.getCurrentUserDetails();

        ///////
       try (Connection connection = dataSource.getConnection()) {
            DatabaseMetaData metaData = connection.getMetaData();
            System.out.println("DB Product Name: " + metaData.getDatabaseProductName());
            System.out.println("DB Product Version: " + metaData.getDatabaseProductVersion());
            System.out.println("DB Driver Name: " + metaData.getDriverName());
            System.out.println("DB Driver Version: " + metaData.getDriverVersion());
            System.out.println("DB URL: " + metaData.getURL());
        } catch (SQLException e) {
            e.printStackTrace();
        }
        ///////

        
        ModelAndView mav = new ModelAndView("index");
        this.size = 0;
        this.count = 0;
        mav.addObject("count", count);
        mav.addObject("size", size);
        mav.addObject("username", username);
        mav.addObject("displayname", displayname);
        mav.addObject("userbureau", userbureau);
        mav.addObject("userDetails", userDetails);
        return mav;
    }

    @ResponseBody
    @GetMapping(value = "/isAdmin")
    public Boolean isAdmin(HttpServletRequest request) {
        return UserDetailsUtil.isAdmin();
    }

}
