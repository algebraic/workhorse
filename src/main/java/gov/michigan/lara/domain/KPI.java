package gov.michigan.lara.domain;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.List;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;

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
@ToString(exclude = "record")
@Table(name = "Master_Data")

@EqualsAndHashCode(callSuper = false)
public class KPI implements Serializable {

    // @Id
    // @GeneratedValue(strategy = GenerationType.AUTO)
    // private Long id;

    @Column(name = "Bureau")
    private String bureau;
    
    private String KPI_Area;

    @Column(name = "KPI Name")
    private String KPI_Name;
    
    @Id
    private String KPI_ID;
    
    @Column(name = "Historical Data Processed From")
    private String historicalData;

    @Column(name = "Type")
    private String dataType;

    @Column(name = "Data Entered As")
    private String dataStoreType;

    @Column(name = "Denominator for % Calculation")
    private Integer calcDenominator;

    private String target;

    // @Column(name = "12 Month Rolling Avg#")
    @Column(name = "[12 Month Rolling Avg#]")
    private Boolean rollingAvg;

    private String access;
    
    @Column(name = "Requested by")
    private String requestedBy;

    @Column(name = "Source System")
    private String sourceSystem;

    @Column(name = "Data Feed")
    private String dataFeed;

    private String comments;

    @Column(name = "Created Date")
    private Timestamp createdDate;

    @Column(name = "Created By")
    private String createdBy;

    @Column(name = "Last Modified Date")
    private Timestamp lastModifiedDate;

    @Column(name = "Last Modified By")
    private String lastModifiedBy;


    @OneToMany(mappedBy = "kpi", cascade = CascadeType.ALL)
    @JsonIgnore
    private List<Record> record;
}