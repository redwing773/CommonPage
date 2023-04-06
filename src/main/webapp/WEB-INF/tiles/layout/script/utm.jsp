<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<spring:eval expression="@environment.getProperty('spring.config.activate.on-profile')" var="activeProfile" />
<c:choose>
    <c:when test="${activeProfile eq 'dev'}">
        <!-- Google Tag Manager --> <script>(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
            new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0], j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src= 'https://www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f); })(window,document,'script','dataLayer','GTM-WDGZTMV');</script>
        <!-- End Google Tag Manager -->

        <!-- Etoos Tag Manager -->
        <script>
            try{
                var _mtm = window._mtm = window._mtm || [];
                _mtm.push({'mtm.startTime': (new Date().getTime()), 'event': 'mtm.Start'});
                var d = document, g = d.createElement('script'), s = d.getElementsByTagName('script')[0];
                g.async = true;
                g.src = 'https://dev-wec.etoos.com/piwik/js/container_v3mYY3gR.js';
                s.parentNode.insertBefore(g, s);
            }
            catch (error){
                console.log(error);
            }
        </script>
        <!-- End Etoos Tag Manager -->
    </c:when>
    <c:when test="${activeProfile eq 'qa'}">
        <!-- Google Tag Manager --> <script>(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
            new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0], j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src= 'https://www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f); })(window,document,'script','dataLayer','GTM-WDGZTMV');</script>
        <!-- End Google Tag Manager -->

        <!-- Etoos Tag Manager -->
        <script>
            try{
                var _mtm = window._mtm = window._mtm || [];
                _mtm.push({'mtm.startTime': (new Date().getTime()), 'event': 'mtm.Start'});
                var d = document, g = d.createElement('script'), s = d.getElementsByTagName('script')[0];
                g.async = true;
                g.src = 'https://stage-wec.etoos.com/piwik/js/container_lwvBjje2.js';
                s.parentNode.insertBefore(g, s);
            }
            catch (error){
                console.log(error);
            }
        </script>
        <!-- End Etoos Tag Manager -->
    </c:when>
    <c:when test="${activeProfile eq 'live'}">
        <!-- Google Tag Manager --> <script>(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
            new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0], j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src= 'https://www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f); })(window,document,'script','dataLayer','GTM-5FGHQ98');</script>
        <!-- End Google Tag Manager -->

        <!-- Etoos Tag Manager -->
        <script>
            try{
                var _mtm = window._mtm = window._mtm || [];
                _mtm.push({'mtm.startTime': (new Date().getTime()), 'event': 'mtm.Start'});
                var d = document, g = d.createElement('script'), s = d.getElementsByTagName('script')[0];
                g.async = true;
                g.src = 'https://wec.etoos.com/piwik/js/container_GhyugXTR.js';
                s.parentNode.insertBefore(g, s);
            }
            catch (error){
                console.log(error);
            }
        </script>
        <!-- End Etoos Tag Manager -->
    </c:when>
</c:choose>
