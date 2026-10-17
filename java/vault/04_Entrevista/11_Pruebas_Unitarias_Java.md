---
tags: [pruebas-unitarias, junit, testing, sigetic, ads, java]
fecha: 2026-07-29
tipo: guia_examen
---

# Pruebas Unitarias en Java — Contexto SIGETIC/INE

> Tema del examen: las pruebas unitarias se **definen en la etapa ADS** del SIGETIC y se **ejecutan en la etapa de Pruebas**.
> Ver también: [[10_SIGETIC_HU]] · [[09_Examen_Contenido_22Abril]]

---

## ¿Qué es una prueba unitaria?

Una **prueba unitaria** verifica que un fragmento pequeño de código (una función/método) hace exactamente lo que debe hacer, de forma aislada del resto del sistema.

**Analogía:** Como revisar que cada pieza de un reloj funciona sola antes de armar el reloj completo.

---

## En el contexto SIGETIC

| Etapa SIGETIC | Rol de las pruebas unitarias |
|---|---|
| **ADS** | Se definen los **casos de prueba** — qué se probará y cuál es el resultado esperado |
| **Desarrollo** | El desarrollador escribe el código Y las pruebas automáticas (JUnit) |
| **Pruebas** | QA ejecuta las pruebas, documenta resultados, firma el reporte |
| **Despliegue** | Las pruebas se ejecutan como gate — si fallan, no se despliega |

---

## JUnit 5 — La librería estándar

JUnit es el framework de pruebas unitarias para Java. El INE usa Java EE, por lo que JUnit 4 o 5 son los más comunes.

### Ejemplo básico

```java
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

class CalculadoraTest {

    @Test
    void suma_dosNumeros_retornaResultado() {
        // Arrange — preparar datos
        Calculadora calc = new Calculadora();

        // Act — ejecutar la acción
        int resultado = calc.sumar(3, 5);

        // Assert — verificar el resultado
        assertEquals(8, resultado);
    }
}
```

### Patrón AAA (Arrange – Act – Assert)

Toda prueba unitaria bien escrita sigue este patrón:

```java
@Test
void nombreDelMetodo_escenario_resultadoEsperado() {
    // Arrange — ¿qué necesito para la prueba?
    // Act — ¿qué ejecuto?
    // Assert — ¿qué verifico?
}
```

---

## Anotaciones JUnit 5 que debes conocer

| Anotación | Para qué sirve |
|---|---|
| `@Test` | Marca el método como prueba |
| `@BeforeEach` | Ejecuta antes de cada prueba (setup) |
| `@AfterEach` | Ejecuta después de cada prueba (cleanup) |
| `@BeforeAll` | Ejecuta una vez antes de todas las pruebas |
| `@AfterAll` | Ejecuta una vez después de todas las pruebas |
| `@DisplayName("...")` | Nombre descriptivo para reportes |
| `@Disabled` | Desactiva una prueba temporalmente |

---

## Assertions más usadas

```java
assertEquals(esperado, actual);           // ¿son iguales?
assertNotEquals(noEsperado, actual);      // ¿son distintos?
assertTrue(condicion);                    // ¿es verdadero?
assertFalse(condicion);                   // ¿es falso?
assertNull(objeto);                       // ¿es null?
assertNotNull(objeto);                    // ¿no es null?
assertThrows(Excepcion.class, () -> {     // ¿lanza la excepción esperada?
    codigo.queDeberiaFallar();
});
```

---

## Ejemplo completo — clase del INE

```java
// Clase a probar
public class ValidadorActas {

    public boolean esVotoValido(int votosCandidato, int totalVotantes) {
        if (votosCandidato < 0) return false;
        if (votosCandidato > totalVotantes) return false;
        return true;
    }
}
```

```java
// Pruebas unitarias
import org.junit.jupiter.api.*;
import static org.junit.jupiter.api.Assertions.*;

class ValidadorActasTest {

    private ValidadorActas validador;

    @BeforeEach
    void setUp() {
        validador = new ValidadorActas();
    }

    @Test
    @DisplayName("Voto válido cuando candidato tiene votos dentro del total")
    void esVotoValido_votosPermitidos_retornaTrue() {
        assertTrue(validador.esVotoValido(100, 500));
    }

    @Test
    @DisplayName("Voto inválido cuando candidato supera el total de votantes")
    void esVotoValido_candidatoSuperaTotal_retornaFalse() {
        assertFalse(validador.esVotoValido(600, 500));
    }

    @Test
    @DisplayName("Voto inválido cuando candidato tiene votos negativos")
    void esVotoValido_votosNegativos_retornaFalse() {
        assertFalse(validador.esVotoValido(-1, 500));
    }

    @Test
    @DisplayName("Voto válido cuando candidato tiene exactamente el total de votos")
    void esVotoValido_candidatoIgualTotal_retornaTrue() {
        assertTrue(validador.esVotoValido(500, 500));
    }
}
```

---

## Buenas prácticas de pruebas unitarias

1. **Una prueba = una sola cosa** — cada `@Test` verifica un único comportamiento
2. **Nombre descriptivo** — `metodo_escenario_resultadoEsperado`
3. **Independientes** — una prueba no depende del resultado de otra
4. **Rápidas** — no conectan a BD real ni a servicios externos
5. **Deterministas** — siempre dan el mismo resultado con los mismos datos
6. **Sin estado compartido** — usar `@BeforeEach` para reiniciar el estado

---

## Casos de prueba desde los criterios de aceptación

Las HUs definen los criterios de aceptación → los criterios se convierten en casos de prueba:

```
HU-001: Captura de votos
Criterio: La suma de votos no exceda el total de votantes

→ Prueba 1: 100 votos con 500 total → válido
→ Prueba 2: 600 votos con 500 total → inválido
→ Prueba 3: votos negativos → inválido
→ Prueba 4: exactamente el total → válido (caso límite)
```

Los **casos límite** (0, máximo, -1) son los más importantes — son donde suelen estar los bugs.

---

## Preguntas del examen

**¿En qué etapa del SIGETIC se generan las pruebas unitarias?**
> En la etapa de **ADS** — se definen los casos de prueba a partir de los criterios de aceptación de las Historias de Usuario.

**¿Qué diferencia hay entre prueba unitaria y prueba de integración?**
> Unitaria: prueba un método/clase en aislamiento. Integración: prueba varios componentes juntos (ej. clase + base de datos + servicio externo).

**¿Qué es `@BeforeEach`?**
> Código que se ejecuta antes de cada prueba individual. Se usa para preparar el estado inicial (crear objetos, datos de prueba) de forma limpia.

**¿Por qué las pruebas unitarias no deben conectarse a la BD real?**
> Para ser rápidas, predecibles y no depender del estado de la base de datos. Se usan objetos simulados (mocks) o datos en memoria.
