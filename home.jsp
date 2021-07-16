<%--

    The contents of this file are subject to the license and copyright
    detailed in the LICENSE and NOTICE files at the root of the source
    tree and available online at

    http://www.dspace.org/license/

--%>
<%--
  - Home page JSP
  -
  - Attributes:
  -    communities - Community[] all communities in DSpace
  -    recent.submissions - RecetSubmissions
  --%>

<%@page import="org.dspace.core.factory.CoreServiceFactory"%>
<%@page import="org.dspace.core.service.NewsService"%>
<%@page import="org.dspace.content.service.CommunityService"%>
<%@page import="org.dspace.content.factory.ContentServiceFactory"%>
<%@page import="org.dspace.content.service.ItemService"%>
<%@page import="org.dspace.core.Utils"%>
<%@page import="org.dspace.content.Bitstream"%>
<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.dspace.org/dspace-tags.tld" prefix="dspace" %>

<%@ page import="java.io.File" %>
<%@ page import="java.util.Enumeration"%>
<%@ page import="java.util.Locale"%>
<%@ page import="java.util.List"%>
<%@ page import="javax.servlet.jsp.jstl.core.*" %>
<%@ page import="javax.servlet.jsp.jstl.fmt.LocaleSupport" %>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<%@ page import="org.dspace.core.I18nUtil" %>
<%@ page import="org.dspace.app.webui.util.UIUtil" %>
<%@ page import="org.dspace.app.webui.components.RecentSubmissions" %>
<%@ page import="org.dspace.content.Community" %>
<%@ page import="org.dspace.browse.ItemCounter" %>
<%@ page import="org.dspace.content.Item" %>
<%@ page import="org.dspace.services.ConfigurationService" %>
<%@ page import="org.dspace.services.factory.DSpaceServicesFactory" %>

<%
    List<Community> communities = (List<Community>) request.getAttribute("communities");

    Locale sessionLocale = UIUtil.getSessionLocale(request);
    Config.set(request.getSession(), Config.FMT_LOCALE, sessionLocale);
    NewsService newsService = CoreServiceFactory.getInstance().getNewsService();
    String topNews = newsService.readNewsFile(LocaleSupport.getLocalizedMessage(pageContext, "news-top.html"));
    String sideNews = newsService.readNewsFile(LocaleSupport.getLocalizedMessage(pageContext, "news-side.html"));

    ConfigurationService configurationService = DSpaceServicesFactory.getInstance().getConfigurationService();
    
    boolean feedEnabled = configurationService.getBooleanProperty("webui.feed.enable");
    String feedData = "NONE";
    if (feedEnabled)
    {
        // FeedData is expected to be a comma separated list
        String[] formats = configurationService.getArrayProperty("webui.feed.formats");
        String allFormats = StringUtils.join(formats, ",");
        feedData = "ALL:" + allFormats;
    }
    
    ItemCounter ic = new ItemCounter(UIUtil.obtainContext(request));

    RecentSubmissions submissions = (RecentSubmissions) request.getAttribute("recent.submissions");
    ItemService itemService = ContentServiceFactory.getInstance().getItemService();
    CommunityService communityService = ContentServiceFactory.getInstance().getCommunityService();
%>

