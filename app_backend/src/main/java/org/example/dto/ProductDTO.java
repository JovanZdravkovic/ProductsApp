package org.example.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotNull;
import java.sql.Date;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ProductDTO {
    @NotNull
    private String productName;
    private String productManufacturer;
    private boolean warranty;
    private String productManufacturingDate;
}
