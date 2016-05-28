/*****************************************************************************************
 * Copyright (c) 2012 nTels, All rights reserved.
 *
 * com.ntels.avocado.dao.pfnm.history.login.LoginHistoryExtendedMapper.java
 * Mapper 클래스
 *
 * 사용 방법:
 * <pre>
 *    사용 방법을 넣어 주세요.
 *    여러줄이라도 상관 없습니다.
 * </pre>
 *
 * @저자  : Kidae, Kim
 * @버전  :
 * @작성일 : 2012.08.30
 *
 * @작업 완료
 *    2012-12-10 : -------
 *
 * @작업중
 *    ---------
 ******************************************************************************************/
package com.ntels.avocado.dao.atom.history.login;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import com.ntels.avocado.domain.atom.history.login.Condition;
import com.ntels.avocado.domain.atom.history.login.LoginHistoryExtended;


//TODO: Auto-generated Javadoc
/**
* The Interface LoginHistoryExtendedMapper.
*/
@Component
public interface LoginHistoryExtendedMapper {

    /**
     * 사용자그룹 콤보 조회.
     *
     * @param user_group_level the user_group_level
     * @return the list
     */
    List<Map<String, Object>> listUserGroup(@Param("user_group_level") String user_group_level);

    /**
     * 사용자 콤보 조회.
     *
     * @param user_group_id the user_group_id
     * @param user_group_level the user_group_level
     * @return the list
     */
    List<Map<String, Object>> listUser(@Param("user_group_id") String user_group_id, @Param("user_group_level") String user_group_level);

    /**
     * List.
     *
     * @param condition the condition
     * @param start the start
     * @param end the end
     * @return the list
     */
    List<LoginHistoryExtended> listAction(@Param(value = "condition") Condition condition, @Param(value = "start") int start, @Param(value = "end") int end);

    /**
     * Count.
     *
     * @param condition the condition
     * @return the int
     */
    int count(@Param(value = "condition") Condition condition);

    /**
     * Insert.
     *
     * @param loginHistory the login history
     * @return the int
     */
    int insertLoginHistory(@Param("loginHistory") LoginHistoryExtended loginHistory);

    /**
     * Update.
     *
     * @param loginHistory the login history
     * @return the int
     */
    int updateLoginHistory(@Param("loginHistory") LoginHistoryExtended loginHistory);

    /**
     * Update.
     *
     * @param loginHistory the login history
     * @return the int
     */
    int destoryLoginHistory(@Param("loginHistory") LoginHistoryExtended loginHistory);


    /**
     * List excel.
     *
     * @param condition the condition
     * @return the list
     */
    List<Map<String, String>> listExcel(@Param(value = "condition") Condition condition);
}
