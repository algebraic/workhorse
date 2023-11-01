package gov.michigan.lara;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;

@SpringBootApplication
public class WorkhorseApplication extends SpringBootServletInitializer {

	public static void main(String[] args) {
		SpringApplication.run(WorkhorseApplication.class, args);
	}

}
