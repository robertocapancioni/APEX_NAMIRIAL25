create or replace view d05_vendita_vw as
select v.id,
       v.cliente_id,
       c.cliente,
       v.prodotto_id,
       p.prodotto,
       p.tipo_prodotto_id,
       tp.tipo_prodotto,
       v.data,
       v.quantita,
       p.prezzo_vendita*v.quantita as importo
  from d05_vendita v
  join d05_cliente c        on v.cliente_id       = c.id
  join d05_prodotto p       on v.prodotto_id      = p.id
  join d05_tipo_prodotto tp on p.tipo_prodotto_id = tp.id;
