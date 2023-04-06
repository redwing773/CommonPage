<%@tag pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<spring:eval expression="@environment.getProperty('spring.config.activate.on-profile')" var="activeProfile" />
<script>
	//컨텍스트 패스 작업으로 변수 추가
	var contextPath = "${pageContext.request.contextPath}";
</script>
<script type="text/javascript" src="${pageContext.request.contextPath}/tds/js/com/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/apps/common/js/ui.js"></script>
<script src="${pageContext.request.contextPath}/tds/js/com/jquery.tmpl.min.js"></script>

<script type="text/javascript" src="${pageContext.request.contextPath}/js/properties.js?ver=20221102"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/tds/js/tms.util.js?ver=20221115"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/apps/common/js/common.js?ver=20221115"></script>
<script type="test/javascript" src="${pageContext.request.contextPath}/apps/common/js/appWebLinker.js"></script><!-- 추가  -->
<script type="text/javascript" src="${pageContext.request.contextPath}/tds/js/com/moment-with-locales.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/tds/js/com/moment-timezone-with-data.js"></script>
<c:if test="${activeProfile eq 'dev'}">
    <!-- Google Tag Manager -->
    <script>(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
            new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
        j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
        'https://www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
    })(window,document,'script','dataLayer','GTM-TPZXZ6K');</script>
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
</c:if>

<c:if test="${activeProfile eq 'qa'}">
    <!-- Google Tag Manager -->
    <script>(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
            new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
        j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
        'https://www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
    })(window,document,'script','dataLayer','GTM-P9PPVM9');</script>
    <!-- End Google Tag Manager -->

    <!-- Google Tag Manager -->
    <script>(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
            new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
        j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
        'https://www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
    })(window,document,'script','dataLayer','GTM-WDGZTMV');</script>
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
</c:if>

<c:if test="${activeProfile eq 'live'}">
<!-- Facebook Pixel Code -->
<script>
  !function(f,b,e,v,n,t,s)
  {if(f.fbq)return;n=f.fbq=function(){n.callMethod?
  n.callMethod.apply(n,arguments):n.queue.push(arguments)};
  if(!f._fbq)f._fbq=n;n.push=n;n.loaded=!0;n.version='2.0';
  n.queue=[];t=b.createElement(e);t.async=!0;
  t.src=v;s=b.getElementsByTagName(e)[0];
  s.parentNode.insertBefore(t,s)}(window, document,'script',
  'https://connect.facebook.net/en_US/fbevents.js');
  fbq('init', '200860694340440');
  fbq('track', 'PageView');
</script>
<noscript><img height="1" width="1" style="display:none"
  src="https://www.facebook.com/tr?id=200860694340440&ev=PageView&noscript=1"
/></noscript>
<!-- End Facebook Pixel Code -->

<!-- Google Tag Manager -->
<script>(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
'https://www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
})(window,document,'script','dataLayer','GTM-K85LNHK');</script>
<!-- End Google Tag Manager -->
</c:if>