select {{ hash_key('bestell_nr') }} as hk_bestellungen,{{ hash_key('kunden_nr') }} as hk_kunden,{{ hash_key("kunden_nr || '||' || bestell_nr") }} as hk_kunden_bestellung,md5(concat_ws('||',
    coalesce(cast(bestelldatum as varchar),''),
	coalesce(status,'')
	
)) as hd_bestellungen,*
from {{ref('stg_shop__bestellungen')}}