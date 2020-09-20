package com.github.eugene.controller;

public class BaseResponse {
    private final String status;
    private final int code;
    private final Object response;

    public BaseResponse(String status, Integer code, Object response) {
        this.status = status;
        this.code = code;
        this.response = response;
    }

    public String getStatus() {
        return status;
    }

    public int getCode() {
        return code;
    }

    public Object getResponse() {
        return response;
    }
}
