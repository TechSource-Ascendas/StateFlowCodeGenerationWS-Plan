<div align="center">
<img src="workshop instruction/images/techsource_logo.png" alt="TechSource Systems" width="400">
</div>

[![Buka di MATLAB Online](https://www.mathworks.com/images/responsive/global/open-in-matlab-online.svg)](https://matlab.mathworks.com/open/github/v1?repo=TechSource-Ascendas/StateFlowCodeGenerationWS-Plan&project=StateflowCodeGenerationWorkshop.prj)

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
   ├─ WS1 - Battery State Controller … _en.mlx     # Live Script (EN)
   ├─ WS1 - Battery State Controller … _id.mlx     # Live Script (ID)
   └─ images/  (screenshot_starter_model.png, screenshot_completed_chart.png, screenshot_completed_model.png, fully_assembled_circuit.jpg, techsource_logo.png)
```

---

## Mulai Cepat

1. Buka MATLAB dan project:
   ```matlab
   >> openProject('StateflowCodeGenerationWorkshop.prj')
   ```
2. Verifikasi toolbox (Langkah 1 di panduan):
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
- (Opsional) `serialport` di MATLAB untuk membaca paket status alih-alih Arduino Serial Monitor.

### Hardware per kelompok

| No | Komponen | Jumlah | Satuan | Keterangan |
| --- | --- | --- | --- | --- |
| 1 | Arduino Uno (ATmega328P) | 1 | Unit | Satu board per kelompok (3 orang) |
| 2 | Breadboard, full-size | 1 | Unit | Per kelompok |
| 3 | Potensiometer, 3-pin, 1 kΩ–20 kΩ (breadboard) | 3 | Unit | A0 = `Vpack`, A1 = `Ipack`, A2 = suhu |
| 4 | LED 5 mm — merah | 2 | Unit | LED status — 1 dipakai + 1 cadangan |
| 5 | LED 5 mm — kuning | 2 | Unit | LED status — 1 dipakai + 1 cadangan |
| 6 | LED 5 mm — hijau | 2 | Unit | LED status — 1 dipakai + 1 cadangan |
| 7 | Resistor 330 Ω, 1/4 W through-hole | 6 | Unit | Satu per LED (D8–D10) — 3 dipakai + 3 cadangan |
| 8 | Kabel jumper Dupont, M–M 40 pcs, 30 cm | 1 | Set | Per kelompok |

Ketiga LED status terhubung ke D8/D9/D10 dan ketiga potensiometer ke A0/A1/A2 — lihat **Langkah 10a** pada panduan. Daftar yang sama tersedia sebagai spreadsheet: [`ComponentList_V1.0.xlsx`](ComponentList_V1.0.xlsx).

---

*Materi Workshop Hands-On · TechSource Systems*
