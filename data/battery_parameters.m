function params = battery_parameters()
%BATTERY_PARAMETERS Workshop thresholds and scaling constants.

params.BatteryType = "3S Li-ion pack";
params.NominalVoltage_V = 11.1;
params.MinSafeVoltage_V = 9.0;
params.MaxSafeVoltage_V = 12.6;
params.VoltageAdcMax = 1023;
params.VoltageScale_V = 15;
params.CurrentAdcMax = 1023;
params.CurrentSpan_A = 20;
params.CurrentOffset_A = -10;
params.CurrentDeadband_A = 1.0;
params.MaxSafeTemp_C = 50;
params.SampleTime_s = 0.1;
params.PinVoltagePot = "A0";
params.PinCurrentPot = "A1";
params.PinTemperaturePot = "A2";
params.PinIdleLed = "D8";
params.PinChargingLed = "D9";
params.PinDischargingLed = "D10";
% FAULT has no dedicated pin: all three LEDs (D8+D9+D10) turn ON together.
end
