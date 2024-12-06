import Toybox.Lang;
import Toybox.System;
import Toybox.ActivityMonitor;
import Toybox.Application.Storage;
import Toybox.Activity;
import Toybox.SensorHistory;
import Toybox.Time;
import Toybox.Time.Gregorian;
import Toybox.Math;

module SensorsGetters {

    module Getters {
        function getNone() as Null {
            return null;
        }

        function getSteps() as Number? {
            return ActivityMonitor.getInfo().steps;
        }

        function getCalories() as Number? {
            return ActivityMonitor.getInfo().calories;
        }

        function getStressScore() as Number? {
            return ActivityMonitor.getInfo().stressScore;
        }

        function getFloors() as Number? {
            return ActivityMonitor.getInfo().floorsClimbed;
        }

        function getTimeToRecovery() as Number? {
            return ActivityMonitor.getInfo().timeToRecovery;
        }

        function getStepGoal() as Number? {
            return ActivityMonitor.getInfo().stepGoal;
        }

        function getRespirationRate() as Number? {
            return ActivityMonitor.getInfo().respirationRate;
        }

        function getMetersClimbed() as Float? {
            return ActivityMonitor.getInfo().metersClimbed;
        }

        function getFloorsClimbedGoal() as Number? {
            return ActivityMonitor.getInfo().floorsClimbedGoal;
        }

        function getDistanceMeters() as Float? {
            var distanceCm = ActivityMonitor.getInfo().distance;

            return distanceCm != null ? distanceCm.toFloat() / 100 : null;
        }

        function getActiveMinutesDay() as Number? {
            var value = ActivityMonitor.getInfo().activeMinutesDay;

            return value != null ? value.total : value;
        }

        function getMemory() as Number {
            return System.getSystemStats().usedMemory;
        }

        function getBattery() as Number {
            return System.getSystemStats().battery.toNumber();
        }

        function getBatteryInDays() as Number {
            return System.getSystemStats().batteryInDays.toNumber();
        }

        function getAlarmCount() as Number {
            return System.getDeviceSettings().alarmCount;
        }

        function getMessages() as Number {
            return System.getDeviceSettings().notificationCount;
        }

        function getSolarIntensity() as Number? {
            return System.getSystemStats().solarIntensity;
        }

        function isDoNotDisturb() as Boolean? {
            return System.getDeviceSettings().doNotDisturb;
        }

        function isNightModeEnabled() as Boolean {
            return !!System.getDeviceSettings().isNightModeEnabled;
        }

        function getIsConnected() as Boolean {
            return System.getDeviceSettings().phoneConnected;
        }

        function getActiveMinutesWeek() as Number? {
            var value = ActivityMonitor.getInfo().activeMinutesWeek;

            return value != null ? value.total : null;
        }

        function getActiveMinutesWeekGoal() as Number? {
            return ActivityMonitor.getInfo().activeMinutesWeekGoal;
        }
    }
}
