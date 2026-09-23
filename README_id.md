<div align="center">
<img src="workshop instruction/images/techsource_logo.png" alt="TechSource Systems" width="400">
</div>

[![Buka di MATLAB Online](https://www.mathworks.com/images/responsive/global/open-in-matlab-online.svg)](https://matlab.mathworks.com/)

# Hands-On Workshop — Stateflow, Code Generation & Deployment ke Arduino Uno

## Model Battery State Controller (ID)

Repositori ini berisi seluruh materi peserta & instruktur untuk workshop **2 jam** di mana peserta membangun mesin keadaan (Stateflow), mensimulasikannya, men-generate kode C embedded, dan mendeploy ke **Arduino Uno**.

| | |
|---|---|
| **Durasi** | 120 menit (40 menit instruksi + 50 menit praktik + 30 menit deploy & tantangan) |
| **Produk** | MATLAB, Simulink, Stateflow, Embedded Coder, Simulink Support Package for Arduino Hardware |
| **Hardware** | Arduino Uno (ATmega328P) — 1 board per kelompok (3 orang) |

---

## Struktur Folder

```
StateFlowCodeGenerationWS-Plan/
├─ StateflowCodeGenerationWorkshop.prj     # MATLAB project (atur path + konfigurasi)
├─ ComponentList_V1.0.xlsx                 # Daftar komponen
├─ models/
│  ├─ starter_model.slx                    # ⭐ MULAI DI SINI (chart Stateflow kosong)
│  └─ completed_model.slx                  # Model referensi lengkap
├─ requirements/
│  └─ battery_mode_requirements.csv        # REQ-01..08 (dasar logika)
├─ tests/
│  └─ battery_mode_test_cases.csv          # 7 kasus validasi
├─ data/
│  └─ battery_parameters.m                 # Parameter baterai
├─ resources/                              # Metadata project MATLAB (pertahankan untuk openProject)
├─ work/                                   # Output build, di-ignore git (<model>_ert_rtw/, *.hex/.elf/.eep, slprj/)
└─ workshop instruction/
   ├─ WS1 - Battery State Controller … _en.md      # Panduan langkah demi langkah (EN)
   ├─ WS1 - Battery State Controller … _id.md      # Panduan langkah demi langkah (ID)
   ├─ WS1 - Battery State Controller … _en.docx    # DOCX berstyle (EN)
   ├─ WS1 - Battery State Controller … _id.docx    # DOCX berstyle (ID)
   └─ images/  (screenshot_starter_model.png, screenshot_completed_chart.png, screenshot_completed_model.png, fully_assembled_circuit.jpg, techsource_logo.png)
```

---

## Mulai Cepat

1. Buka MATLAB dan project:
   ```matlab
   >> openProject('StateflowCodeGenerationWorkshop.prj')
   ```
2. Verifikasi toolbox (Langkah 0 di panduan):
   ```matlab
   >> ver('stateflow'), ver('simulink'), ver('ecoder')
   >> supportPackageInstaller   % pastikan "Simulink Support Package for Arduino Hardware"
   ```
3. Buka starter model dan ikuti panduan:
   ```matlab
   >> open_system('models/starter_model.slx')
   ```

---

## Instalasi Produk yang Dibutuhkan (Setup Toolbox)

Workshop ini divalidasi dengan **Dependency Analyzer** pada model lengkap. Selain support package Arduino, menjalankan model membutuhkan produk di bawah — instal semua yang belum ada **sebelum** sesi.

**Cara instal:** buka MATLAB → **Home → Add-Ons → Get Add-Ons** (Add-On Explorer), cari setiap produk berdasarkan nama, lalu klik **Install** (butuh koneksi internet + akun MathWorks). Untuk package Arduino gunakan wizard di layar.

| Produk | Peran di workshop ini | Cara instal / cek `ver` |
|--------|-----------------------|-------------------------|
| MATLAB | Runtime inti | (selalu ada) |
| Simulink | Host model | `ver('simulink')` |
| Stateflow | Desain state machine | `ver('stateflow')` |
| Embedded Coder | Generate kode C siap hardware | `ver('ecoder')` |
| Simulink Support Package for Arduino Hardware | Deploy ke Arduino Uno | `supportPackageInstaller` (Support Package — tidak muncul di `ver`) |

```matlab
% Verifikasi sekaligus bahwa semua produk terpasang:
>> ver('simulink'), ver('stateflow'), ver('ecoder')
>> supportPackageInstaller   % pastikan "Simulink Support Package for Arduino Hardware" = Installed
```

---

## Model

**Battery State Controller** menentukan satu dari empat state dari tegangan, arus, dan suhu:

| State | Kondisi | LED (state_id) |
|-------|---------|----------------|
| IDLE | V aman, |I| ≤ 1 A | D8 ON (0) |
| CHARGING | V aman, I > 1 A | D9 ON (1) |
| DISCHARGING | V aman, I < −1 A | D10 ON (2) |
| FAULT | V < 9 V atau V > 12.6 V atau T > 50 °C | D8, D9, D10 semuanya ON (3) |

Bangun chart 4-state sendiri, atau buka `models/completed_model.slx` sebagai kunci jawaban.

---

## Prasyarat

- MATLAB + produk di atas, dengan support package Arduino terpasang.
- 1 Arduino Uno per kelompok, breadboard, 3 LED + resistor 330 Ω, 3 potensiometer.
- (Opsional) `serialport` di MATLAB untuk membaca paket status alih-alih Arduino Serial Monitor.

---

*Materi Workshop Hands-On · TechSource Systems*
