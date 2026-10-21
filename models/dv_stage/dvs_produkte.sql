select {{ hash_key('produkt_nr') }} as hk_produkte,md5(concat_ws('||',
    coalesce(produktname, ''),
    coalesce(kategorie, ''),
	coalesce(cast(preis as varchar),'')
)) as hd_produkte,*
from {{ref('stg_shop__produkte')}}