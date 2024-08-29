package gov.michigan.lara.domain;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.IdClass;
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
@IdClass(RecordId.class)
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
    private String kpiId;
    
    @Column(name = "PRCT_Val")
    private BigDecimal PRCT_VAL;

    @Column(name = "COUNT_Val")
    private Integer COUNT_VAL;

    @Id
    @Column(name = "Date")
    @Temporal(TemporalType.DATE)
    private Date entryDate;

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