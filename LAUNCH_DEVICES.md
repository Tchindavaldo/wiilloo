# Guide de lancement des appareils Flutter

Ce fichier explique comment afficher et lancer des appareils pour exécuter votre application Flutter.

---

## 1. Lister les appareils disponibles
```bash
flutter devices
```
Exemple de sortie :
```
2 connected devices:

sdk gphone64 arm64 • emulator-5554 • android
Chrome             • chrome        • web-javascript
```

---

## 2. Lancer l’application sur un appareil spécifique
```bash
flutter run -d <device_id>
```
Exemple :
```bash
flutter run -d emulator-5554
```

---

## 3. Ouvrir et utiliser un émulateur Android
1. Lister les émulateurs installés :
   ```bash
   flutter emulators
   ```
   Exemple de sortie :
   ```
   2 available emulators:
   Pixel_4_API_33 • Google Pixel 4
   Pixel_6_API_34 • Google Pixel 6
   ```
2. Lancer un émulateur :
   ```bash
   flutter emulators --launch Pixel_4_API_33
   ```
3. Déployer l’application sur l’émulateur lancé :
   ```bash
   flutter run -d Pixel_4_API_33
   ```

---

## 4. Lancer un simulateur iOS (macOS uniquement)
1. Ouvrir le simulateur :
   ```bash
   open -a Simulator
   ```
2. Une fois le simulateur démarré, exécuter l’application :
   ```bash
   flutter run -d <ios_device_id>
   ```
   _Astuce :_ utilisez `flutter devices` pour récupérer l’identifiant du simulateur iOS.

---

## 5. Lancer l’application dans le navigateur Chrome
```bash
flutter run -d chrome
```

---

> Besoin d’un nouvel appareil ou d’un autre environnement ? Exécutez simplement `flutter devices` pour voir toutes les cibles disponibles, puis utilisez `flutter run -d <device_id>`.
