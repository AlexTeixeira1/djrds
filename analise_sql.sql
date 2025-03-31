-- 1
```sql
SELECT COUNT(DISTINCT id_chamado) AS total_chamados
FROM `datario.adm_central_atendimento_1746.chamado`
WHERE DATE(data_inicio) = '2023-04-01';
```
-- 1903

-- 2
```sql
SELECT id_tipo, COUNT(*) AS total
FROM `datario.adm_central_atendimento_1746.chamado`
WHERE DATE(data_inicio) = '2023-04-01'
GROUP BY id_tipo
ORDER BY total DESC
LIMIT 1;
```
--782  | 373

-- Para confirmar, vemos se temos o mesmo resultado com a busca pelo id_tipo e tipo:
```sql
SELECT tipo, COUNT(*) AS total
FROM `datario.adm_central_atendimento_1746.chamado`
WHERE DATE(data_inicio) = '2023-04-01'
GROUP BY tipo
ORDER BY total DESC
LIMIT 1;
```
--Estacionamento irregular | 373

-- 3
```sql
SELECT b.nome AS bairro, COUNT(*) AS total
FROM `datario.adm_central_atendimento_1746.chamado` c
JOIN `datario.dados_mestres.bairro` b ON c.id_bairro = b.id_bairro
WHERE DATE(c.data_inicio) = '2023-04-01'
GROUP BY b.nome
ORDER BY total DESC
LIMIT 3;
```
-- 1	 Campo Grande | 124
-- 2	 Tijuca | 96
-- 3	 Barra da Tijuca | 60

-- 4
```sql
SELECT b.nome AS subprefeitura, COUNT(*) AS total
FROM `datario.adm_central_atendimento_1746.chamado` c
JOIN `datario.dados_mestres.bairro` b ON c.id_bairro = b.id_bairro
WHERE DATE(c.data_inicio) = '2023-04-01'
GROUP BY b.nome
ORDER BY total DESC
LIMIT 1;
```
-- Campo Grande | 124

-- 5
```sql
SELECT COUNT(*) AS chamados_sem_associacao
FROM `datario.adm_central_atendimento_1746.chamado`
WHERE DATE(data_inicio) = '2023-04-01'
  AND (id_bairro IS NULL OR id_territorialidade IS NULL);
```
-- 131

-- 6
```sql
SELECT COUNT(*) AS total_chamados
FROM `datario.adm_central_atendimento_1746.chamado`
WHERE id_subtipo = "5071"
  --Aqui podemos aproveitar que a tabela está particionada, substituindo:
  --AND DATE(data_inicio) BETWEEN '2022-01-01' AND '2024-12-31'
  AND DATE(data_particao) BETWEEN '2022-01-01' AND '2024-12-31';
```
-- 56785

-- 7
```sql
WITH eventos AS (
  -- Eventos adicionados manualmente
  SELECT 'Rock in Rio' AS evento, DATE '2024-09-13' AS data_inicial, DATE '2024-09-15' AS data_final UNION ALL
  SELECT 'Rock in Rio', DATE '2024-09-19', DATE '2024-09-22' UNION ALL
  SELECT 'Réveillon', DATE '2024-12-29', DATE '2025-01-01' UNION ALL

  -- Eventos da tabela oficial
  SELECT evento, data_inicial, data_final
  FROM `datario.turismo_fluxo_visitantes.rede_hoteleira_ocupacao_eventos`
  WHERE evento IN ('Reveillon', 'Carnaval', 'Rock in Rio')
    AND data_inicial IS NOT NULL AND data_final IS NOT NULL
)

SELECT c.*
FROM `datario.adm_central_atendimento_1746.chamado` c
JOIN eventos e
  ON DATE(c.data_inicio) BETWEEN e.data_inicial AND e.data_final
WHERE c.id_subtipo = "5071"
  AND DATE(c.data_inicio) BETWEEN '2022-01-01' AND '2024-12-31';

```

-- 1331

-- 8
```sql
WITH eventos AS (
  -- Eventos adicionados manualmente
  SELECT 'Rock in Rio' AS evento, DATE '2024-09-13' AS data_inicial, DATE '2024-09-15' AS data_final UNION ALL
  SELECT 'Rock in Rio', DATE '2024-09-19', DATE '2024-09-22' UNION ALL
  SELECT 'Réveillon', DATE '2024-12-29', DATE '2025-01-01' UNION ALL

  -- Eventos da tabela oficial
  SELECT evento, data_inicial, data_final
  FROM `datario.turismo_fluxo_visitantes.rede_hoteleira_ocupacao_eventos`
  WHERE evento IN ('Reveillon', 'Carnaval', 'Rock in Rio')
    AND data_inicial IS NOT NULL AND data_final IS NOT NULL
)

SELECT e.evento, COUNT(*) AS total_chamados
FROM `datario.adm_central_atendimento_1746.chamado` c
JOIN eventos e
  ON DATE(c.data_inicio) BETWEEN e.data_inicial AND e.data_final
WHERE c.id_subtipo = "5071"
  AND DATE(c.data_inicio) BETWEEN '2022-01-01' AND '2024-12-31'
GROUP BY e.evento;
```
-- 1	 Rock in Rio | 946
-- 2	 Carnaval | 252
-- 3	Réveillon |133


-- 9
```sql
WITH eventos AS (
  -- Eventos adicionados manualmente
  SELECT 'Rock in Rio' AS evento, DATE '2024-09-13' AS data_inicial, DATE '2024-09-15' AS data_final UNION ALL
  SELECT 'Rock in Rio', DATE '2024-09-19', DATE '2024-09-22' UNION ALL
  SELECT 'Réveillon', DATE '2024-12-29', DATE '2025-01-01' UNION ALL

  -- Eventos da tabela oficial
  SELECT evento, data_inicial, data_final
  FROM `datario.turismo_fluxo_visitantes.rede_hoteleira_ocupacao_eventos`
  WHERE evento IN ('Reveillon', 'Carnaval', 'Rock in Rio')
    AND data_inicial IS NOT NULL AND data_final IS NOT NULL
)

SELECT e.evento, COUNT(*) / (DATE_DIFF(e.data_final, e.data_inicial, DAY) + 1) AS media_diaria
FROM `datario.adm_central_atendimento_1746.chamado` c
JOIN eventos e
  ON DATE(c.data_inicio) BETWEEN e.data_inicial AND e.data_final
WHERE c.id_subtipo = "5071"
  AND DATE(c.data_inicio) BETWEEN '2022-01-01' AND '2024-12-31'
GROUP BY e.evento, e.data_inicial, e.data_final
ORDER BY media_diaria DESC
LIMIT 1;
--remover limite para ver os demais
```
-- Rock in Rio | 137.5

-- 10
```sql
-- Use a query da questão anterior para ver as medias dos eventos
WITH geral_chamados AS (
  SELECT COUNT(*) AS total, 
         DATE_DIFF(DATE '2024-12-31', DATE '2022-01-01',DAY) + 1 AS dias
  FROM `datario.adm_central_atendimento_1746.chamado`
  WHERE id_subtipo = "5071"
    AND DATE(data_inicio) BETWEEN '2022-01-01' AND '2024-12-31'
)

SELECT 
  total / dias AS media_diaria
FROM geral_chamados;
```

 -- Rock in Rio | 137.5
 -- Carnaval | 63.0
 -- Réveillon | 33.25
 -- Geral | 51.8
