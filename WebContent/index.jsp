<%@page contentType="text/html"%>
<%@taglib uri="cewolf.tld" prefix="cewolf" %>
<HTML>
<BODY>
<H1>Page View Statistics</H1>
<HR>
<jsp:useBean id="pageViews" class="ben.com.PageViewCountData"/>
<cewolf:chart 
    id="line" 
    title="Page View Statistics" 
    type="line" 
    xaxislabel="Page" 
    yaxislabel="Views">
    <cewolf:data>
        <cewolf:producer id="pageViews"/>
    </cewolf:data>
</cewolf:chart>
<p>
<cewolf:img chartid="line" renderer="cewolf" width="400" height="300"/>
<P>
</BODY>
</HTML>