<dspace:layout locbar="nolink" titlekey="jsp.home.title" feedData="<%= feedData %>">
	<!-- main dspace -->
	<div class="row">
		<div class="col-md-4">
			<div class="widget widget-home">
				<h4 class="widget-title"><fmt:message key="jsp.layout.navbar-default.browseitemsby"/></h4>
				<ul>
					<li>
						<a href="<%= request.getContextPath() %>/community-list"><fmt:message key="jsp.layout.navbar-default.communities-collections"/></a>
					</li>
					<li>
						<a href="<%= request.getContextPath() %>/browse?type=dateissued"><fmt:message key="jsp.search.filter.dateIssued"/></a>
					</li>
					<li>
						<a href="<%= request.getContextPath() %>/browse?type=author"><fmt:message key="jsp.layout.navbar-default.authors"/></a>
					</li>
					<li>
						<a href="<%= request.getContextPath() %>/browse?type=title"><fmt:message key="jsp.layout.navbar-default.titles"/></a>
					</li>
					<li>
						<a href="<%= request.getContextPath() %>/browse?type=subject"><fmt:message key="jsp.layout.navbar-default.subjects"/></a>
					</li>
				</ul>
			</div>
		</div>

	<% if (submissions != null && submissions.count() > 0){ %>
        <div class="col-md-8">
			<div class="panel panel-primary">        
				<div id="recent-submissions-carousel" class="panel-heading carousel slide">
					<h3><fmt:message key="jsp.collection-home.recentsub"/>
						<%    if(feedEnabled)    {
								String[] fmts = feedData.substring(feedData.indexOf(':')+1).split(",");
								String icon = null;
								int width = 0;
								for (int j = 0; j < fmts.length; j++)
								{
									if ("rss_1.0".equals(fmts[j]))
									{
									icon = "rss1.gif";
									width = 80;
									}
									else if ("rss_2.0".equals(fmts[j]))
									{
									icon = "rss2.gif";
									width = 80;
									}
									else
									{
									icon = "rss.gif";
									width = 36;
									}
						%>
							<a href="<%= request.getContextPath() %>/feed/<%= fmts[j] %>/site"><img src="<%= request.getContextPath() %>/image/<%= icon %>" alt="RSS Feed" width="<%= width %>" height="15" style="margin: 3px 0 3px" /></a>
						<%
								}
							}
						%>
					</h3>
			
					<!-- Wrapper for slides -->
					<div class="carousel-inner">
					<%
						boolean first = true;
						for (Item item : submissions.getRecentSubmissions())
						{
							String displayTitle = itemService.getMetadataFirstValue(item, "dc", "title", null, Item.ANY);
							if (displayTitle == null)
							{
								displayTitle = "Untitled";
							}
							String displayAbstract = itemService.getMetadataFirstValue(item, "dc", "description", "abstract", Item.ANY);
							if (displayAbstract == null)
							{
								displayAbstract = "";
							}
					%>
						<div style="padding-bottom: 50px; min-height: 330px;" class="item <%= first?"active":""%>">
							<div style="padding-left: 80px; padding-right: 80px; display: inline-block;"><%= Utils.addEntities(StringUtils.abbreviate(displayTitle, 400)) %> 
								<a href="<%= request.getContextPath() %>/handle/<%=item.getHandle() %>" class="btn btn-success">See</a>
										<p><%= Utils.addEntities(StringUtils.abbreviate(displayAbstract, 500)) %></p>
							</div>
						</div>
					<%
							first = false;
						}
					%>
					</div>

					<!-- Controls -->
					<a class="left carousel-control" href="#recent-submissions-carousel" data-slide="prev">
						<span class="icon-prev"></span>
					</a>
					<a class="right carousel-control" href="#recent-submissions-carousel" data-slide="next">
						<span class="icon-next"></span>
					</a>

					<ol class="carousel-indicators">
						<li data-target="#recent-submissions-carousel" data-slide-to="0" class="active"></li>
						<% for (int i = 1; i < submissions.count(); i++){ %>
						<li data-target="#recent-submissions-carousel" data-slide-to="<%= i %>"></li>
						<% } %>
					</ol>
				</div>
			</div>
		</div>
		<% } %>		
	</div>
	
	<div class="row">
	<%	if (communities != null && communities.size() != 0)	{ %>
		<div class="col-md-4">		
			<!-- <h3><fmt:message key="jsp.home.com1"/></h3>
			<p><fmt:message key="jsp.home.com2"/></p> -->
			<div class="list-group">
			<%
				boolean showLogos = configurationService.getBooleanProperty("jspui.home-page.logos", true);
				for (Community com : communities)
				{
			%><div class="list-group-item row">
			<%  
				Bitstream logo = com.getLogo();
				if (showLogos && logo != null) { %>
				<div class="col-md-3">
					<img alt="Logo" class="img-responsive" src="<%= request.getContextPath() %>/retrieve/<%= logo.getID() %>" /> 
				</div>
				<div class="col-md-9">
			<% } else { %>
				<div class="col-md-12">
			<% }  %>		
					<h4 class="list-group-item-heading"><a href="<%= request.getContextPath() %>/handle/<%= com.getHandle() %>"><%= com.getName() %></a>
			<%
					if (configurationService.getBooleanProperty("webui.strengths.show"))
					{
			%>
					<span class="badge pull-right"><%= ic.getCount(com) %></span>
			<%
					}

			%>
					</h4>
					<p><%= communityService.getMetadata(com, "short_description") %></p>
				</div>
			</div>                            
			<%
				}
			%>
			</div>
		</div>
		<%	} %>
		<%
			int discovery_panel_cols = 8;
			int discovery_facet_cols = 4;
		%>
		<%@ include file="discovery/static-sidebar-facet.jsp" %>
		</div>

		<!-- end enroll section -->
		<div class="row">
			<%@ include file="discovery/static-tagcloud-facet.jsp" %>
		</div>
		
	</div>
<!-- end main dspace -->

