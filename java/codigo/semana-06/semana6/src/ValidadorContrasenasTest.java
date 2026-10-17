import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

/**
 * Pruebas unitarias para ValidadorContrasenas.
 * SIGETIC: generadas en la etapa ADS a partir de criterios de aceptación.
 *
 * Criterios de aceptación de la HU:
 *   - La contraseña debe tener al menos 8 caracteres
 *   - La contraseña debe tener al menos una letra mayúscula
 */
class ValidadorContrasenasTest {

    @Test
    void contrasenaValida_contrasenaCorrecta_retornaTrue() {
        assertTrue(ValidadorContrasenas.contrasenaValida("Segura123"));
    }

    @Test
    void contrasenaValida_soloBajasOchars_retornaFalse() {
        assertFalse(ValidadorContrasenas.contrasenaValida("sinmayus1"));
    }

    @Test
    void contrasenaValida_menosDe8Caracteres_retornaFalse() {
        assertFalse(ValidadorContrasenas.contrasenaValida("Abc12"));
    }

    @Test
    void contrasenaValida_exactamenteOchoConMayuscula_retornaTrue() {
        assertTrue(ValidadorContrasenas.contrasenaValida("Abcde123"));
    }

    @Test
    void contrasenaValida_soloMayusculas_retornaTrue() {
        assertTrue(ValidadorContrasenas.contrasenaValida("CONTRASE"));
    }

    @Test
    void contrasenaValida_cadenaVacia_retornaFalse() {
        assertFalse(ValidadorContrasenas.contrasenaValida(""));
    }

    @Test
    void contrasenaValida_mayusculaAlFinal_retornaTrue() {
        // La letra mayúscula puede estar en cualquier posición
        assertTrue(ValidadorContrasenas.contrasenaValida("minusc1A"));
    }
}
