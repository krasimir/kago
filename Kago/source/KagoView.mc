import Toybox.Application;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
import SensorsGetters;

using Toybox.Time;
using Toybox.Time.Gregorian;

class KagoView extends WatchUi.WatchFace {

    function initialize() {
        WatchFace.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.WatchFace(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        View.onUpdate(dc);
        drawBatteryArc(dc);
        drawAccentLines(dc);
        drawTime(dc);
        drawDate(dc);
        drawBattery(dc);
        drawHeartRate(dc);
        drawActiveMinutes(dc);
        drawSteps(dc);
        drawDistance(dc);
        drawCalories(dc);
        drawMessages(dc);
        drawPhoneConnection(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() as Void {
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() as Void {
    }

    // -----------------------
    function drawAccentLines(dc as Dc) as Void {
        dc.setPenWidth(1);
        dc.setColor(
          Application.Properties.getValue("AccentLinesColor") as Number,
          Application.Properties.getValue("AccentLinesColor") as Number
        );
        var centerY = dc.getHeight() / 2 + 90;
        dc.drawLine(
          dc.getWidth() / 2, 70,
          dc.getWidth() / 2, 95
        );
        // accent below the time
        dc.drawLine(
          100, centerY,
          dc.getWidth() - 100, centerY
        );
        dc.drawCircle(95, centerY, 2);
        dc.drawCircle(dc.getWidth() - 95, centerY, 2);
        dc.drawLine(
          dc.getWidth() / 2, centerY,
          dc.getWidth() / 2, centerY + 80
        );
        dc.drawCircle(dc.getWidth() / 2, centerY, 2);
        // accent above the time
        var aboveTheTimeY = dc.getHeight() / 2 - 80;
        dc.drawLine(
          100, aboveTheTimeY,
          150, aboveTheTimeY
        );
        dc.drawCircle(100 - 5, aboveTheTimeY, 2);
        dc.drawLine(
          dc.getWidth() - 150, aboveTheTimeY,
          dc.getWidth() - 100, aboveTheTimeY
        );
        dc.drawCircle(dc.getWidth() - 100 + 5, aboveTheTimeY, 2);
        // arrows
        dc.drawArc(
          dc.getWidth() / 2 - 10,
          dc.getHeight() / 2,
          140,
          Graphics.ARC_CLOCKWISE,
          140,
          90
        );
        dc.drawArc(
          dc.getWidth() / 2 + 10,
          dc.getHeight() / 2,
          140,
          Graphics.ARC_COUNTER_CLOCKWISE,
          40,
          90
        );
    }
    function drawBatteryArc(dc as Dc) as Void {
        var screenWidth = dc.getWidth();
        var screenHeight = dc.getHeight();
        var myStats = System.getSystemStats();
        var batteryLevel = myStats.battery;
        var batteryColor = Application.Properties.getValue("BatteryColor") as Number;
        var batteryColorCharged = Application.Properties.getValue("BatteryColorCharged") as Number;
        var BackgroundColor = Application.Properties.getValue("BackgroundColor") as Number;
        var lineWidth = 4;
        var chargedDegree = 360 - ((100 - batteryLevel)/100*360);

        // Background arc
        dc.setPenWidth(lineWidth);
        dc.setColor(batteryColorCharged, BackgroundColor);
        dc.drawArc(
          screenWidth / 2,
          screenHeight / 2,
          screenWidth / 2 - (lineWidth/2),
          Graphics.ARC_COUNTER_CLOCKWISE,
          0,
          360
        );
        // Charged arc
        dc.setColor(batteryColor, BackgroundColor);
        dc.drawArc(
          screenWidth / 2,
          screenHeight / 2,
          screenWidth / 2 - (lineWidth/2),
          Graphics.ARC_COUNTER_CLOCKWISE,
          90,
          chargedDegree + 90
        );
    }
    function drawTime(dc as Dc) as Void {
        var timeFormat = "$1$:$2$";
        var clockTime = System.getClockTime();
        var hours = clockTime.hour;
        if (!System.getDeviceSettings().is24Hour) {
            if (hours > 12) {
                hours = hours - 12;
            }
        } else {
            if (Application.Properties.getValue("UseMilitaryFormat")) {
                timeFormat = "$1$$2$";
                hours = hours.format("%02d");
            }
        }
        var timeString = Lang.format(timeFormat, [hours, clockTime.min.format("%02d")]);

        var font = WatchUi.loadResource(Rez.Fonts.OswaldBold140);
        var text = new WatchUi.Text({
          :text => timeString,
          :color => Application.Properties.getValue("ForegroundColor") as Number,
          :font => font,
          :justification => Graphics.TEXT_JUSTIFY_CENTER
        });
        var size = dc.getTextDimensions(timeString, font);
        text.setLocation(
          (dc.getWidth() / 2),
          (dc.getHeight() / 2) - (size[1] / 2)
        );
        text.draw(dc);
    }
    function drawDate(dc as Dc) as Void {
        var today = Gregorian.info(Time.now(), Time.FORMAT_MEDIUM);
        var dayOfWeek = Gregorian.info(Time.now(), Time.FORMAT_SHORT).day_of_week;
        var dateString = Lang.format("$1$ $2$", [
          today.day.format("%02d"),
          today.month
        ]);
        var dayAndMonth = self._createText(dc, dateString, Rez.Fonts.MontserratFont32, "DateColor");
        dayAndMonth["text"].setLocation(
          (dc.getWidth() / 2) - (dayAndMonth["width"] / 2),
          (dc.getHeight() / 2) - 100
        );
        self._drawText(dc, dayAndMonth);
        var weekDay = self._createText(dc, self._getDayOfWeek(dayOfWeek), Rez.Fonts.MontserratFont16, "WeekDayColor");
        weekDay["text"].setLocation(
          (dc.getWidth() / 2) - (weekDay["width"] / 2),
          (dc.getHeight() / 2) - 120
        );
        self._drawText(dc, weekDay);
    }
    function drawMessages(dc as Dc) as Void {
      var messages = SensorsGetters.Getters.getMessages();
      var messagesText = "___";
      if (messages != null) {
        messagesText = messages.format("%d");
      }  
      var text = self._createText(dc, messagesText, Rez.Fonts.MontserratFont16, "MessagesColor");
      var textX = (dc.getWidth() / 2) + 4;
      var textY = 42;
      text["text"].setJustification(Graphics.TEXT_JUSTIFY_LEFT);
      text["text"].setLocation(textX, textY);
      self._drawText(dc, text);
      self._drawIcon(dc, Rez.Fonts.messages_icon, textX - 22, textY + 1, "MessagesColor");
    }
    function drawPhoneConnection(dc as Dc) as Void {
      var isConnected = SensorsGetters.Getters.getIsConnected();
      if (isConnected) {
        self._drawIcon(dc, Rez.Fonts.connection_icon, (dc.getWidth() / 2) - 8, 18, "PhoneConnection");
      }
    }
    function drawBattery(dc as Dc) as Void {
      var battery = SensorsGetters.Getters.getBattery();
      var batteryText = "___";
      if (battery != null) {
        batteryText = battery.format("%d") + "%";
      }  
      var text = self._createText(dc, batteryText, Rez.Fonts.MontserratFont16, "SensorStatsColor");
      var textX = (dc.getWidth() / 2) - (text["width"] / 2) - 32;
      var textY = (dc.getHeight() / 2) + 106;
      text["text"].setJustification(Graphics.TEXT_JUSTIFY_LEFT);
      text["text"].setLocation(textX, textY);
      self._drawText(dc, text);
      var batteryIcon = Rez.Fonts.battery_100_icon;
      if (battery != null && battery <= 75) {
        batteryIcon = Rez.Fonts.battery_75_icon;
      }
      if (battery != null && battery <= 50) {
        batteryIcon = Rez.Fonts.battery_50_icon;
      }
      if (battery != null && battery <= 25) {
        batteryIcon = Rez.Fonts.battery_25_icon;
      }
      if (battery != null && battery <= 10) {
        batteryIcon = Rez.Fonts.battery_0_icon;
      }
      if (System.getSystemStats().charging) {
        batteryIcon = Rez.Fonts.energy_icon;
      }
      self._drawIcon(dc, batteryIcon, textX - 22, textY + 1, "SensorStatsColor");
    }
    function drawHeartRate(dc as Dc) as Void {
      var heartRate = 0;
      var heartRateText = "___";
      var actInfo = Activity.getActivityInfo();
      if (actInfo != null) {
        heartRate = actInfo.currentHeartRate;    
        if (heartRate != 0 && heartRate != null) {
          heartRateText = heartRate.format("%d");
        }
      }  
      var text = self._createText(dc, heartRateText, Rez.Fonts.MontserratFont16, "SensorStatsColor");
      var textX = (dc.getWidth() / 2) - (text["width"] / 2) - 32;
      var textY = (dc.getHeight() / 2) + 106 + 30;
      text["text"].setJustification(Graphics.TEXT_JUSTIFY_LEFT);
      text["text"].setLocation(textX, textY);
      self._drawText(dc, text);
      _drawIcon(dc, Rez.Fonts.heart_icon, textX - 22, textY + 1, "SensorStatsColor");
    }
    function drawActiveMinutes(dc as Dc) as Void {
      var activeMinutes = SensorsGetters.Getters.getActiveMinutesDay();
      var activeMinutesText = "___";
      if (activeMinutes != null) {
        activeMinutesText = activeMinutes.format("%d");
      }  
      var text = self._createText(dc, activeMinutesText, Rez.Fonts.MontserratFont16, "SensorStatsColor");
      var textX = (dc.getWidth() / 2) - (text["width"] / 2) - 32;
      var textY = (dc.getHeight() / 2) + 106 + 30 + 30;
      text["text"].setJustification(Graphics.TEXT_JUSTIFY_LEFT);
      text["text"].setLocation(textX, textY);
      self._drawText(dc, text);
      _drawIcon(dc, Rez.Fonts.activity_icon, textX - 22, textY + 1, "SensorStatsColor");
    }
    function drawSteps(dc as Dc) as Void {
      var steps = SensorsGetters.Getters.getSteps();
      var goalSteps = SensorsGetters.Getters.getStepGoal();
      var stepsText = "___";
      if (steps != null) {
        stepsText = steps.format("%d");
      }  
      var text = self._createText(dc, stepsText, Rez.Fonts.MontserratFont16, "SensorStatsColor");
      var textX = (dc.getWidth() / 2) + 38;
      var textY = (dc.getHeight() / 2) + 106;
      text["text"].setJustification(Graphics.TEXT_JUSTIFY_LEFT);
      text["text"].setLocation(textX, textY);
      self._drawText(dc, text);
      self._drawIcon(dc, Rez.Fonts.steps_icon, textX - 22, textY + 1, "SensorStatsColor");
      if (goalSteps != null && steps != null) {
        var goalText = steps.toFloat() / goalSteps.toFloat() * 100;
        var goal = self._createText(dc, goalText.format("%d") + "%", Rez.Fonts.MontserratFont16, "SensorStatsColor");
        goal["text"].setJustification(Graphics.TEXT_JUSTIFY_LEFT);
        goal["text"].setLocation(textX + text["width"] + 2, textY - 4);
        self._drawText(dc, goal);
      }
    }
    function drawDistance(dc as Dc) as Void {
      var distance = SensorsGetters.Getters.getDistanceMeters();
      var distanceText = "___";
      if (distance != null) {
        distanceText = self._transformMeters(distance);
      }  
      var text = self._createText(dc, distanceText, Rez.Fonts.MontserratFont16, "SensorStatsColor");
      var textX = (dc.getWidth() / 2) + 38;
      var textY = (dc.getHeight() / 2) + 106 + 30;
      text["text"].setJustification(Graphics.TEXT_JUSTIFY_LEFT);
      text["text"].setLocation(textX, textY);
      self._drawText(dc, text);
      self._drawIcon(dc, Rez.Fonts.distance_icon, textX - 22, textY + 1, "SensorStatsColor");
    }
    function drawCalories(dc as Dc) as Void {
      var calories = SensorsGetters.Getters.getCalories();
      var caloriesText = "___";
      if (calories != null) {
        caloriesText = calories.format("%d");
      }  
      var text = self._createText(dc, caloriesText, Rez.Fonts.MontserratFont16, "SensorStatsColor");
      var textX = (dc.getWidth() / 2) + 38;
      var textY = (dc.getHeight() / 2) + 106 + 30 + 30;
      text["text"].setJustification(Graphics.TEXT_JUSTIFY_LEFT);
      text["text"].setLocation(textX, textY);
      self._drawText(dc, text);
      self._drawIcon(dc, Rez.Fonts.calories_icon, textX - 22, textY + 1, "SensorStatsColor");
    }

    function _drawIcon(dc as Dc, iconId as ResourceId, x as Number, y as Number, color as String) as Void {
      var icon = new WatchUi.Text({
        :text => " ",
        :color => Application.Properties.getValue(color) as Number,
        :font => WatchUi.loadResource(iconId)
      });
      icon.setLocation(x, y);
      icon.draw(dc);
    }
    function _createText(dc as Dc, str as String, fontId as ResourceId, color as String) as Dictionary {
      var font = WatchUi.loadResource(fontId);
      var text = new WatchUi.Text({
        :text => str,
        :color => Application.Properties.getValue(color) as Number,
        :font => font
      });
      var size = dc.getTextDimensions(str, font);
      var result = {};
      result["text"] = text;
      result["width"] = size[0];
      result["height"] = size[1];
      return result;
    }
    function _drawText(dc as Dc, text as Dictionary) as Void {
      text["text"].draw(dc);
    }
    function _getDayOfWeek(dayOfWeek as Number) as String {
      switch (dayOfWeek) {
        case Time.Gregorian.DAY_MONDAY:
          return "MONDAY";
        case Time.Gregorian.DAY_TUESDAY:
          return "TUESDAY";
        case Time.Gregorian.DAY_WEDNESDAY:
          return "WEDNESDAY";
        case Time.Gregorian.DAY_THURSDAY:
          return "THURSDAY";
        case Time.Gregorian.DAY_FRIDAY:
          return "FRIDAY";
        case Time.Gregorian.DAY_SATURDAY:
          return "SATURDAY";
        case Time.Gregorian.DAY_SUNDAY:
          return "SUNDAY";
      }
      return "UNKNOWN";
    }
    function _transformMeters(value as Float or Number) as String {

        var unitText = "";
        var isKilometr = value >= 1000;
        var isMetricSystem = System.getDeviceSettings().distanceUnits == System.UNIT_METRIC;

        value = value.toFloat();

        if (isKilometr) {
            unitText = isMetricSystem ? "km" : "mi";
            value = isMetricSystem ? value / 1000 : self._transformMetrToMil(value);
        } else {
            unitText = isMetricSystem ? "m" : "ft";
            value = isMetricSystem ? value : self._transformMetrToFeet(value);
        }

        return value.format("%.1f") + " " + unitText;
    }
    function _transformMetrToMil(value as Float or Number) as Float or Number {
        return value * 0.000621;
    }
    function _transformMetrToFeet(value as Float or Number) as Float or Number {
          return value * 3.280839895;
      }
}
