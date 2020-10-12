<%--

    The contents of this file are subject to the license and copyright
    detailed in the LICENSE and NOTICE files at the root of the source
    tree and available online at

    http://www.dspace.org/license/

--%>
<%--
  - HTML header for main home page
  --%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.dspace.org/dspace-tags.tld" prefix="dspace" %>

<%@ page contentType="text/html;charset=UTF-8" %>

<%@ page import="java.util.List"%>
<%@ page import="java.util.Enumeration"%>
<%@ page import="org.dspace.app.webui.util.JSPManager" %>
<%@ page import="org.dspace.core.ConfigurationManager" %>
<%@ page import="org.dspace.app.util.Util" %>
<%@ page import="javax.servlet.jsp.jstl.core.*" %>
<%@ page import="javax.servlet.jsp.jstl.fmt.*" %>


<%@ page import="org.dspace.core.I18nUtil" %>
<%@ page import="org.dspace.app.webui.util.UIUtil" %>
<%@ page import="java.util.Locale"%>

<%
    // Get the current page, minus query string
    String currentPage = UIUtil.getOriginalURL(request);
    int c = currentPage.indexOf( '?' );
    if( c > -1 )
    {
        currentPage = currentPage.substring( 0, c );
    }

    // get the locale languages
    Locale[] supportedLocales = I18nUtil.getSupportedLocales();
    Locale sessionLocale = UIUtil.getSessionLocale(request);
    
    String title = (String) request.getAttribute("dspace.layout.title");
    String navbar = (String) request.getAttribute("dspace.layout.navbar");
    boolean locbar = ((Boolean) request.getAttribute("dspace.layout.locbar")).booleanValue();

    String siteName = ConfigurationManager.getProperty("dspace.name");
    String feedRef = (String)request.getAttribute("dspace.layout.feedref");
    boolean osLink = ConfigurationManager.getBooleanProperty("websvc.opensearch.autolink");
    String osCtx = ConfigurationManager.getProperty("websvc.opensearch.svccontext");
    String osName = ConfigurationManager.getProperty("websvc.opensearch.shortname");
    List parts = (List)request.getAttribute("dspace.layout.linkparts");
    String extraHeadData = (String)request.getAttribute("dspace.layout.head");
    String extraHeadDataLast = (String)request.getAttribute("dspace.layout.head.last");
    String dsVersion = Util.getSourceVersion();
    String generator = dsVersion == null ? "DSpace" : "DSpace "+dsVersion;
    String analyticsKey = ConfigurationManager.getProperty("jspui.google.analytics.key");


%>

<!DOCTYPE html>
<html>
    <head>
        <title><%= siteName %>: <%= title %></title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="Generator" content="<%= generator %>" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="shortcut icon" href="<%= request.getContextPath() %>/favicon.ico" type="image/x-icon"/>
        <link rel="stylesheet" href="<%= request.getContextPath() %>/static/css/jquery-ui-1.10.3.custom/redmond/jquery-ui-1.10.3.custom.css" type="text/css" />
        <link rel="stylesheet" href="<%= request.getContextPath() %>/static/css/bootstrap/bootstrap.min.css" type="text/css" />
        <link rel="stylesheet" href="<%= request.getContextPath() %>/static/css/bootstrap/bootstrap-theme.min.css" type="text/css" />
        <link rel="stylesheet" href="<%= request.getContextPath() %>/static/css/bootstrap/dspace-theme.css" type="text/css" />
        
<%
    if (!"NONE".equals(feedRef))
    {
        for (int i = 0; i < parts.size(); i+= 3)
        {
%>
        <link rel="alternate" type="application/<%= (String)parts.get(i) %>" title="<%= (String)parts.get(i+1) %>" href="<%= request.getContextPath() %>/feed/<%= (String)parts.get(i+2) %>/<%= feedRef %>"/>
<%
        }
    }
    
    if (osLink)
    {
%>
        <link rel="search" type="application/opensearchdescription+xml" href="<%= request.getContextPath() %>/<%= osCtx %>description.xml" title="<%= osName %>"/>
<%
    }

    if (extraHeadData != null)
        { %>
<%= extraHeadData %>
<%
        }
