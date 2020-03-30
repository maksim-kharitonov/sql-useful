select tbl.owner, tbl.segment_name, tbl.tbl_size, 
       nvl(sum(dsi.bytes),0)/1024/1024 ind_size, 
       nvl(sum(dsl.bytes),0)/1024/1024 lob_size, 
       tbl.tbl_size +nvl(sum(dsi.bytes),0)/1024/1024 + nvl(sum(dsl.bytes),0)/1024/1024 total
  from ( SELECT dst.owner, dst.segment_name, dst.segment_type/*, dst.tablespace_name*/
              , sum(dst.bytes)/1024/1024 tbl_size
           FROM dba_segments dst
          WHERE dst.segment_type = 'TABLE' 
            and dst.owner like 'IBE%' 
            and dst.segment_name ='A_ACC_VALUES'
          group by dst.owner, dst.segment_name, dst.segment_type/*, dst.tablespace_name*/
        )tbl
        , dba_indexes i, dba_segments dsi
        , dba_lobs l, dba_segments dsl       
 where i.table_name(+) = tbl.segment_name and i.table_owner(+) = tbl.owner
   and dsi.segment_name(+) = i.index_name and dsi.owner(+) = i.owner
   and l.TABLE_NAME(+) = tbl.segment_name and l.OWNER(+) = tbl.owner
   and dsl.segment_name(+) = l.SEGMENT_NAME and dsl.owner(+) = l.owner
group by tbl.owner, tbl.segment_name, tbl.tbl_size   
--having tbl.tbl_size +sum(dsi.bytes)/1024/1024/1024 > 3
order by total desc



select tbl.owner, tbl.segment_name, tbl.tbl_size, ind.ind_size, lbs.lob_size,
       tbl.tbl_size +nvl(ind.ind_size,0) + nvl(lbs.lob_size,0) total
  from ( SELECT dst.owner, dst.segment_name, dst.segment_type/*, dst.tablespace_name*/
              , sum(dst.bytes)/1024/1024 tbl_size
           FROM dba_segments dst
          WHERE dst.segment_type = 'TABLE' 
            and dst.owner like 'IBE%' 
            --and dst.segment_name ='LOGGING_EVENT'
          group by dst.owner, dst.segment_name, dst.segment_type/*, dst.tablespace_name*/
        )tbl
        ,(select i.table_owner owner, i.table_name table_name/*, i.index_type*/
                ,nvl(sum(dsi.bytes),0)/1024/1024 ind_size 
            from dba_indexes i, dba_segments dsi
           where dsi.segment_name(+) = i.index_name and dsi.owner(+) = i.owner
             and dsi.owner like 'IBE%' 
           group by i.table_owner, i.table_name/*, i.index_type*/
         ) ind
        ,(select l.OWNER, l.table_name table_name
                ,nvl(sum(dsl.bytes),0)/1024/1024 lob_size 
            from dba_lobs l, dba_segments dsl
           where dsl.segment_name(+) = l.SEGMENT_NAME and dsl.owner(+) = l.owner
             and dsl.owner like 'IBE%' 
           group by l.OWNER, l.table_name
         ) lbs 
 where ind.table_name(+) = tbl.segment_name and ind.owner(+) = tbl.owner
   and lbs.TABLE_NAME(+) = tbl.segment_name and lbs.OWNER(+) = tbl.owner
   and  tbl.tbl_size +nvl(ind.ind_size,0) + nvl(lbs.lob_size,0) > 50
