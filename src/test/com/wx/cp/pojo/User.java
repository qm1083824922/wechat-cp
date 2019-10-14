package com.wx.cp.pojo;

import lombok.Data;

@Data
public class User {
    private String userId;
    private String name;
    private Integer[] departIds;
    private String position;
    private String mobile;
    private String gender;
    private String email;
    private String avatar;
    private Integer status;
    private Integer enable;
    private Integer isLeader;
    private String[] extAttrs;
    private String hideMobile;
    private String telephone;
    private String qrCode;
    private String[] externalAttrs;


}
