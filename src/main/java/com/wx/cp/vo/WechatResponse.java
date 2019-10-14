package com.wx.cp.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class WechatResponse {

    private Integer errcode;

    private String errmsg;

    private String invaliduser;

    private String userId;

    private String deviceId;
}
