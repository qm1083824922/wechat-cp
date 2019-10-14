package com.wx.cp.config;

import com.wx.cp.utils.JsonUtils;
import lombok.Getter;
import lombok.Setter;
import org.springframework.boot.context.properties.ConfigurationProperties;

import java.util.List;

/**
 * @author qm
 */
@Getter
@Setter
@ConfigurationProperties(prefix = "wechat.cp")
public class WxCpProperties {
  /**
   * 设置微信企业号的corpId
   */
  private String corpId;

  private List<AppConfig> appConfigs;

  private String userInfoUrl;

  private String projectUrl;

  @Getter
  @Setter
  public static class AppConfig {
    /**
     * 设置微信企业应用的AgentId
     */
    private Integer agentId;

    /**
     * 设置微信企业应用的Secret
     */
    private String secret;

    /**
     * 设置微信企业号的token
     */
    private String token;

    /**
     * 设置微信企业号的EncodingAESKey
     */
    private String aesKey;

  }

  @Override
  public String toString() {
    return JsonUtils.toJson(this);
  }
}
