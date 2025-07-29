

select * from sym_node_group_link; 

--enrutar la tabla mascota de forma bidireccional
INSERT INTO sym_router (
    router_id, 
    source_node_group_id, 
    target_node_group_id, 
    router_type, 
    create_time, 
    last_update_time
) VALUES
('sucursal1-sucursal2', 'sucursal1-node', 'sucursal2-node', 'default', current_timestamp, current_timestamp),
('sucursal2-sucursal1', 'sucursal2-node', 'sucursal1-node', 'default', current_timestamp, current_timestamp);

INSERT INTO sym_trigger (
    trigger_id, 
    source_table_name, 
    channel_id, 
    sync_on_insert, 
    sync_on_update, 
    sync_on_delete, 
    create_time, 
    last_update_time
) VALUES
('peliculas_trigger', 'peliculas', 'default', 1, 1, 1, current_timestamp, current_timestamp);

INSERT INTO sym_trigger_router (
    trigger_id, 
    router_id, 
    enabled, 
    initial_load_order, 
    create_time, 
    last_update_time
) VALUES
('peliculas_trigger', 'sucursal1-sucursal2', 1, 1, current_timestamp, current_timestamp),
('peliculas_trigger', 'sucursal2-sucursal1', 1, 1, current_timestamp, current_timestamp);


--enrutar la tabla veterinario de forma bidireccional
INSERT INTO sym_trigger (
    trigger_id, 
    source_table_name, 
    channel_id, 
    sync_on_insert, 
    sync_on_update, 
    sync_on_delete, 
    create_time, 
    last_update_time
) VALUES
('clientes_trigger', 'clientes', 'default', 1, 1, 1, current_timestamp, current_timestamp);

INSERT INTO sym_trigger_router (
    trigger_id, 
    router_id, 
    enabled, 
    initial_load_order, 
    create_time, 
    last_update_time
) VALUES
('clientes_trigger', 'sucursal1-sucursal2', 1, 1, current_timestamp, current_timestamp),
('clientes_trigger', 'sucursal2-sucursal1', 1, 1, current_timestamp, current_timestamp);

--enrutar la tabla tratamiento de forma bidireccional
INSERT INTO sym_trigger (
    trigger_id, 
    source_table_name, 
    channel_id, 
    sync_on_insert, 
    sync_on_update, 
    sync_on_delete, 
    create_time, 
    last_update_time
) VALUES
('genero_trigger', 'genero', 'default', 1, 1, 1, current_timestamp, current_timestamp);

INSERT INTO sym_trigger_router (
    trigger_id, 
    router_id, 
    enabled, 
    initial_load_order, 
    create_time, 
    last_update_time
) VALUES
('genero_trigger', 'sucursal1-sucursal2', 1, 1, current_timestamp, current_timestamp),
('genero_trigger', 'sucursal2-sucursal1', 1, 1, current_timestamp, current_timestamp);

--enrutar la tabla tratamiento de forma bidireccional
INSERT INTO sym_trigger (
    trigger_id, 
    source_table_name, 
    channel_id, 
    sync_on_insert, 
    sync_on_update, 
    sync_on_delete, 
    create_time, 
    last_update_time
) VALUES
('alquileres_trigger', 'alquileres', 'default', 1, 1, 1, current_timestamp, current_timestamp);

INSERT INTO sym_trigger_router (
    trigger_id, 
    router_id, 
    enabled, 
    initial_load_order, 
    create_time, 
    last_update_time
) VALUES
('alquileres_trigger', 'sucursal1-sucursal2', 1, 1, current_timestamp, current_timestamp),
('alquileres_trigger', 'sucursal2-sucursal1', 1, 1, current_timestamp, current_timestamp);

--enrutar la tabla tratamiento de forma bidireccional
INSERT INTO sym_trigger (
    trigger_id, 
    source_table_name, 
    channel_id, 
    sync_on_insert, 
    sync_on_update, 
    sync_on_delete, 
    create_time, 
    last_update_time
) VALUES
('empleado_trigger', 'empleado', 'default', 1, 1, 1, current_timestamp, current_timestamp);

INSERT INTO sym_trigger_router (
    trigger_id, 
    router_id, 
    enabled, 
    initial_load_order, 
    create_time, 
    last_update_time
) VALUES
('empleado_trigger', 'sucursal1-sucursal2', 1, 1, current_timestamp, current_timestamp),
('empleado_trigger', 'sucursal2-sucursal1', 1, 1, current_timestamp, current_timestamp);

--enrutar la tabla tratamiento de forma bidireccional
INSERT INTO sym_trigger (
    trigger_id, 
    source_table_name, 
    channel_id, 
    sync_on_insert, 
    sync_on_update, 
    sync_on_delete, 
    create_time, 
    last_update_time
) VALUES
('inventario_trigger', 'inventario', 'default', 1, 1, 1, current_timestamp, current_timestamp);

INSERT INTO sym_trigger_router (
    trigger_id, 
    router_id, 
    enabled, 
    initial_load_order, 
    create_time, 
    last_update_time
) VALUES
('inventario_trigger', 'sucursal1-sucursal2', 1, 1, current_timestamp, current_timestamp),
('inventario_trigger', 'sucursal2-sucursal1', 1, 1, current_timestamp, current_timestamp);

--enrutar la tabla tratamiento de forma bidireccional
INSERT INTO sym_trigger (
    trigger_id, 
    source_table_name, 
    channel_id, 
    sync_on_insert, 
    sync_on_update, 
    sync_on_delete, 
    create_time, 
    last_update_time
) VALUES
('devoluciones_trigger', 'devoluciones', 'default', 1, 1, 1, current_timestamp, current_timestamp);

INSERT INTO sym_trigger_router (
    trigger_id, 
    router_id, 
    enabled, 
    initial_load_order, 
    create_time, 
    last_update_time
) VALUES
('devoluciones_trigger', 'sucursal1-sucursal2', 1, 1, current_timestamp, current_timestamp),
('devoluciones_trigger', 'sucursal2-sucursal1', 1, 1, current_timestamp, current_timestamp);


SELECT m.nombre AS clientes, t.estado AS devoluciones
FROM clientes m
JOIN LATERAL (
	SELECT *
	  FROM dblink(
	    'host=pg-sucursal1 port=5432 dbname=tiendapeliculas user=postgres password=postgres',
	    'SELECT * FROM devoluciones'
	  ) AS t(id UUID, fechaDevolucion timestamp, alquiler_id uuid ,estado VARCHAR)
) t ON true;