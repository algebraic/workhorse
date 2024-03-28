package gov.michigan.lara.domain;

import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDateTime;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder

@EqualsAndHashCode(callSuper = false)
public class RecordCount implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    // @ManyToOne
    // @JoinColumn(name = "KPI_ID") // this should match the column name in the Count table
    // private KPI kpi;
    
    private String KPI_ID;

    private String PRCT_VAL;
    private String COUNT_VAL;
    private String ENTRYDATE;
    
}