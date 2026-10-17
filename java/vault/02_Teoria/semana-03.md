---
semana: 3
tema: Condicionales
estado: pendiente
---

# Semana 3 — Condicionales: if / else / switch

> Tiempo estimado: 3–4 horas
> Al terminar: `bash scripts/push.sh "semana-03 condicionales"`

---

## Tomar decisiones en el código

En la vida real tomamos decisiones todo el tiempo:
- **Si** llueve → llevo paraguas
- **Si no**, pero hace frío → llevo chamarra
- **Si no** pasa ninguna → salgo con playera

En Java hacemos lo mismo con `if`, `else if`, y `else`.

---

## Estructura básica

```java
if (condicion) {
    // esto se ejecuta si la condicion es VERDADERA
} else {
    // esto se ejecuta si la condicion es FALSA
}
```

Ejemplo real:

```java
int edad = 17;

if (edad >= 18) {
    System.out.println("Eres mayor de edad.");
} else {
    System.out.println("Eres menor de edad.");
}
```

---

## Múltiples opciones con else if

Cuando hay más de dos posibilidades:

```java
int calificacion = 85;

if (calificacion >= 90) {
    System.out.println("Excelente");
} else if (calificacion >= 80) {
    System.out.println("Muy bien");
} else if (calificacion >= 70) {
    System.out.println("Bien");
} else {
    System.out.println("Reprobado");
}
```

Java revisa las condiciones de arriba hacia abajo y ejecuta el **primer bloque** donde la condición sea verdadera. Los demás se ignoran.

---

## Condiciones compuestas

Puedes combinar condiciones:

```java
int edad = 20;
boolean tieneID = true;

// Las DOS deben ser verdaderas
if (edad >= 18 && tieneID) {
    System.out.println("Puede entrar");
}

// Al menos UNA debe ser verdadera
int dia = 7;
if (dia == 6 || dia == 7) {
    System.out.println("Es fin de semana");
}
```

---

## Switch — para menús y opciones fijas

Cuando tienes muchos casos con valores exactos, `switch` es más legible que muchos `else if`:

```java
int opcion = 2;

switch (opcion) {
    case 1:
        System.out.println("Opción 1 seleccionada");
        break;
    case 2:
        System.out.println("Opción 2 seleccionada");
        break;
    case 3:
        System.out.println("Opción 3 seleccionada");
        break;
    default:
        System.out.println("Opción no válida");
}
```

**Importante:** el `break` le dice a Java "salir del switch". Sin él, seguiría ejecutando todos los casos siguientes.

---

## A recordar

- `if` ejecuta código solo si la condición es verdadera
- `else` es el "si no" — lo que pasa cuando `if` es falso
- `else if` agrega más opciones en el medio
- `switch` es para comparar una variable contra valores exactos
- `&&` = "Y" (ambas deben ser true), `||` = "O" (al menos una)

---

## Siguiente paso

[[03_Practicas/semana-03]]
