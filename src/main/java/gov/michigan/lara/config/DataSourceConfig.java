package gov.michigan.lara.config;

import org.apache.logging.log4j.*;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.context.annotation.Profile;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.jndi.JndiObjectFactoryBean;
import gov.michigan.lara.WorkhorseApplication;

import javax.sql.DataSource;

@Configuration
public class DataSourceConfig {

    private static Logger log = LogManager.getLogger(WorkhorseApplication.class);

    @Bean
    @Primary
    @Profile("weblogic")
    public DataSource jndiDataSource() {
        // Using JNDI DataSource lookup for WebLogic environment
        log.info("Using JNDI DataSource lookup for WebLogic environment");
        JndiObjectFactoryBean jndiFactory = new JndiObjectFactoryBean();
        jndiFactory.setJndiName("jdbc/dashboards");
        jndiFactory.setResourceRef(true);
        jndiFactory.setProxyInterface(DataSource.class);

        // After initializing the JNDI lookup bean, return the DataSource it finds
        try {
            jndiFactory.afterPropertiesSet();
        } catch (Exception e) {
            System.out.println("### error ###");
            e.printStackTrace();
        }
        return (DataSource) jndiFactory.getObject();
    }

    // local datasource
    @Bean
    @Primary
    @Profile("local")
    public DataSource dataSource() {
        log.info("running locally, directly connect to db");
        DriverManagerDataSource dataSource = new DriverManagerDataSource();
        dataSource.setDriverClassName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        dataSource.setUrl("jdbc:sqlserver://HCV641SQLSDDA01.ngds.state.mi.us:7733;databaseName=D_LARA_ANALYTICS;encrypt=false;trustServerCertificate=true");
        dataSource.setUsername("LARA_ANALYTICS");
        dataSource.setPassword("LuzKHgorY2TUrf?bEgMaY");
        return dataSource;
    }

    @Bean
    public JdbcTemplate jdbcTemplate(DataSource dataSource) {
        return new JdbcTemplate(dataSource);
    }
}
