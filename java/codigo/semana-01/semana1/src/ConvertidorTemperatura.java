public class ConvertidorTemperatura {
    public static void main(String[] args) throws Exception {
        //fahrenheit = (celsius × 9 / 5) + 32
        //Variables
        double celcius = 37;
        double fahrenheit = ( (celcius * 9 ) / 5 ) + 32;
        
        //Imprime resultado - Imprima el resultado como: `37.0 °C = 98.6 °F`
        System.out.println(celcius + "°C = " + fahrenheit + "°F" );
    }

}
