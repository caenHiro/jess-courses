import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

/**
 * Pruebas unitarias para CalculadoraConMetodos.
 * SIGETIC: generadas en la etapa ADS a partir de criterios de aceptación.
 *
 * Para ejecutar en Eclipse:
 *   Click derecho en este archivo → Run As → JUnit Test
 *   (Requiere JUnit 5 en el build path del proyecto)
 */
class CalculadoraConMetodosTest {

    // ─── sumar ───────────────────────────────────────────────────────────────

    @Test
    void sumar_dosPositivos_retornaSuma() {
        assertEquals(8.0, CalculadoraConMetodos.sumar(3.0, 5.0));
    }

    @Test
    void sumar_positicoYNegativo_retornaDiferencia() {
        assertEquals(2.0, CalculadoraConMetodos.sumar(5.0, -3.0));
    }

    @Test
    void sumar_dosNegativos_retornaNegatvo() {
        assertEquals(-8.0, CalculadoraConMetodos.sumar(-3.0, -5.0));
    }

    @Test
    void sumar_conCero_retornaMismoNumero() {
        assertEquals(7.5, CalculadoraConMetodos.sumar(7.5, 0.0));
    }

    // ─── resta ───────────────────────────────────────────────────────────────

    @Test
    void resta_mayorMenorNumero_retornaPositivo() {
        assertEquals(3.0, CalculadoraConMetodos.resta(8.0, 5.0));
    }

    @Test
    void resta_menorMayorNumero_retornaNegatvo() {
        assertEquals(-3.0, CalculadoraConMetodos.resta(5.0, 8.0));
    }

    @Test
    void resta_mismoNumero_retornaCero() {
        assertEquals(0.0, CalculadoraConMetodos.resta(4.0, 4.0));
    }

    // ─── multiplicacion ──────────────────────────────────────────────────────

    @Test
    void multiplicacion_dosPositivos_retornaProducto() {
        assertEquals(15.0, CalculadoraConMetodos.multiplicion(3.0, 5.0));
    }

    @Test
    void multiplicacion_porCero_retornaCero() {
        assertEquals(0.0, CalculadoraConMetodos.multiplicion(99.0, 0.0));
    }

    @Test
    void multiplicacion_negativoYPositivo_retornaNegatvo() {
        assertEquals(-10.0, CalculadoraConMetodos.multiplicion(-2.0, 5.0));
    }

    // ─── division ────────────────────────────────────────────────────────────

    @Test
    void division_numerosNormales_retornaCociente() {
        assertEquals(4.0, CalculadoraConMetodos.division(20.0, 5.0));
    }

    @Test
    void division_entresCero_retornaCero() {
        // Comportamiento actual: devuelve 0 cuando b=0 (no lanza excepción)
        assertEquals(0.0, CalculadoraConMetodos.division(10.0, 0.0));
    }

    @Test
    void division_resultadoDecimal_retornaDoble() {
        assertEquals(2.5, CalculadoraConMetodos.division(5.0, 2.0));
    }
}
