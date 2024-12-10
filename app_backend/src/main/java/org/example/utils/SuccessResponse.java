package org.example.utils;

import javax.ws.rs.core.Response;

public class SuccessResponse extends BaseResponse {
    public static Response create(Object entity) {
        return Response.ok(entity).build();
    }

    public static Response create(String message) {
        return Response.ok(new BaseResponse(0, message)).build();
    }
}
