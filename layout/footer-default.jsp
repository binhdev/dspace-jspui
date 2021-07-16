<%--

    The contents of this file are subject to the license and copyright
    detailed in the LICENSE and NOTICE files at the root of the source
    tree and available online at

    http://www.dspace.org/license/

--%>
<%--
  - Footer for home page
  --%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ page contentType="text/html;charset=UTF-8" %>

<%@ page import="java.net.URLEncoder" %>
<%@ page import="org.dspace.app.webui.util.UIUtil" %>

<%
    String sidebar = (String) request.getAttribute("dspace.layout.sidebar");
%>

            <%-- Right-hand side bar if appropriate --%>
<%
    if (sidebar != null)
    {
%>
	</div>
	<div class="col-md-3">
                    <%= sidebar %>
    </div>
    </div>       
<%
    }
%>
</div>
</main>
        <%-- Page footer --%>
        <footer class="footer-section">
            <div class="container footer-top">
                <div class="row">
                    <div class="col-sm-6 col-lg-3 footer-widget">
                        <div class="about-widget">
                            <img src="http://hueic.edu.vn/Portals/0/LG.png?ver=2017-01-22-123346-610" alt="" data-pagespeed-url-hash="1182666511" onload="pagespeed.CriticalImages.checkImageForCriticality(this);">
                            <p>Thư viện số cung cấp tài liệu dành cho giảng viên và sinh viên trong quá trình học tập và giảng dạy</p>
                            <div class="social pt-1">
                                <a href="">
                                    <i class="fa fa-twitter-square"></i>
                                </a>
                                <a href="">
                                    <i class="fa fa-facebook-square"></i>
                                </a>
                                <a href="">
                                    <i class="fa fa-google-plus-square"></i>
                                </a>
                                <a href="">
                                    <i class="fa fa-linkedin-square"></i>
                                </a>
                                <a href="">
                                    <i class="fa fa-rss-square"></i>
                                </a>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-6 col-lg-3 footer-widget">
                        <h6 class="fw-title">HỆ THỐNG PHẦN MỀM</h6>
                        <div class="dobule-link">
                            <ul>
                                <li>
                                    <a href="http://http://hueic.edu.vn/CMCSoft.IU.Web">Quản lý đào tạo</a>
                                </li>
                                <li>
                                    <a href="http://hueic.edu.vn/vi-vn/hueic/qu%E1%BA%A3nl%C3%BDc%C3%B4ngv%C4%83n.aspx">Quản lý công văn</a>
                                </li>
                                <li>
                                    <a href="">Quản lý tài sản</a>
                                </li>
                                <li>
                                    <a href="http://mail.office365.com/">Hệ thống thư điện tử</a>
                                </li>
                                <li>
                                    <a href="http://e5.onthehub.com/d.ashx?s=x4yfdd5tyu">Hệ thống MSDN AA</a>
                                </li>
                            </ul>                            
                        </div>
                    </div>
                    <div class="col-sm-6 col-lg-3 footer-widget">
                        <h6 class="fw-title">DÀNH CHO KHÁCH</h6>
                        <div class="dobule-link">
                            <ul>
                                <li>
                                    <a href="http://hueic.edu.vn/vi-vn/hueic/quy%C4%91%E1%BB%8Bnhn%E1%BB%99ib%E1%BB%99.aspx">Quy định chung</a>
                                </li>
                                <li>
                                    <a href="http://hueic.edu.vn/vi-vn/hueic/h%E1%BB%87th%E1%BB%91ngqu%E1%BA%A3nl%C3%BDch%E1%BA%A5tl%C6%B0%E1%BB%A3ng/th%E1%BB%A7t%E1%BB%A5cquytr%C3%ACnh.aspx">Thủ tục - Quy trình công việc</a>
                                </li>
                                <li>
                                    <a href="http://hueic.edu.vn/vi-vn/hueic/danhb%E1%BA%A1%C4%91i%E1%BB%87ntho%E1%BA%A1i.aspx">Thủ tục - Quy trình công việc</a>
                                </li>
                                <li>
                                    <a href="http://hueic.edu.vn/vi-vn/hueic/s%C6%A1%C4%91%E1%BB%93tr%C6%B0%E1%BB%9Dng.aspx">Sơ đồ trường</a>
                                </li>
                                <li>
                                    <a href="http://hueic.edu.vn/vi-vn/hueic/trac%E1%BB%A9ub%E1%BA%B1ng.aspx">Tra cứu bằng tốt nghiệp</a>
                                </li>
                            </ul>  
                        </div>                      
                    </div>
                    <div class="col-sm-6 col-lg-3 footer-widget">
                        <h6 class="fw-title">CONTACT</h6>
                        <ul class="contact">
                            <li>
                                <p>
                                    <i class="fa fa-map-marker"></i> 70 Nguyễn Huệ, Huế City, VN
                                </p>
                            </li>
                            <li>
                                <p>
                                    <i class="fa fa-phone"></i> +84-0234-3822813
                                </p>
                            </li>
                            <li>
                                <p>
                                    <i class="fa fa-envelope"></i> ttbinh@hueic.edu.vn
                                </p>
                            </li>
                            <li>
                                <p>
                                    <i class="fa fa-clock-o"></i> Monday - Friday, 08:00AM - 06:00 PM
                                </p>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="copyright">
                <div class="container">
                    <p>
        Copyright ©
                        <script>document.write(new Date().getFullYear());</script>2021 All rights reserved | This template is made with 
                        <i class="fa fa-heart-o" aria-hidden="true"></i> by 
                        <a href="https://colorlib.com/" target="_blank">ThanhBinh</a>
                    </p>
                </div>
            </div>
        </footer>
    </body>
</html>