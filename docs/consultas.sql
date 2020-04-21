/* itinerarios de um dia */
select itinerario.*, dia.dia from itinerario
inner join dia_has_itinerario as di
on di.itinerario_id = itinerario.id
inner join dia
on dia.id = di.dia_id
where dia.id = 2;

/* id passageiros de um itinerario */
select ip.passageiro_id from itinerario_has_passageiro as ip
where ip.itinerario_id = 1 AND
ip.passageiro_id not in (
	select ausencia_passageiro.passageiro_id from ausencia_passageiro
	where ausencia_passageiro.data = '2020-04-14'
	AND ausencia_passageiro.itinerario_id = 1
)
group by ip.passageiro_id;

/* passageiros de um itinerario com endereco*/
select pa.id, pa.nome, en.*
from itinerario_has_passageiro as ip
inner join passageiro as pa
on pa.id = ip.passageiro_id
inner join endereco as en
on en.id = pa.endereco_endereco 
where ip.itinerario_id = 1 AND
ip.passageiro_id not in (
	select ausencia_passageiro.passageiro_id from ausencia_passageiro
	where ausencia_passageiro.data = '2020-04-14'
	AND ausencia_passageiro.itinerario_id = 1
)
group by ip.passageiro_id;

/* itinerarios de um passageiro */
select ip.itinerario_id from itinerario_has_passageiro as ip
where ip.passageiro_id = 1 AND
ip.itinerario_id not in (
	select ausencia_passageiro.itinerario_id from ausencia_passageiro
	where ausencia_passageiro.data = '2020-04-14'
	AND ausencia_passageiro.passageiro_id = 1
) AND
ip.itinerario_id in (
	select dia_has_itinerario.itinerario_id from dia_has_itinerario
	where dia_has_itinerario.dia_id = 2
)
group by ip.itinerario_id;

/* itinerario ativo */
select ii.ativo, it.turno, it.descricao
from itinerario_iniciado as ii
inner join itinerario as it
on ii.itinerario_id = it.id
where ii.itinerario_id = 1 AND
ii.dia_id = 2 AND
ii.data BETWEEN '2020-04-14 00:00:00'
AND '2020-04-14 23:59:00';

/* localizacao motorista */
select lm.latitude, lm.longitude
from localizacao_motorista as lm
where lm.itinerario_iniciado_id = 3
order by lm.id desc limit 1;