order by total desc








  and dst.segment_name in (
'AAP_CROUND_ID',
'AAP_SOURCE_ID',
'ACC_ID',
'AC_ID',
'AC_TYPES',
'ADDA_CATPASS_ID',
'ADDA_ID',
'ADDA_PAY_ID',
'AGTYPE_ID',
'AG_ID',
'AK_ID',
'AK_INTERLINE_PARAM',
'ARCHIVE_TLGR',
'ASB_ID',
'AXP_ID',
'A_TA_VAL_ID',
'BANKS_ID',
'BDR_DOH',
'BOARD_ID',
'BON_PROG_ID',
'BO_EXORG_ID',
'BSOOWN_FIRM_ID',
'BSORESP_ID',
'BSO_FIELDS',
'BSO_FIELDS_COORD',
'BSO_FIELDS_VALUE',
'BSO_ID',
'BSO_INTERVAL',
'BSO_NUM_CNT',
'BSO_OP_ID',
'BSO_OWNERS_ID',
'BSO_PRICE_ID',
'CARGOCAT_ID',
'CARGO_TYPE',
'CATOP_ID',
'CATPASS_ID',
'CITY_ID',
'CLASS_CATPASS_ID',
'CLASS_ID',
'CLASS_RES_ID',
'COURIER_ID',
'CRAFTT_ID',
'CRAFT_ID',
'CRAFT_SYSTEM_ID',
'CRS_TRN_ID',
'CRS_TRN_OP_ID',
'CURRENCY_ID',
'CUR_ROUND_ID',
'C_APP_VERSION',
'C_CODES',
'C_CODES_VD',
'C_DICTIONARY',
'C_LINKS',
'C_OBJECTS',
'C_OPTIONS',
'C_PERIODS',
'C_PERIOD_TYPES',
'C_PS',
'C_PTS',
'C_PTW',
'C_REPORTS',
'C_RIGHTS',
'C_ROLES',
'C_ROLESDISTRIB',
'C_RVD',
'C_SYSTEMS',
'C_USERS',
'DEP_TYPES_ID',
'DGT_ID',
'DG_ACC_DECODE',
'DG_CHARTER_APP',
'DG_CHARTER_BN',
'DG_CHARTER_PZAPP',
'DG_CHARTER_QUOTA',
'DG_CHARTER_ROUTE',
'DG_CHECKLOG',
'DG_COM',
'DG_COMACC',
'DG_COMCOND',
'DG_COND',
'DG_CONDSTAT',
'DG_ID',
'DG_INTERLINE_COND',
'DG_INTERLINE_COND_LIST',
'DG_INTERLINE_CURR',
'DG_INTERLINE_VALUES',
'DG_METH',
'DG_PACT',
'DG_PACTAPP',
'DG_PRIORS',
'DG_TARGET_TMP',
'DG_TEST_COM',
'DG_TEST_COND',
'DG_TEST_PACT',
'DG_TYPE',
'DG_USER_TYPE',
'DG_UT_AK',
'DG_UT_BOWN',
'DISC_ORG_ID',
'DLVADDR_ID',
'DOCGEN_ID',
'DOC_TYPE_ID',
'DSP_ID',
'DST_ID',
'DST_LOCAL_TIME',
'DTS_GRP_ID',
'DTS_ID',
'EA_DEALOPS_ID',
'EDUVD_ID',
'ERR_ID',
'EXCHANGE_ID',
'EXCHANGE_ORG_ID',
'EXCH_CURS_SRC',
'FC_ERRCODE',
'FC_ERRCODE_T',
'FC_ERRIN',
'FED_OKR_RF_ID',
'FGROUP_ID',
'FIRM_ID',
'FLY_PAUSE_ID',
'FORMUL_ID',
'HOLDING_ID',
'IDTYPE_ID',
'INCIDENT_ID',
'INCOME_INFO_ID',
'INSH_SUMS_ID',
'INSTR_PODTV_ID',
'INTERNET_SHOP_ID',
'INT_ICAT_ID',
'INT_ISTATUS_ID',
'INT_ITYPE_ID',
'INT_RM_ID',
'INT_SCODE_ID',
'KASS_ID',
'KBT_ID',
'KGLS_DOP_ID',
'KLASS_BOARD_ID',
'KLASS_ID',
'KPK_ID',
'KS50_ID',
'KVZ_ID',
'LANG_ID',
'LANG_SROK_LEVEL_ID',
'LANG_SROK_UROVEN_ICAO_ID',
'LITER_ID',
'LOST_BSO',
'MASK_ID',
'MEDKOM_ID',
'METEOTYPES_ID',
'METROLINIES_ID',
'METROSTATION_ID',
'MLOG$_BOARD_ID',
'MLOG$_CRAFT_ID',
'MLOG$_PORT_ID',
'NALET_VID',
'NDS_ACC',
'NDS_ACC_BSOWNER',
'NSI_LOG',
'OP_ACC_ID',
'OP_ID',
'OP_TAXTYPE_ID',
'ORGDOG_PSL',
'ORGP_ID',
'ORGS_ID',
'ORG_ATTR_ID',
'ORG_BANKGUAR_ID',
'ORG_DOG',
'ORG_DOP',
'ORG_DOP_ATTR',
'ORG_DOP_ROWS',
'ORG_PAY_ID',
'ORG_PRS_ID',
'ORG_SALDO_ID',
'ORTH_DISTANCE',
'OTHM_ID',
'PAY_DECODE',
'PAY_ID',
'PAY_XML_ID',
'PLANIR_BOARD_RESULT_ID',
'PODGOT_OT_ITS_ID',
'PORT_ID',
'POSMM_ID',
'PPLS_ID',
'PREM_PLANSALE',
'PREM_PSL',
'PRS_TYPES_ID',
'PRU_ID',
'PSL_CHANNEL',
'PSL_DESK_ID',
'PSL_ID',
'PSL_KASS_ID',
'PSL_NOPAYF',
'PT_ID',
'PVPMM_ID',
'PZ_SCHTYPE_ID',
'QUALIFICATION_ID',
'RABOTI_ITS_ID',
'RAZDEL_PODGOT_OT_ITS_ID',
'REASON_DELAYREYS_ID',
'REGIATA_ID',
'SATA_ID',
'SCALE_PR',
'SERT_ITS_ID',
'SFRF_ID',
'SL_RATES',
'SPA_PERIOD_ID',
'SPECIAL_ITS_ID',
'SPEC_ID',
'SPGROUP_ID',
'SQUADRON_ID',
'STAMP_ID',
'STATE_ID',
'SUT_RATE',
'SYSOP_ID',
'TASK_FLT_LIST',
'TASK_FLT_STR',
'TASK_LOG',
'TASK_LOG_H',
'TASK_STAGE',
'TASK_TYPE',
'TAXTYPE_ID',
'TAX_ID',
'TAX_PRICELIST_ID',
'TAX_RATE',
'TCC_AK',
'TCC_ID',
'TEMP_ID',
'TLGR_PARSE_LOG',
'TMP_BOARDPLANIR_RSLT_ID',
'TMP_EC_NAVLOAD1',
'TMP_EC_NAVLOAD2',
'TMP_STAMP_ID',
'TOUROP_ID',
'TOUR_ID',
'TRAINING_ID',
'TRANSLIT_WORD',
'TREP_ID',
'TT_STATUS_ID',
'TUNITS_ID',
'TUR_CLIENT_ID',
'UNITS_ID',
'USER_DOVER',
'USER_PLAN',
'UTS_TRN_ID',
'UTS_TRN_OP_ID',
'V1ACTVTP',
'V1CRAFTROT',
'V1CREVE',
'V1FP_DIC_PSID',
'V1ORG_BASE_PRT_ID',
'VTYPE_ID',
'VZMM_ID',
'VZPMM_ID',
'WH_ID',
'WV_ID',
'WWWTERM_ID',
'WWWTERM_TAP',
'YQ_AG_ID',
'ZAHTYPE_ID',
'ZONE_ID',
'ZTYPE_ID'
)  


)

/*select count(1) from SOFI_SKY_COD.a_trj  

\*UNION ALL
SELECT dsi.segment_name, dsi.bytes, dsi.blocks
FROM dba_indexes, dba_segments dsi
WHERE dba_indexes.table_owner = user
AND dba_indexes.table_owner = dsi.owner
AND dsi.segment_name = dba_indexes.index_name
and dsi.segment_name like 'WWW_TICKETS%'*\

dbms_space.
*/
