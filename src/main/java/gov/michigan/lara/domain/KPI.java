package gov.michigan.lara.domain;

import java.io.Serializable;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class KPI implements Serializable {

    private static final long serialVersionUID = 1L;
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