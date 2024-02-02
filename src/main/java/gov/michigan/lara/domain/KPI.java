package gov.michigan.lara.domain;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

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
public class KPI implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    private String bureau;
    private String KPI_Area;
    private String KPI_Name;
    private String KPI_ID;
    private boolean fromExcel;
    private String dataType;
    private String dataStoreType;
    private int calcDenominator;
    private String target;
    private boolean rollingAvg;
    private String access;
    private String requestedBy;
    private String sourceSystem;
    private String dataFeed;
    private String comments;
    private String devComments;
}