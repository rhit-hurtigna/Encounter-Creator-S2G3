USE EncounterCreatorS2G3
select 'GRANT EXECUTE ON ['+name+'] TO application  '  
from sys.objects  
where type ='P' 
and is_ms_shipped = 0  
and name not like 'sp_%'