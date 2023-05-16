package gov.michigan.lara.domain;

import java.io.Serializable;
import java.util.List;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class DataObject implements Serializable {

	private static final long serialVersionUID = 1L;
    private List<String> headers;
    private List<List<String>> data;
    private int rowcount;

}