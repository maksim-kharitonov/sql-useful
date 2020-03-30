declare 
      Result    clob; 
      iLen      integer:=DBMS_LOB.lobmaxsize; 
      iSrcOffs  integer:=1; 
      iDstOffs  integer:=1; 
      iCSID     integer:= nls_charset_id('CL8MSWIN1251'); -- DBMS_LOB.default_csid; 
      iLang     integer:=DBMS_LOB.default_lang_ctx; 
      iWarn     integer; 
   begin 
      DBMS_LOB.CreateTemporary(a_xml,true); 
      DBMS_LOB.convertToBlob( a_xml,a_clob,iLen,iSrcOffs,iDstOffs,iCSID,iLang,iWarn); 
   end;

declare 
      Result    clob; 
      iLen      integer:=DBMS_LOB.lobmaxsize; 
      iSrcOffs  integer:=1; 
      iDstOffs  integer:=1; 
      iCSID     integer:= nls_charset_id('CL8MSWIN1251'); -- DBMS_LOB.default_csid; 
      iLang     integer:=DBMS_LOB.default_lang_ctx; 
      iWarn     integer; 
   begin 
      DBMS_LOB.CreateTemporary(a_xml,true); 
      DBMS_LOB.convertToBlob( a_xml,a_clob,iLen,iSrcOffs,iDstOffs,iCSID,iLang,iWarn); 
   end;