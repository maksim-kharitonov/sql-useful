create or replace type MakeRouteImpl as object
(
  ROUTE varchar2(2000), 
  static function ODCIAggregateInitialize(sctx IN OUT MakeRouteImpl) 
    return number,
  member function ODCIAggregateIterate(self IN OUT MakeRouteImpl, 
    value IN varchar2) return number,
  member function ODCIAggregateTerminate(self IN MakeRouteImpl, 
    returnValue OUT varchar2, flags IN number) return number,
  member function ODCIAggregateMerge(self IN OUT MakeRouteImpl, 
    ctx2 IN MakeRouteImpl) return number  
);
/
create or replace type body MakeRouteImpl is 
static function ODCIAggregateInitialize(sctx IN OUT MakeRouteImpl) 
return number is 
begin
  sctx := MakeRouteImpl('');
  return ODCIConst.Success;
end;

member function ODCIAggregateIterate(self IN OUT MakeRouteImpl, value IN varchar2) return number is
begin
  if self.Route is null then
    self.Route:=value
  else
    self.Route :=self.Route||'-'||value;
  end if;
  return ODCIConst.Success;
end;

member function ODCIAggregateTerminate(self IN MakeRouteImpl, 
    returnValue OUT number, flags IN number) return number is
begin
  returnValue := self.Route;
  return ODCIConst.Success;
end;

member function ODCIAggregateMerge(self IN OUT MakeRouteImpl, ctx2 IN MakeRouteImpl) return number is
begin
  self.Route :=self.Route||'-'||ctx2.Route;
  return ODCIConst.Success;
end;

end;
/
CREATE OR REPLACE FUNCTION MakeRoute (City1 varchar2) RETURN varchar2 AGGREGATE USING MakeRouteImpl;
/
SELECT MakeRoute(Getmaincode(os.city1_id)) departments 
  from A_OPR_CARRIERSEGMENTS os
 where os.ops_id in (319454499, 319453633)
 group by os.ops_id
