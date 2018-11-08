package com.xoyar.cms.dto;
//DTO:Data Transfer Object（数据传输对象）
// DTO 是一组需要跨进程或网络边界传输的聚合数据的简单容器。
// 它不应该包含业务逻辑，并将其行为限制为诸如内部一致性检查和基本验证之类的活动。
import java.io.Serializable;
import java.util.Date;

public class UpdateUser implements Serializable {

    /** update_by. */
    private String updateBy;

    /** update_date. */
    private Date updateDate;

    public String getUpdateBy() {
        return updateBy;
    }

    public void setUpdateBy(String updateBy) {
        this.updateBy = updateBy;
    }

    public Date getUpdateDate() {
        return updateDate;
    }

    public void setUpdateDate(Date updateDate) {
        this.updateDate = updateDate;
    }

    @Override
    public String toString() {
        return "UpdateUser{" +
                "updateBy='" + updateBy + '\'' +
                ", updateDate=" + updateDate +
                '}';
    }
}
