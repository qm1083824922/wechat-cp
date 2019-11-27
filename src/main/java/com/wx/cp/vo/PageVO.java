package com.wx.cp.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PageVO {

    private int pageNo = 0;
    private int pageSize = 25;
    private String openid;
    private Integer poType;
    private boolean wechatFlag;
    private Integer auditorState;
}
