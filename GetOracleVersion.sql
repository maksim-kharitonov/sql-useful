SELECT t.*, substr(t.version,1,instr(t.version,'.')-1)FROM product_component_version t
where product like 'Oracle%';
