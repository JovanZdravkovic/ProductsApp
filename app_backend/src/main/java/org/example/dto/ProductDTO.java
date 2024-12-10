package org.example.dto;

import lombok.Builder;
import lombok.Data;

import javax.validation.constraints.NotNull;
import java.sql.Date;

@Data
@Builder
public class ProductDTO {
    @NotNull
    private String productName;
    private String productManufacturer;
    private boolean warranty;
    private String productManufacturingDate;
}
