/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.47
 * Generated at: 2016-05-24 01:00:08 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.WEB_002dINF.views.atom.monitor;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class processDiagram_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  private javax.el.ExpressionFactory _el_expressionfactory;
  private org.apache.tomcat.InstanceManager _jsp_instancemanager;

  public java.util.Map<java.lang.String,java.lang.Long> getDependants() {
    return _jspx_dependants;
  }

  public void _jspInit() {
    _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
    _jsp_instancemanager = org.apache.jasper.runtime.InstanceManagerFactory.getInstanceManager(getServletConfig());
  }

  public void _jspDestroy() {
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

      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<link rel=\"stylesheet\" href=\"/styles/style.css\">\r\n");
      out.write("<script src=\"/scripts/jquery.1.11.2.min.js\"></script>\r\n");
      out.write("<script src=\"/scripts/stringUtil.js\"></script>\r\n");
      out.write("<script src=\"/scripts/modal.js\"></script>\r\n");
      out.write("<script src=\"/scripts/jquery.alphanumeric.js\"></script>\r\n");
      out.write("<script src=\"/scripts/jquery-ui.min.js\"></script>\r\n");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "../config/networkmanager/flowdesign.jsp", out, false);
      out.write("\r\n");
      out.write("<script>\r\n");
      out.write("$(document).ready(function () {\r\n");
      out.write("\t$(this).contextmenu(function() {\r\n");
      out.write("\t\treturn false;\r\n");
      out.write("\t});\r\n");
      out.write("\tinitFlowDesign(\"#flowdesignDiv\");\r\n");
      out.write("\tvar param = new Object();\r\n");
      out.write("\tparam.pkg_name = \"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${svc.pkg_name}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      out.write("\";\r\n");
      out.write("\tparam.node_type = \"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${svc.node_type}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      out.write("\";\r\n");
      out.write("\tparam.svc_no = \"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${svc.svc_no}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      out.write("\";\r\n");
      out.write("\tsearchFlowDesign(true, param);\r\n");
      out.write("\tg_data = {\"readonly\": true};\r\n");
      out.write("});\r\n");
      out.write("\r\n");
      out.write("function loadProc(procList) {\r\n");
      out.write("\tif (procList == null) {\r\n");
      out.write("\t\treturn;\r\n");
      out.write("\t}\r\n");
      out.write("\tfor (var i=0;i<procList.length;i++) {\r\n");
      out.write("\t\tvar proc = procList[i];\r\n");
      out.write("\t\tif (!isEmpty(proc.image_x) && !isEmpty(proc.image_y) && proc.svc_no == g_data.svc.svc_no) {\r\n");
      out.write("\t\t\tvar atomProc = new AtomProc ({\r\n");
      out.write("\t\t\t\tpath: proc.image_name,\r\n");
      out.write("\t\t\t\tlabel: proc.proc_name,\r\n");
      out.write("\t\t\t\twidth: 62,\r\n");
      out.write("\t\t\t\theight: 62,\r\n");
      out.write("\t\t\t\tuserData: proc,\r\n");
      out.write("\t\t\t\tx: proc.image_x,\r\n");
      out.write("\t\t\t\ty: proc.image_y,\r\n");
      out.write("\t\t\t\tbgColor: proc.image_bgcolor\r\n");
      out.write("\t\t\t});\r\n");
      out.write("\t\t\tg_canvas.addFigure(atomProc);\r\n");
      out.write("\t\t\tatomProc.toFront();\r\n");
      out.write("\t\t\t$(atomProc.shape[0]).attr(\"filter\", \"url(#AtomNodeFilter)\")\r\n");
      out.write("\t\t}\r\n");
      out.write("\t}\r\n");
      out.write("}\r\n");
      out.write("</script>\r\n");
      out.write("<div class=\"draw\">\r\n");
      out.write("\t<div id=\"flowdesignDiv\" style=\"width:100%;height:100%;\"></div>\r\n");
      out.write("</div>");
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
}
