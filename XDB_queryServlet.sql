 SELECT XMLQuery( q'(declare default element namespace "http://xmlns.oracle.com/xdb/xdbconfig.xsd";
       for $doc in fn:doc("/xdbconfig.xml")/xdbconfig/sysconfig/protocolconfig/httpconfig/webappconfig/servletconfig/servlet-list/servlet[servlet-name='orawsv']
       return $doc )'
       RETURNING CONTENT).getClobVal()
       from dual
/
 SELECT XMLQuery( q'(declare default element namespace "http://xmlns.oracle.com/xdb/xdbconfig.xsd";
       for $doc in fn:doc("/xdbconfig.xml")/xdbconfig/sysconfig/protocolconfig/httpconfig/webappconfig/servletconfig/servlet-list
       return $doc )'
       RETURNING CONTENT).getClobVal()
       from dual
/

XQUERY declare default element namespace "http://xmlns.oracle.com/xdb/xdbconfig.xsd"; (: :)
       (: This path is split over two lines for documentation purposes only.
          The path should actually be a single long line. :)
       for $doc in fn:doc("/xdbconfig.xml")/xdbconfig/sysconfig/protocolconfig/httpconfig/
        webappconfig/servletconfig/servlet-list/servlet[servlet-name='orawsv']
       return $doc
/