# Value Objects Package

Una librería robusta para Flutter y Dart orientada al **Domain-Driven Design (DDD)** y la **Programación Funcional**. 

Este paquete proporciona una colección completa de **Value Objects** (Objetos de Valor) inmutables para manejar reglas de negocio, validaciones complejas y formato de datos sin contaminar tu interfaz de usuario o la lógica de tu aplicación.

Construido sobre [`fpdart`](https://pub.dev/packages/fpdart), garantiza un manejo de errores fuertemente tipado (Type-Safe) sin recurrir a excepciones (Exceptions) utilizando el patrón `Either`.

---

## 🌟 Características Principales

- **Inmutabilidad Absoluta:** Todos los Value Objects son `const` y `final`.
- **Validación Transparente:** La validación ocurre en el momento de la instanciación. Es imposible crear un Value Object en un "estado inválido" no controlado.
- **Programación Funcional:** Usa `Either` y `Option` para flujos predecibles. Funciones de alto nivel (Top-Level) componibles mediante `.flatMap()`.
- **Integración Perfecta con Flutter:** Métodos de conveniencia (`validate()`, `orEmpty`) diseñados específicamente para trabajar con `TextFormField` y constructores de UI.
- **Múltiples Dominios Cubiertos:**
  - **Texto & Identidad:** Emails, Passwords, Nombres, URLs.
  - **Números:** Decimales, Enteros Positivos, Porcentajes.
  - **Finanzas:** Dinero (Money), ROI, DTI, Credit Scores.
  - **Propiedades (Real Estate):** Pies Cuadrados (SqFt), Acres, Año de Construcción.
  - **Medidas:** Fechas, Distancias, Duraciones.
  - **Colecciones:** Listas no vacías, Listas únicas.

---

## 🚀 Instalación

Agrega el paquete a tu archivo `pubspec.yaml`:

```yaml
dependencies:
  value_objects_pkg:
    path: ./ruta/hacia/tu/paquete/value_objects_pkg
```

## 🛠️ Uso Básico

Crear un Value Object es tan simple como instanciar su clase. La validación se ejecutará automáticamente.

```dart
import 'package:value_objects_pkg/value_objects_pkg.dart';

void main() {
  // 1. Creación exitosa
  final email = ValueEmailAddress('usuario@ejemplo.com');
  print(email.isValid); // true

  // 2. Creación con error de validación
  final badPassword = ValuePassword('1234');
  print(badPassword.isValid); // false
  
  // 3. Obtener el mensaje de error amigable
  print(badPassword.validate()); // "Too short (entered 4, minimum is 8)"
}
```

### Extracción de Valores

Nunca accedas directamente a propiedades crudas. Usa los métodos funcionales o de conveniencia que el paquete te ofrece:

```dart
final age = ValuePositiveInt('25');

// Método 1: orCrash (Lanza excepción si es inválido. Úsalo solo cuando estés 100% seguro)
final validAge = age.orCrash; 

// Método 2: orZero / orEmpty (Ideal para inicializar UI o hacer cálculos seguros)
final safeAge = age.orZero;

// Método 3: Fold (Maneja funcionalmente el éxito y el error)
final mensaje = age.value.fold(
  (failure) => 'Error de validación: ${failure.errorMessage}',
  (value) => 'La edad guardada es $value',
);
```

### Validación Personalizada (`customValidate`)

Todos los Value Objects aceptan un parámetro opcional `customValidate` para
inyectar una **regla de negocio propia** además de la validación estructural
incluida, sin necesidad de crear una subclase.

Recibe el `Either<ValueFailure, T>` del objeto y devuelve un mensaje de error
(si la regla falla) o `null` (si pasa). Se ejecuta **antes** que la validación
interna en `validate()`:

```dart
final tags = ValueListNotEmpty<String>(
  inputTags,
  customValidate: (either) => either.fold(
    (failure) => null, // deja hablar al fallo estructural
    (list) => list.contains('banned') ? 'Tag "banned" not allowed' : null,
  ),
);

tags.validate(); // ejecuta la regla personalizada primero, luego la interna

// También funciona en value objects opcionales (recibes el Option):
final required = ValueOptionListNotEmpty<int>(
  null,
  customValidate: (either) => either.fold(
    (_) => null,
    (option) => option.isNone() ? 'A value is required' : null,
  ),
);
```

---

## 📱 Integración con Flutter (Formularios)

El caso de uso más común en Flutter es validar datos dentro de un `TextFormField`. Los objetos de este paquete tienen un método `validate()` que se integra nativamente con la firma requerida por Flutter.

```dart
class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  // Mantén tu estado usando ValueObjects en lugar de simples Strings
  ValueEmailAddress email = ValueEmailAddress('');
  ValuePassword password = ValuePassword('');

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(labelText: 'Correo Electrónico'),
            // Actualiza el ValueObject en tiempo real
            onChanged: (val) => setState(() => email = ValueEmailAddress(val)),
            // Flutter usará el mensaje de error del ValueObject automáticamente
            validator: (_) => email.validate(),
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Contraseña'),
            obscureText: true,
            onChanged: (val) => setState(() => password = ValuePassword(val)),
            validator: (_) => password.validate(),
          ),
          ElevatedButton(
            onPressed: () {
              if (email.isValid && password.isValid) {
                // Enviar datos al backend con total seguridad
                authService.login(email.orCrash, password.orCrash);
              }
            },
            child: const Text('Ingresar'),
          )
        ],
      ),
    );
  }
}
```

---

## 💼 Dominios Especializados

Este paquete brilla por su capacidad de modelar reglas de industrias específicas.

### Finanzas (`value_finance.dart`)
```dart
final income = ValueMoney('5000', symbol: '\$');
final debt = ValueMoney('1500', symbol: '\$');

// Calcula la relación Deuda-Ingreso con validación cruzada segura
final dti = ValueDTI.calculate(debt, income);

print(dti.isExcellent); // true
print(dti.statusMessage); // "Excellent"
```

### Bienes Raíces / Propiedades (`value_property.dart`)
```dart
final acres = ValueAcres('2.5');
print(acres.toSqFt); // 108900.0

final yearBuilt = ValueYearBuilt('1998');
// Valida automáticamente que no sea más antiguo que el año 1000 ni esté en el futuro
```

### Colecciones (`value_collections.dart`)
```dart
final tags = ValueUniqueListNotEmpty(['flutter', 'dart', 'flutter']);

print(tags.isValid); // false
print(tags.validate()); // "Collection have repeat items"
```

---

## 🧩 Uso Avanzado: Creación de Custom Value Objects

Si los Value Objects incluidos no son suficientes, puedes crear los tuyos usando el **Patrón de Funciones Componibles (Top-Level Functions)** incluido en el paquete.

Utiliza `.flatMap()` para encadenar múltiples reglas de validación puras de forma elegante:

```dart
import 'package:fpdart/fpdart.dart';
import 'package:value_objects_pkg/value_objects_pkg.dart';

/// Ejemplo: Un código de producto que debe ser un entero, positivo, y menor a 1000.
class ValueProductCode extends ValueNumeric<int> {
  
  factory ValueProductCode(String input) {
    // 1. Componemos las validaciones encadenando llamadas puras
    final result = parseNumeric<int>(input)
        .flatMap(validatePositive)
        .flatMap((v) => validateMax(v, 999));
        
    // 2. Retornamos la instancia privada
    return ValueProductCode._(result);
  }

  // 3. Definimos un constructor constante privado
  const ValueProductCode._(super.value);
}
```

---

## 🛠 Testing

Gracias a su naturaleza puramente funcional y sin dependencias de estado ocultas, testear estos Value Objects es extremadamente sencillo usando `package:test`:

```dart
test('ValueEmailAddress detects invalid emails', () {
  final invalidEmail = ValueEmailAddress('usuario@sin_dominio');
  expect(invalidEmail.isValid, false);
  expect(invalidEmail.validate(), isNotNull);
});
```

---

## 🤝 Contribución
Si deseas contribuir agregando nuevos ValueObjects de tu industria (Medicina, Logística, etc.), asegúrate de:
1. Usar siempre constructores `const`.
2. Separar las lógicas de validación en funciones "Top-Level" independientes que retornen `Either<ValueFailure, T>`.
3. Utilizar `.flatMap()` para componer dichas validaciones en los `factory`.