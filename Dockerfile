FROM ghcr.io/cirruslabs/flutter:3.24.0

WORKDIR /app
COPY . .

RUN flutter pub get
RUN flutter build apk --release
