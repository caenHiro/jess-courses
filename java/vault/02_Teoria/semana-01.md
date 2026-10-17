---
semana: 1
tema: Variables y tipos de datos
estado: en-progreso
---

# Semana 1 — ¿Qué es programar? Variables y tipos de datos

> Tiempo estimado: 3–4 horas repartidas en la semana
> Cuando termines, sube tu código con: `bash scripts/push.sh "semana-01 variables"`

---

## Antes de empezar

Instala las herramientas si aún no lo has hecho:
- Ver: [[01_Instalacion/01_Java]]
- Ver: [[01_Instalacion/02_VSCode]]

---

## ¿Qué es un programa?

Imagina que le explicas a alguien que nunca ha cocinado cómo hacer un café:
1. Pon agua a calentar
2. Cuando hierva, agrega el café
3. Revuelve 10 veces
4. Sirve en una taza

Eso es un **algoritmo** — instrucciones paso a paso para lograr algo. Un programa es exactamente eso, pero escrito en un lenguaje que la computadora entiende.

Java es uno de esos lenguajes.

---

## Tu primer programa

Crea una carpeta `codigo/semana-01/` y dentro un archivo `HolaMundo.java`:

```java
public class HolaMundo {
    public static void main(String[] args) {
        System.out.println("Hola, me llamo Jess!");
    }
}
```

Para ejecutarlo en VS Code: click derecho → "Run Java".

**Regla importante:** el nombre del archivo (`HolaMundo.java`) debe ser IGUAL al nombre que está después de `class` (`HolaMundo`). Java es muy sensible a esto.

---

## Variables — cajas con nombre

Una **variable** es como una caja con etiqueta. Dentro guardas un valor, y cada vez que necesitas ese valor, solo dices el nombre de la caja.

```java
int edad = 25;
```

Esto le dice a Java: "crea una caja llamada `edad`, que guarda un número entero, y pon `25` adentro".

---

## Tipos de datos — ¿por qué existen?

La computadora necesita saber QUÉ tipo de cosa estás guardando. No es lo mismo guardar el número `25` que guardar el texto `"25"`. Son cosas distintas para Java.

### Los tipos principales

| Tipo | Qué guarda | Ejemplo |
|------|-----------|---------|
| `int` | Número entero (sin decimales) | `int meses = 12;` |
| `double` | Número con decimales | `double precio = 99.50;` |
| `String` | Texto | `String nombre = "Jess";` |
| `boolean` | Solo `true` o `false` | `boolean activo = true;` |

---

## Por qué String usa comillas y los números no

Esta es una de las preguntas más importantes de esta semana.

Cuando escribes:
```java
int edad = 25;
```
El `25` es un **número de verdad**. La computadora lo trata como valor matemático. Con él puedes sumar, restar, multiplicar.

Cuando escribes:
```java
String nombre = "Jess";
```
Las comillas le dicen a Java: *"todo lo que está entre estas comillas es texto, no lo trates como número ni como instrucción"*.

**¿Por qué importa?**

Mira qué pasa si quitas las comillas:
```java
String nombre = Jess;   // ERROR — Java busca una variable llamada Jess que no existe
```

Y si pones un número entre comillas:
```java
String cosa = "25";     // esto es el TEXTO "25", no el número 25
int numero = 25;        // esto es el NÚMERO 25

// No puedes sumarlos directamente porque son tipos distintos
```

**Regla simple:** Si es texto que quieres mostrar o guardar como palabras → va entre comillas. Si es un número con el que vas a hacer cálculos → sin comillas.

---

## Imprimir en pantalla

Java tiene dos maneras de mostrar cosas:

```java
System.out.print("Hola");    // imprime el texto y el cursor queda al final, en la misma línea
System.out.println("Hola");  // imprime el texto y baja a la siguiente línea
```

### ¿Qué es un "salto de línea"?

Cuando presionas **Enter** en Word o en cualquier editor, el texto sigue en la línea de abajo. Eso se llama **salto de línea**.