%>
        
        <script type='text/javascript' src="<%= request.getContextPath() %>/static/js/jquery/jquery-1.10.2.min.js"></script>
        <script type='text/javascript' src='<%= request.getContextPath() %>/static/js/jquery/jquery-ui-1.10.3.custom.min.js'></script>
        <script type='text/javascript' src='<%= request.getContextPath() %>/static/js/bootstrap/bootstrap.min.js'></script>
        <script type='text/javascript' src='<%= request.getContextPath() %>/static/js/holder.js'></script>
        <script type="text/javascript" src="<%= request.getContextPath() %>/utils.js"></script>
        <script type="text/javascript" src="<%= request.getContextPath() %>/static/js/choice-support.js"> </script>
        <dspace:include page="/layout/google-analytics-snippet.jsp" />

    <%
    if (extraHeadDataLast != null)
    { %>
        <%= extraHeadDataLast %>
    <%
    }
    %>
    

<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
  <script src="<%= request.getContextPath() %>/static/js/html5shiv.js"></script>
  <script src="<%= request.getContextPath() %>/static/js/respond.min.js"></script>
<![endif]-->
    </head>

    <%-- HACK: leftmargin, topmargin: for non-CSS compliant Microsoft IE browser --%>
    <%-- HACK: marginwidth, marginheight: for non-CSS compliant Netscape browser --%>
    <body class="undernavigation">        
        <a class="sr-only" href="#content">Skip navigation</a>
        <header class="navbar-fixed-top" style="background-color: #020661;">    
            <%
                if (!navbar.equals("off"))
                {
                    if (supportedLocales != null && supportedLocales.length > 1)
                        {
            %>
                    <div class="" >
                        <div class="row clearfix">
                            <div class="col-md-3 col-lg-offset-9" style="background-color: #0ffdff;">                                
                                <div class="float-right">
                                    <ul class="list-inline">  
                                        <%
                                          
                                         for (int i = supportedLocales.length-1; i >= 0; i--) 
                                            {
                                        %>                                      
                                        <li style="border-right: 1px solid #000;">
                                            <a style="text-decoration: none; color: #000000;" onclick="javascript:document.repost.locale.value='<%=supportedLocales[i].toString()%>';
                                                document.repost.submit();" href="<%= currentPage %>?locale=<%=supportedLocales[i].toString()%>">
                                       <%= supportedLocales[i].getDisplayLanguage(supportedLocales[i])%>
                                     </a>                                         
                                        </li>
                                        <%
                                            }
                                        %>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%
                        }
                    %>
                
                    <div class="container">
                        <dspace:include page="<%= navbar %>" />
                    </div>
            <%
                }
                else
                {       
                %>
        <div class="container">
            <dspace:include page="/layout/navbar-minimal.jsp" />
        </div>
<%
    }
%>
</header>

<main id="content" role="main">
    <div class="banner" style=" background-color: #0ffdff;">
        <div class="container">            
            <div class="row" style=" display: block;">
                <!-- Old version -->
                <!-- <div class="col-md-9 brand">
                    <h1><fmt:message key="jsp.layout.header-default.brand.heading" /></h1>
                    <fmt:message key="jsp.layout.header-default.brand.description" /> 
                </div>
                <div class="col-md-3"><img class="pull-right" src="<%= request.getContextPath() %>/image/logo.gif" alt="DSpace logo" />
                </div> -->

                <!-- Custom Version -->
                <div class="col-md-6">
                    <img class="pull-left" src="<%= request.getContextPath() %>/image/logo-img.png" 
                        style="background-color: #0ffdff; padding-top: 10px;" alt="DSpace logo" />
                    <div class="text-center" style="padding-top: 50px;">
                        <span
                            style="font-size: 15px; font-weight: bold; text-transform: uppercase; line-height: 21px;
                            color: #020661;">
                            ORGANISATION POUR L’HARMONISATION</br>EN AFRIQUE DU DROIT DES AFFAIRES                            
                        </span> 
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="pull-right" >
                        <img 
                        class="pull-left" style="background-color: #0ffdff; " 
                        src="<%= request.getContextPath() %>/image/world-img.png" alt="DSpace logo" />
                    </div>

                    <div class="pull-right" style="padding-right: 70px; padding-top: 10px;">
                        <img 
                            style="background-color: #0ffdff;" 
                            src="<%= request.getContextPath() %>/image/header-img.png" alt="DSpace logo" />
                    </div>
                    
                </div>
            </div>
        </div>
    </div>
<br/>
                <%-- Location bar --%>
<%
    if (locbar)
    {
%>
<div class="container">
    <dspace:include page="/layout/location-bar.jsp" />
</div>                
<%
    }
%>


        <%-- Page contents --%>
<div class="container">
<% if (request.getAttribute("dspace.layout.sidebar") != null) { %>
    <div class="row">
    <div class="col-md-9">
<% } %>	
