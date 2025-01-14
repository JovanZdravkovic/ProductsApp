package org.example.resources;

import org.example.dto.ProductDTO;
import org.example.services.ProductService;
import org.example.utils.ErrorResponse;
import org.example.utils.SuccessResponse;

import javax.validation.Valid;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

@Path("/products")
@Produces(MediaType.APPLICATION_JSON)
public class ProductResource {

    private ProductService productService;

    public ProductResource(ProductService productService) {
        this.productService = productService;
    }

    @GET
    public Response getAllProducts() {
        try {
            return SuccessResponse.create(productService.getAllProducts());
        } catch (Exception exception) {
            return ErrorResponse.create(exception);
        }
    }

    @POST
    @Path("/create")
    public Response create(@Valid ProductDTO productDTO) {
        try {
            return SuccessResponse.create(productService.createProduct(productDTO));
        } catch (Exception exception) {
            return ErrorResponse.create(exception);
        }
    }

}
