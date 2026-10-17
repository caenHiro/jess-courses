import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

/**
 * Pruebas unitarias para CuentaBancaria.
 * SIGETIC: generadas en la etapa ADS a partir de criterios de aceptación.
 *
 * Criterios de aceptación de la HU:
 *   - Al depositar una cantidad positiva, el saldo aumenta correctamente
 *   - Al retirar una cantidad menor al saldo, el saldo disminuye correctamente
 *   - Si se intenta retirar más de lo disponible, el saldo no cambia
 *   - El saldo inicial negativo se convierte a 0 automáticamente
 *
 * Patrón: Arrange – Act – Assert (AAA)
 */
class CuentaBancariaTest {

    private CuentaBancaria cuenta;

    @BeforeEach
    void setUp() {
        // Arrange: cuenta fresca antes de cada prueba
        cuenta = new CuentaBancaria("Jess", 1000.0, "001-JESS");
    }

    // ─── depositar ───────────────────────────────────────────────────────────

    @Test
    void depositar_cantidadPositiva_saldoAumenta() {
        // Act
        cuenta.depositar(500.0);
        // Assert
        assertEquals(1500.0, cuenta.getSaldo());
    }

    @Test
    void depositar_cantidadCero_saldoNoCambia() {
        // La condición es: if(cantidad > 0) — cero NO pasa
        cuenta.depositar(0.0);
        assertEquals(1000.0, cuenta.getSaldo());
    }

    @Test
    void depositar_cantidadNegativa_saldoNoCambia() {
        cuenta.depositar(-200.0);
        assertEquals(1000.0, cuenta.getSaldo());
    }

    @Test
    void depositar_variosDepositos_saldoAcumula() {
        cuenta.depositar(100.0);
        cuenta.depositar(200.0);
        cuenta.depositar(300.0);
        assertEquals(1600.0, cuenta.getSaldo());
    }

    // ─── retirar ─────────────────────────────────────────────────────────────

    @Test
    void retirar_cantidadMenorAlSaldo_saldoDisminuye() {
        cuenta.retirar(300.0);
        assertEquals(700.0, cuenta.getSaldo());
    }

    @Test
    void retirar_cantidadIgualAlSaldo_saldoQuedaEnCero() {
        cuenta.retirar(1000.0);
        assertEquals(0.0, cuenta.getSaldo());
    }

    @Test
    void retirar_cantidadMayorAlSaldo_saldoNoCambia() {
        cuenta.retirar(5000.0);
        assertEquals(1000.0, cuenta.getSaldo());
    }

    // ─── constructor ─────────────────────────────────────────────────────────

    @Test
    void constructor_saldoNegativo_inicializaEnCero() {
        CuentaBancaria cuentaNegativa = new CuentaBancaria("Test", -500.0, "002-TEST");
        assertEquals(0.0, cuentaNegativa.getSaldo());
    }

    @Test
    void constructor_saldoCero_inicializaEnCero() {
        CuentaBancaria cuentaVacia = new CuentaBancaria("Test", 0.0, "003-TEST");
        assertEquals(0.0, cuentaVacia.getSaldo());
    }
}