<!-- enroll section -->
	<section class="enroll-section spad set-bg" data-setbg="img/enroll-bg.jpg" style="background-image: url(https://lib.hueic.edu.vn/jspui/image//cuoc_thi_ao_dai.jpg);">
		<div class="container">
			<div class="row">
				<div class="col-lg-5">
					<div class="section-title text-white">
						<h3>ENROLLMENT</h3>
						<p>Hãy bắt đầu với chúng tôi để khám phá những điều thú vị</p>
					</div>
					<div class="enroll-list text-white">
						<div class="enroll-list-item">
							<span>1</span>
							<h5>Contact</h5>
							<p>Liên hệ với người quản trị thư viện số.</p>
						</div>
						<div class="enroll-list-item">
							<span>2</span>
							<h5>Tư vấn</h5>
							<p>Người quản trị thư viện sẽ tư vấn cho bạn và hướng dẫn bạn sử dụng thư viện số.</p>
						</div>
						<div class="enroll-list-item">
							<span>3</span>
							<h5>Đăng ký</h5>
							<p>Vui lòng đăng ký tài khoản để sử dụng thư viện số.</p>
						</div>
					</div>
				</div>
				<div class="col-lg-6 offset-lg-1 p-lg-0 p-4">
					<img src="https://tuyensinh.hueic.edu.vn/wp-content/uploads/2021/06/banner2-1024x512-1.jpeg" alt="" data-pagespeed-url-hash="161842772" onload="pagespeed.CriticalImages.checkImageForCriticality(this);">
					</div>
				</div>
			</div>
		</div>
	</section>
<!-- end enroll section -->

<!-- gallery -->
<div class="gallery-section">
	<div class="gallery" style="position: relative; height: 475.75px;">
		<div class="grid-sizer"></div>
		<div class="gallery-item gi-big set-bg" data-setbg="img/gallery/1.jpg" style="background-image: url(https://tuyensinh.hueic.edu.vn/wp-content/uploads/2017/02/15cd4-554x640.png); height: 475.75px; position: absolute; left: 0px; top: 0px;">
			<a class="img-popup" href="img/gallery/1.jpg">
				<i class="ti-plus"></i>
			</a>
		</div>
		<div class="gallery-item set-bg" data-setbg="img/gallery/2.jpg" style="background-image: url(https://lib.hueic.edu.vn/jspui/image/2.jpg); height: 237.867px; position: absolute; left: 475px; top: 0px;">
			<a class="img-popup" href="img/gallery/2.jpg">
				<i class="ti-plus"></i>
			</a>
		</div>
		<div class="gallery-item set-bg" data-setbg="img/gallery/3.jpg" style="background-image: url(https://lib.hueic.edu.vn/jspui/image/3.jpg); height: 237.867px; position: absolute; left: 713px; top: 0px;">
			<a class="img-popup" href="img/gallery/3.jpg">
				<i class="ti-plus"></i>
			</a>
		</div>
		<div class="gallery-item gi-long set-bg" data-setbg="img/gallery/5.jpg" style="background-image: url(https://lib.hueic.edu.vn/jspui/image/nhap-hoc-online.png); height: 237.875px; position: absolute; left: 951px; top: 0px;">
			<a class="img-popup" href="img/gallery/5.jpg">
				<i class="ti-plus"></i>
			</a>
		</div>
		<div class="gallery-item gi-big set-bg" data-setbg="img/gallery/8.jpg" style="background-image: url(https://lib.hueic.edu.vn/jspui/image/8.jpg); height: 475.75px; position: absolute; left: 1427px; top: 0px;">
			<a class="img-popup" href="img/gallery/8.jpg">
				<i class="ti-plus"></i>
			</a>
		</div>
		<div class="gallery-item gi-long set-bg" data-setbg="img/gallery/4.jpg" style="background-image: url(https://lib.hueic.edu.vn/jspui/image/img_475_237.png); height: 237.875px; position: absolute; left: 475px; top: 237px;">
			<a class="img-popup" href="img/gallery/4.jpg">
				<i class="ti-plus"></i>
			</a>
		</div>
		<div class="gallery-item set-bg" data-setbg="img/gallery/6.jpg" style="background-image: url(https://lib.hueic.edu.vn/jspui/image/6.jpg); height: 237.867px; position: absolute; left: 951px; top: 237px;">
			<a class="img-popup" href="img/gallery/6.jpg">
				<i class="ti-plus"></i>
			</a>
		</div>
		<div class="gallery-item set-bg" data-setbg="img/gallery/7.jpg" style="background-image: url(https://lib.hueic.edu.vn/jspui/image/sv.png); height: 237.867px; position: absolute; left: 1189px; top: 237px;">
			<a class="img-popup" href="img/gallery/7.jpg">
				<i class="ti-plus"></i>
			</a>
		</div>
	</div>
</div>
<!-- end gallery -->

<!-- news section -->
<%= topNews %>
<!--  -->
</dspace:layout>
