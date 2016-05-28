package com.ntels.avocado.dao.common;

import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import com.ntels.avocado.domain.atom.security.operationhist.OperationHistDomain;

/**
 * 
 * <PRE>
 * 1. ClassName: CommonMapper
 * 2. FileName : CommonMapper.java
 * 3. Package  : com.ntels.avocado.dao.common
 * 4. Comment  : 공통 맵퍼
 * 5. 작성자   : hancheonsu
 * 6. 작성일   : 2016. 3. 4. 오후 6:48:10
 * 7. 변경이력
 *		이름	:	일자	: 변경내용
 *     ——————————————————————————————————————————————————————
 *		hancheonsu :	2016. 3. 4.	: 신규개발.
 * </PRE>
 */
@Component
public interface CommonMapper {
	
	/**
	 * 
	 * <PRE>
	 * 1. MethodName: findLocalePattern
	 * 2. ClassName : CommonMapper
	 * 3. Comment   : 언어별 날짜 패턴 가져오기
	 * 4. 작성자    : hancheonsu
	 * 5. 작성일    : 2016. 3. 4. 오후 6:48:16
	 * </PRE>
	 *   @return String
	 *   @param locale
	 *   @return
	 */
	Map<String, Object> findLocalePattern(@Param(value="locale")String locale);
	
	/**
	 *  
	 * <PRE>
	 * 1. MethodName: findMenuName
	 * 2. ClassName : CommonMapper
	 * 3. Comment   : url로 메뉴명 조회
	 * 4. 작성자    : hancheonsu
	 * 5. 작성일    : 2016. 3. 14. 오후 8:38:15
	 * </PRE>
	 *   @return String
	 *   @param url
	 *   @return
	 */
	Map<String, Object> findMenuName(@Param(value="url")String url, @Param(value="userId")String userId);
	
	/**
	 * 
	 * <PRE>
	 * 1. MethodName: addRecent
	 * 2. ClassName : CommonMapper
	 * 3. Comment   : 
	 * 4. 작성자    : hancheonsu
	 * 5. 작성일    : 2016. 3. 15. 오후 5:10:59
	 * </PRE>
	 *   @return int
	 *   @param map
	 *   @return
	 */
	int addRecent(Map<String, Object> map);
	
	/**
	 * 
	 * <PRE>
	 * 1. MethodName: removeRecent
	 * 2. ClassName : CommonMapper
	 * 3. Comment   :
	 * 4. 작성자    : hancheonsu
	 * 5. 작성일    : 2016. 3. 20. 오후 1:28:27
	 * </PRE>
	 *   @return int
	 *   @param map
	 *   @return
	 */
	int removeRecent(Map<String, Object> map);
	
	/**
	 * 
	 * <PRE>
	 * 1. MethodName: findRecent
	 * 2. ClassName : CommonMapper
	 * 3. Comment   :
	 * 4. 작성자    : hancheonsu
	 * 5. 작성일    : 2016. 3. 20. 오후 1:28:35
	 * </PRE>
	 *   @return List<Map<String,Object>>
	 *   @param userId
	 *   @return
	 */
	List<Map<String, Object>> findRecent(@Param(value="userId")String userId);
	
	/**
	 * 트리 패키지 조회
	 * <PRE>
	 * 1. MethodName: findTree
	 * 2. ClassName : CommonMapper
	 * 3. Comment   :
	 * 4. 작성자    : hancheonsu
	 * 5. 작성일    : 2016. 4. 6. 오후 3:38:58
	 * </PRE>
	 *   @return List<Map<String,Object>>
	 *   @return
	 */
	List<Map<String, Object>> listTreePackage();
	
	/**
	 * 트리 노드 조회
	 * <PRE>
	 * 1. MethodName: findNode
	 * 2. ClassName : CommonMapper
	 * 3. Comment   :
	 * 4. 작성자    : hancheonsu
	 * 5. 작성일    : 2016. 4. 18. 오후 6:30:35
	 * </PRE>
	 *   @return List<Map<String,Object>>
	 *   @param packageName
	 *   @return
	 */
	List<Map<String, Object>> listTreeNode(String packageName);
	
	/**
	 * 운영 이력 입력
	 * <PRE>
	 * 1. MethodName: insertOperationHist
	 * 2. ClassName : CommonMapper
	 * 3. Comment   :
	 * 4. 작성자    : hancheonsu
	 * 5. 작성일    : 2016. 4. 18. 오후 6:30:42
	 * </PRE>
	 *   @return int
	 *   @param operationHist
	 *   @return
	 */
	int insertOperationHist(OperationHistDomain operationHist);
	
	int updateOperationHist(OperationHistDomain operationHist);
}
