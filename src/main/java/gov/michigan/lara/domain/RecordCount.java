package gov.michigan.lara.domain;

import java.io.Serializable;
import java.math.BigDecimal;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

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
@ToString(exclude = "kpi")


@EqualsAndHashCode(callSuper = false)
public class RecordCount implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;
    private String KPI_ID;
    private BigDecimal PRCT_VAL;
    private Integer COUNT_VAL;
    private String ENTRYDATE;

    @ManyToOne
    @JoinColumn(name="kpi_id",referencedColumnName="KPI_ID",insertable=false,updatable=false)
    @JsonIgnore
    private KPI kpi;
}