En la pantalla de la computadora pasa lo mismo. `println` hace ese "Enter" automáticamente al terminar. `print` no lo hace.

**Ejemplo para verlo claro:**

```java
System.out.print("Uno");
System.out.print("Dos");
System.out.print("Tres");
```

Resultado en pantalla:
```
UnoDosTres
```

Todo junto en la misma línea porque `print` no baja.

```java
System.out.println("Uno");
System.out.println("Dos");
System.out.println("Tres");
```

Resultado en pantalla:
```
Uno
Dos
Tres
```

Cada uno en su propia línea porque `println` baja después de imprimir.

---

### El carácter especial `\n`

Hay una tercera opción: puedes poner el salto de línea TÚ MISMO dentro del texto, usando `\n`.

`\n` es una instrucción que significa literalmente "baja de línea aquí". Las dos letras juntas (`\` y `n`) son un código especial que Java entiende como salto.

```java
System.out.print("Uno\nDos\nTres");
```

Resultado en pantalla:
```
Uno
Dos
Tres
```

**¿Cuándo usas `\n` y cuándo `println`?**

Usa `println` cuando cada cosa que imprimes va en su propia línea.

Usa `\n` cuando quieres controlar exactamente dónde va cada salto dentro de un mismo texto largo:

```java
System.out.println("Nombre: Jess\nEdad: 22\nCiudad: Guadalajara");
```

Resultado:
```
Nombre: Jess
Edad: 22
Ciudad: Guadalajara
```

---

## Mezclar texto y variables al imprimir

Puedes combinar texto fijo con el valor de una variable usando `+`:

```java
String nombre = "Jess";
int edad = 22;
System.out.println("Me llamo " + nombre + " y tengo " + edad + " años.");
```

Resultado:
```
Me llamo Jess y tengo 22 años.
```

El `+` aquí no es suma matemática — es "pegar" texto con variables.

---

## Operaciones matemáticas

```java
int a = 10;
int b = 3;

System.out.println(a + b);  // Suma: 13
System.out.println(a - b);  // Resta: 7
System.out.println(a * b);  // Multiplicación: 30
System.out.println(a / b);  // División: 3  (¡ojo! solo da entero porque ambos son int)
System.out.println(a % b);  // Residuo: 1   (lo que sobra de dividir 10 entre 3)
```

> Si necesitas decimales en la división, usa `double`:
> ```java
> double resultado = 10.0 / 3;   // resultado = 3.333...
> ```

---

## Reglas para nombrar variables

- Solo letras, números y guion bajo
- No pueden empezar con número (`1edad` da error, `edad1` sí está bien)
- Sin espacios (`mi edad` da error, `miEdad` sí está bien)
- Sin acentos ni ñ (`número` puede causar problemas, usa `numero`)
- Usa nombres descriptivos: `precioTotal` en lugar de `p`

---

## Errores frecuentes (no te asustes, le pasan a todos)

- **Olvidar el `;`** al final de cada línea — Java lo necesita en casi todas las líneas
- **El texto sin comillas:** `"Jess"` no es lo mismo que `Jess`. Sin comillas Java cree que es el nombre de una variable
- **El nombre del archivo no coincide con el nombre de la clase** — deben ser exactamente iguales
- **Usar `=` para comparar** — en Java `=` asigna un valor. Para comparar se usa `==`

---

## Resumen de la semana

- Un programa es una lista de instrucciones paso a paso
- Las variables son cajas con nombre donde guardas valores
- `int` es para números enteros, `double` para decimales, `String` para texto, `boolean` para verdadero/falso
- Los `String` van entre comillas porque son texto — los números no llevan comillas porque son valores matemáticos
- `println` imprime y baja a la siguiente línea; `print` imprime sin bajar
- `\n` dentro de un texto es un salto de línea manual

---

## Siguiente paso

Cuando sientas que entendiste esto, ve a la nota de práctica:
[[03_Practicas/semana-01]]
