package org.example.utils;

import com.codahale.metrics.MetricRegistryListener;
import com.fasterxml.jackson.annotation.JsonProperty;

public class BaseResponse {
    @JsonProperty("code")
    private int exitCode;

    private String message;

    public BaseResponse() {

    }

    public BaseResponse(int exitCode, String message) {
        this.exitCode = exitCode;
        this.message = message;
    }

    public int getExitCode() {
        return exitCode;
    }

    public void setExitCode(int exitCode) {
        this.exitCode = exitCode;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
}
