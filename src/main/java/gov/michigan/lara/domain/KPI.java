package gov.michigan.lara.domain;

import java.io.Serializable;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;

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

@EqualsAndHashCode(callSuper = false)
public class KPI implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    private String bureau;
    private String KPI_Area;
    private String KPI_Name;
    private String KPI_ID;
    private String historicalData;
    private String dataType;
    private String dataStoreType;
    private Integer calcDenominator;
    private String target;
    private Boolean rollingAvg;
    private String access;
    private String requestedBy;
    private String sourceSystem;
    private String dataFeed;
    private String comments;
    private String devComments;

    @OneToMany(mappedBy = "kpi", cascade = CascadeType.ALL)
    @JsonIgnore
    private List<Record> record;
}