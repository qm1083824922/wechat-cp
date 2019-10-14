package com.wx.cp.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class SendMessageVO {
    private Integer userId;
    private Integer status;
    private Integer poType;
}
