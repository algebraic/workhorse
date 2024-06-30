package gov.michigan.lara.domain;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString(exclude="kpi")
@Table(name = "Data")
@EqualsAndHashCode(callSuper=false)
public class Record implements Serializable {

    @Id
    @Column(name = "KPI_ID")
    private String KPI_ID;
    
    @Column(name = "PRCT_Val")
    private BigDecimal PRCT_VAL;

    @Column(name = "COUNT_Val")
    private Integer COUNT_VAL;

    @Column(name = "Date")
    @Temporal(TemporalType.DATE)
    private Date ENTRYDATE;

    @Column(name = "Created Date")
    private Date createdDate;

    @Column(name = "Created By")
    private String createdBy;

    @Column(name = "Last Modified Date")
    private Date lastModifiedDate;

    @Column(name = "Last Modified By")
    private String lastModifiedBy;

    @ManyToOne
    @JoinColumn(name = "KPI_ID", referencedColumnName = "KPI_ID", insertable = false, updatable = false)
    @JsonIgnore
    private KPI kpi;
}


/*
@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString(exclude="kpi")
@Table(name = "Data")

@EqualsAndHashCode(callSuper=false)
public class Record implements Serializable{

    // @Id
    // @GeneratedValue(strategy=GenerationType.AUTO)
    // private Long id;

    @Id
    private String KPI_ID;
    
    private BigDecimal PRCT_VAL;
    private Integer COUNT_VAL;
    private String ENTRYDATE;

    @ManyToOne
    @JoinColumn(name="kpi_id",referencedColumnName="KPI_ID",insertable=false,updatable=false)
    @JsonIgnore
    private KPI kpi;

}
*/