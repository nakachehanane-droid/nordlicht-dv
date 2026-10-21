select {{ hash_key('bestell_nr') }} as hk_bestellungen,{{ hash_key('produkt_nr') }} as hk_produkte,{{ hash_key("bestell_nr || '||' || produkt_nr|| '||' ||position") }} as hk_bestellpositionen,md5(concat_ws('||',
    coalesce(cast(menge as varchar),''),
	coalesce(cast(einzelpreis_eur as varchar),'')
	
)) as hd_bestellpositionen,*
from {{ref('stg_shop__bestellpositionen')}}