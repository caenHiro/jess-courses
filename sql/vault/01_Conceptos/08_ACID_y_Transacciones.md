---
tema: ACID y Transacciones
estado: completo
---

# ACID y Transacciones

> Otro tema que sale casi siempre en entrevistas de base de datos. Hay que saber qué significa cada letra y dar un ejemplo.

---

## ¿Qué es una transacción?

Una transacción es un **conjunto de operaciones SQL que se ejecutan como una unidad**. O todas tienen éxito, o ninguna.

**Ejemplo del mundo real:** una transferencia bancaria.

Cuando transfieres $500 de tu cuenta a la de otra persona:
1. Se restan $500 de tu cuenta
2. Se suman $500 a la cuenta del destinatario

Si ocurre un error después del paso 1 pero antes del paso 2, el banco quedaría con $500 de menos sin que nadie los reciba. Con una transacción, si algo falla, **todo se revierte** como si nada hubiera pasado.

---

## Las 4 propiedades ACID

### A — Atomicidad

**Todo o nada.** Una transacción se completa entera o no se aplica nada.

```sql
START TRANSACTION;
    UPDATE empleados SET salario = salario - 500 WHERE id_empleado = 1;
    UPDATE empleados SET salario = salario + 500 WHERE id_empleado = 2;
COMMIT;
-- Si cualquiera de las dos falla, ambas se revierten
```

### C — Consistencia

La base de datos siempre pasa de **un estado válido a otro estado válido**. Las reglas (constraints, claves foráneas, checks) siempre se respetan.

Ejemplo: si tienes una regla de que el salario no puede ser negativo, una transacción que lo dejara en negativo sería rechazada y la BD quedaría igual que antes.

### I — Aislamiento (Isolation)

Las transacciones que ocurren al mismo tiempo **no se "ven" entre sí** mientras están en proceso. Cada una trabaja como si fuera la única que está corriendo.

Ejemplo: si dos personas hacen una consulta al mismo tiempo mientras otra persona está actualizando datos, esas consultas no van a ver datos a medias — van a ver el estado anterior o el estado final, nunca datos incompletos.

### D — Durabilidad

Una vez que la transacción se confirma (`COMMIT`), los cambios **son permanentes**, aunque el servidor se apague justo después.

MySQL guarda las transacciones en un log (redo log) para poder recuperarlas si hay una falla.

---

## Los comandos de transacciones en MySQL

```sql
-- Iniciar una transacción (también puedes usar BEGIN)
START TRANSACTION;

-- Confirmar (guardar los cambios definitivamente)
COMMIT;

-- Revertir (deshacer todo lo que hiciste desde START TRANSACTION)
ROLLBACK;

-- Punto de control intermedio (puedes revertir hasta aquí sin revertir todo)
SAVEPOINT nombre_punto;
ROLLBACK TO SAVEPOINT nombre_punto;
```

---

## Ejemplo completo con la BD RRHH

Escenario: dar un aumento de salario al empleado 7 (Javier) y registrarlo en el historial.

```sql
START TRANSACTION;

-- Paso 1: actualizar el salario
UPDATE empleados
SET salario = 38000.00
WHERE id_empleado = 7;

-- Paso 2: verificar que el update fue correcto antes de continuar
-- (en la práctica esto lo hace el código de tu aplicación)

-- Si todo está bien:
COMMIT;

-- Si algo salió mal:
-- ROLLBACK;
```

El trigger `trg_historial_salario` registra el cambio automáticamente cuando se hace el UPDATE, y todo eso queda en la misma transacción.

---

## ¿Qué pasa si no usas transacciones?

MySQL tiene por default **`autocommit = ON`**, lo que significa que cada instrucción SQL se confirma automáticamente. Es como si cada `UPDATE` o `INSERT` tuviera su propio `COMMIT`.

Cuando usas `START TRANSACTION`, desactivas el autocommit para esa sesión hasta que hagas `COMMIT` o `ROLLBACK`.

```sql
-- Ver el valor actual
SHOW VARIABLES LIKE 'autocommit';

-- Desactivar para toda la sesión (no recomendado en general)
SET autocommit = 0;
```

---

## Resumen para la entrevista

| Letra | Significa | En una frase |
|---|---|---|
| A | Atomicidad | Todo o nada |
| C | Consistencia | La BD siempre queda en estado válido |
| I | Aislamiento | Las transacciones paralelas no se interfieren |
| D | Durabilidad | Lo que se commitió, se queda aunque haya falla |

**Pregunta típica:** *"¿Qué significa ACID?"*
**Respuesta:** Explicar cada letra con una frase y dar el ejemplo de la transferencia bancaria. Siempre funciona.
