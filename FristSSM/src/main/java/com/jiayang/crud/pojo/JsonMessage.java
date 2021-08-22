package com.jiayang.crud.pojo;

import java.util.HashMap;
import java.util.Map;

public class JsonMessage {
    private int code;
    private String massage;
    private Map<String , Object> info;

    public JsonMessage() {
        info = new HashMap<>();
    }

    public static JsonMessage success(){
        JsonMessage jsonMessage = new JsonMessage();
        jsonMessage.setCode(100);
        jsonMessage.setMassage("success");
        return jsonMessage;
    }

    public static JsonMessage fail(){
        JsonMessage jsonMessage = new JsonMessage();
        jsonMessage.setCode(200);
        jsonMessage.setMassage("fail");
        return jsonMessage;
    }

    public JsonMessage add(String key,Object value){
        this.getInfo().put(key,value);
        return this;
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMassage() {
        return massage;
    }

    public void setMassage(String massage) {
        this.massage = massage;
    }

    public Map<String, Object> getInfo() {
        return info;
    }

    public void setInfo(Map<String, Object> info) {
        this.info = info;
    }
}
