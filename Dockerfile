# Stage 1: Build the Flutter Web app

# Use the Flutter image as the base
FROM cirrusci/flutter:stable AS build

# Create and switch to a non-root user to avoid running Flutter as root
RUN useradd -ms /bin/bash flutteruser

# Change the ownership of the Flutter SDK to the new user
RUN chown -R flutteruser:flutteruser /sdks/flutter

# Switch to non-root user
USER flutteruser

# Set the working directory
WORKDIR /app

# Verify the pubspec.* files are copied correctly
COPY pubspec.* ./
RUN ls -al /app  # Debugging step to verify files are copied

# Try running flutter pub get with verbose mode to diagnose issues
RUN flutter pub get -v

# Copy the entire project to the container
COPY . .

# Enable Flutter web if it's not already enabled
RUN flutter config --enable-web

# Build the Flutter web app in release mode
RUN flutter build web --release

# Stage 2: Setup Firebase CLI with Node.js >=18 for Firebase Hosting
FROM node:18 AS deploy

# Set the working directory
WORKDIR /app

# Copy the built Flutter web app from the previous stage
COPY --from=build /app/build/web ./public

# Install Firebase CLI globally
RUN npm install -g firebase-tools

# Expose port 5000 for Firebase Hosting (optional, for local serve)
EXPOSE 5000

# Default command: Deploy the app to Firebase Hosting
CMD ["firebase", "deploy", "--only", "hosting"]
