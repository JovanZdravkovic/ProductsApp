package org.example.utils;

import javax.ws.rs.core.Response;

public class ErrorResponse extends BaseResponse {
    public ErrorResponse(int exitCode, String message) {
        super(exitCode, message);
    }

    public static Response create(String message) {
        return Response.ok(new BaseResponse(1, message)).build();
    }

    public static Response create(Exception ex) {
        if (ex != null) {
            return create(ex.getMessage());
        }
        return create("An unknown error occurred");
    }
}
