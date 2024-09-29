# Используем официальный образ Node.js
FROM node:20.17.0 AS build

# Устанавливаем рабочую директорию
WORKDIR /app

# Копируем package.json и package-lock.json для установки зависимостей
COPY package*.json ./

# Устанавливаем зависимости
RUN npm install

# Копируем остальные файлы проекта
COPY . .

# Собираем приложение
RUN npm run build

# Проверяем, что файлы собраны
RUN ls -la /app/dist

# Устанавливаем Nginx для раздачи статических файлов
FROM nginx:alpine

# Указываем, что контейнер будет слушать на порту 80
EXPOSE 80

# Копируем собранные статические файлы из предыдущего шага в директорию Nginx
COPY --from=build /app/dist /usr/share/nginx/html

# Проверяем, что файлы скопированы
RUN ls -la /usr/share/nginx/html

# Запускаем Nginx
CMD ["nginx", "-g", "daemon off;"]
