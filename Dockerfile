# Etapa 1: Compilación
FROM ghcr.io/cirruslabs/flutter:3.24.0 AS builder

# Configurar el directorio de trabajo
WORKDIR /app

# Copiar el código fuente al contenedor
COPY . .

# Crear un usuario no root
RUN adduser -u 1001 --disabled-password --gecos "" flutteruser && \
    chown -R flutteruser /app

# Declarar el directorio de Flutter como seguro y ajustar permisos
RUN git config --global --add safe.directory /sdks/flutter
RUN chown -R flutteruser:flutteruser /sdks/flutter

# Cambiar al usuario no root
USER flutteruser

# Desactivar telemetría (opcional)
RUN flutter config --no-analytics

# Descargar dependencias y compilar para web
RUN flutter pub get
RUN flutter build web

# Etapa 2: Servir los archivos con Nginx
FROM nginx:alpine

# Copiar los archivos compilados desde la etapa de construcción
COPY --from=builder /app/build/web /usr/share/nginx/html

# Exponer el puerto
EXPOSE 80

# Ejecutar Nginx
CMD ["nginx", "-g", "daemon off;"]
