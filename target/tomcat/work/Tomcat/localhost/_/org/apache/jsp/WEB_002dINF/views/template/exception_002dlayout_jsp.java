/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.47
 * Generated at: 2016-05-12 07:47:53 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.WEB_002dINF.views.template;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class exception_002dlayout_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fspring_005fmessage_0026_005fcode_005fnobody;

  private javax.el.ExpressionFactory _el_expressionfactory;
  private org.apache.tomcat.InstanceManager _jsp_instancemanager;

  public java.util.Map<java.lang.String,java.lang.Long> getDependants() {
    return _jspx_dependants;
  }

  public void _jspInit() {
    _005fjspx_005ftagPool_005fspring_005fmessage_0026_005fcode_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
    _jsp_instancemanager = org.apache.jasper.runtime.InstanceManagerFactory.getInstanceManager(getServletConfig());
  }

  public void _jspDestroy() {
    _005fjspx_005ftagPool_005fspring_005fmessage_0026_005fcode_005fnobody.release();
  }

  public void _jspService(final javax.servlet.http.HttpServletRequest request, final javax.servlet.http.HttpServletResponse response)
        throws java.io.IOException, javax.servlet.ServletException {

    final javax.servlet.jsp.PageContext pageContext;
    javax.servlet.http.HttpSession session = null;
    final javax.servlet.ServletContext application;
    final javax.servlet.ServletConfig config;
    javax.servlet.jsp.JspWriter out = null;
    final java.lang.Object page = this;
    javax.servlet.jsp.JspWriter _jspx_out = null;
    javax.servlet.jsp.PageContext _jspx_page_context = null;


    try {
      response.setContentType("text/html;charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("<!DOCTYPE html>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<html lang=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${sessionUser.language}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      out.write("\">\r\n");
      out.write("<head>\r\n");
      out.write("\t<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\" />\r\n");
      out.write("\t<title>");
      if (_jspx_meth_spring_005fmessage_005f0(_jspx_page_context))
        return;
      out.write("</title>\r\n");
      out.write("</head>\r\n");
      out.write("<link rel=\"stylesheet\" href=\"/styles/style.css\">\r\n");
      out.write("<script src=\"/scripts/jquery.1.11.2.min.js\"></script>\r\n");
      out.write("<script src=\"/scripts/jquery-ui.min.js\"></script>\r\n");
      out.write("<script src=\"/scripts/ui.js\"></script>\r\n");
      out.write("<script src=\"/scripts/datepicker.min.js\"></script>\r\n");
      out.write("<script src=\"/scripts/clockpicker.min.js\"></script>\r\n");
      out.write("<script src=\"/scripts/multiple-select.js\"></script>\r\n");
      out.write("<script src=\"/scripts/jquery.simplemodal.js\"></script> \r\n");
      out.write("<script type=\"text/javascript\" src=\"/scripts/jwebsocket/1_0_b1/jWebSocket.js\"></script>\r\n");
      out.write("<script src=\"/scripts/jwebsocket/pfnmWebSocket.js\"></script>\r\n");
      out.write("<script src=\"/scripts/amcharts_3.19.4/amcharts/amcharts.js\"></script>\r\n");
      out.write("<script src=\"/scripts/amcharts_3.19.4/amcharts/serial.js\"></script>\r\n");
      out.write("<script src=\"/scripts/amcharts_3.19.4/amcharts/plugins/export/export.js\"></script>\r\n");
      out.write("<script type=\"text/javascript\">\r\n");
      out.write("<!--\r\n");
      out.write("\twindow.history.forward();\r\n");
      out.write("\r\n");
      out.write("\t$(document).ready(function() {\r\n");
      out.write("\t\t$(this).contextmenu(function(e) { \r\n");
      out.write("\t\t\treturn false; \r\n");
      out.write("\t\t});\r\n");
      out.write("\t\t\r\n");
      out.write("\t\tfnKeepAlive();\r\n");
      out.write("\t});\r\n");
      out.write("\t\r\n");
      out.write("\tvar refreshId = null;\r\n");
      out.write("\t\r\n");
      out.write("\tfunction fnKeepAlive(){\r\n");
      out.write("\t\t//console.log(\"fnKeepAlive()...\");\r\n");
      out.write("\t \trefreshId = setInterval(function() {\r\n");
      out.write("\t \t\tvar result = \r\n");
      out.write("\t\t \t\t$.ajax({\r\n");
      out.write("\t\t \t\t\turl : \"/common/keepAlive\",\r\n");
      out.write("\t\t \t\t\ttype : \"POST\",\r\n");
      out.write("\t\t \t\t\tasync : false,\r\n");
      out.write("\t\t \t\t\tcache : false\r\n");
      out.write("\t\t \t\t});\r\n");
      out.write("\t \t\t\r\n");
      out.write("\t \t\tresult.done(function(data) {\r\n");
      out.write("\t \t\t\tconsole.log(data);\r\n");
      out.write("\t \t\t\tif (data == 1) { //서버 세션 잃어버림\r\n");
      out.write("\t \t\t\t\tfnKeepAliveEnd();\r\n");
      out.write("\t \t\t\t} else if (data == 2) { //유저 강제 종료 \r\n");
      out.write("\t \t\t\t\tfnKeepAliveEnd();\r\n");
      out.write("\t \t\t\t}\r\n");
      out.write("\t \t\t});\r\n");
      out.write("\t \t\t\t \t\t\r\n");
      out.write("\t\t \tresult.fail(function(xhr, status) {\r\n");
      out.write("\t\t\t\tfnKeepAliveEnd();\r\n");
      out.write("\t \t\t});\r\n");
      out.write("\t\t\t\r\n");
      out.write("\t \t\tif (result !== null) result = null;\r\n");
      out.write("\t\t\t\r\n");
      out.write("\t \t\tclearInterval(refreshId);\r\n");
      out.write("\t \t\tfnKeepAlive();\t\t\r\n");
      out.write("\t \t\t\r\n");
      out.write("\t\t}, 30 * 1000);\r\n");
      out.write("\t}\r\n");
      out.write("\t\r\n");
      out.write("\tfunction fnCloseConfirm() {\r\n");
      out.write("\t\ttry {\t\t\t\r\n");
      out.write("\t\t\tvar prevUrl = document.referrer;\r\n");
      out.write("\t\t\tif (prevUrl == \"\") prevUrl = \"/\";\r\n");
      out.write("\t\t\tvar frm = document.frmReturn;\r\n");
      out.write("\t\t\tfrm.action = prevUrl;\r\n");
      out.write("\t\t\tfrm.method = \"post\";\r\n");
      out.write("\t\t\tfrm.target = \"\";\r\n");
      out.write("\t\t\tfrm.submit(); \r\n");
      out.write("\t\t} catch(e) {\r\n");
      out.write("\t\t\t\r\n");
      out.write("\t\t}\t  \r\n");
      out.write("\t}\r\n");
      out.write("//-->\r\n");
      out.write("</script>\t\r\n");
      out.write("\r\n");
      out.write("<body>\r\n");
      out.write("<form name=\"frmReturn\"></form>\r\n");
      if (_jspx_meth_tiles_005finsertAttribute_005f0(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("</body>\r\n");
      out.write("</html>");
    } catch (java.lang.Throwable t) {
      if (!(t instanceof javax.servlet.jsp.SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          try { out.clearBuffer(); } catch (java.io.IOException e) {}
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }

  private boolean _jspx_meth_spring_005fmessage_005f0(javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.PageContext pageContext = _jspx_page_context;
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  spring:message
    org.springframework.web.servlet.tags.MessageTag _jspx_th_spring_005fmessage_005f0 = (org.springframework.web.servlet.tags.MessageTag) _005fjspx_005ftagPool_005fspring_005fmessage_0026_005fcode_005fnobody.get(org.springframework.web.servlet.tags.MessageTag.class);
    _jspx_th_spring_005fmessage_005f0.setPageContext(_jspx_page_context);
    _jspx_th_spring_005fmessage_005f0.setParent(null);
    // /WEB-INF/views/template/exception-layout.jsp(10,8) name = code type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_spring_005fmessage_005f0.setCode("label.common.err.title");
    int[] _jspx_push_body_count_spring_005fmessage_005f0 = new int[] { 0 };
    try {
      int _jspx_eval_spring_005fmessage_005f0 = _jspx_th_spring_005fmessage_005f0.doStartTag();
      if (_jspx_th_spring_005fmessage_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
    } catch (java.lang.Throwable _jspx_exception) {
      while (_jspx_push_body_count_spring_005fmessage_005f0[0]-- > 0)
        out = _jspx_page_context.popBody();
      _jspx_th_spring_005fmessage_005f0.doCatch(_jspx_exception);
    } finally {
      _jspx_th_spring_005fmessage_005f0.doFinally();
      _005fjspx_005ftagPool_005fspring_005fmessage_0026_005fcode_005fnobody.reuse(_jspx_th_spring_005fmessage_005f0);
    }
    return false;
  }

  private boolean _jspx_meth_tiles_005finsertAttribute_005f0(javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.PageContext pageContext = _jspx_page_context;
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  tiles:insertAttribute
    org.apache.tiles.jsp.taglib.InsertAttributeTag _jspx_th_tiles_005finsertAttribute_005f0 = (new org.apache.tiles.jsp.taglib.InsertAttributeTag());
    _jsp_instancemanager.newInstance(_jspx_th_tiles_005finsertAttribute_005f0);
    _jspx_th_tiles_005finsertAttribute_005f0.setJspContext(_jspx_page_context);
    // /WEB-INF/views/template/exception-layout.jsp(89,0) name = name type = java.lang.String reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_tiles_005finsertAttribute_005f0.setName("body");
    _jspx_th_tiles_005finsertAttribute_005f0.doTag();
    _jsp_instancemanager.destroyInstance(_jspx_th_tiles_005finsertAttribute_005f0);
    return false;
  }
}