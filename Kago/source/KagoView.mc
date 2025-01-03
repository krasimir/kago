import Toybox.Application;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
import SensorsGetters;
import Quotes;
using Toybox.Math;

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
        drawAccentLines(dc);
        drawDayArc(dc);
        drawTime(dc);
        drawDate(dc);
        drawBattery(dc);
        drawHeartRate(dc);
        drawMessages(dc);
        drawSteps(dc);
        drawDistance(dc);
        drawCalories(dc);
        drawPhoneConnection(dc);
        drawQuote(dc);
        drawSeason(dc);
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
    function drawSeason(dc as Dc) as Void {
      var bitmap = self._getSeasonIcon();
      var season = new WatchUi.Bitmap({
        :rezId => bitmap
      });
      var dimensions = season.getDimensions();
      season.setLocation(
        (dc.getWidth() / 2) - (dimensions[0] / 2),
        58 - (dimensions[1] / 2)
      );
      season.draw(dc);
    }
    function drawQuote(dc as Dc) as Void {
      var quoteText = Quotes.getQuote();
      var width = dc.getWidth() - 100;
      var font = WatchUi.loadResource(Rez.Fonts.MontserratFont22);
      var text = new WatchUi.TextArea({
        :text => quoteText,
        :color => Application.Properties.getValue("SensorStatsColor") as Number,
        :font => font,
        :width => width,
        :height => 200,
        :justification => Graphics.TEXT_JUSTIFY_CENTER
      });
      var size = dc.getTextDimensions(quoteText, font);
      var textY = 134 - (size[1] / 2);
      if (quoteText.length() > 25) {
        textY = 134 - ((size[1] * 2) / 2);
      }
      text.setLocation((dc.getWidth() / 2) - (width / 2), textY);
      text.draw(dc);
    }
    function drawAccentLines(dc as Dc) as Void {
        var clockTime = System.getClockTime();

        dc.setPenWidth(1);
        dc.setColor(
          Application.Properties.getValue("AccentLinesColor") as Number,
          Application.Properties.getValue("AccentLinesColor") as Number
        );

        // dots
        var radius = (dc.getWidth() / 2) - 5;
        var angles = [0, 30, 60, 90, 120, 150, 180, 210, 240, 300, 330];
        // 0 = 3 o'clock
        // 90 = 6 o'clock
        // 180 = 9 o'clock
        // 270 = 12 o'clock
        dc.setPenWidth(6);
        for (var i = 0; i < angles.size(); i++) {
          var angle = 360 - angles[i];
          dc.drawArc(
            dc.getWidth()/2,
            dc.getHeight()/2,
            radius - 4,
            Graphics.ARC_COUNTER_CLOCKWISE,
            angle - 2,
            angle + 2
          );
        }
        dc.setPenWidth(1);
        for (var i = 0; i < 360; i+=2) {
          var angle = i;
          var theta = Math.toRadians(angle);
          var x1 = (dc.getWidth()/2) + (radius - 4) * Math.cos(theta);
          var y1 = (dc.getHeight()/2) + (radius - 4) * Math.sin(theta);
          var x2 = (dc.getWidth()/2) + (radius - 7) * Math.cos(theta);
          var y2 = (dc.getHeight()/2) + (radius - 7) * Math.sin(theta);
          dc.drawLine(x1, y1, x2, y2);
        }

        // accent below the time
        var centerY = dc.getHeight() / 2 + 70;
        dc.drawLine(
          60, centerY,
          dc.getWidth() - 60, centerY
        );
        dc.drawCircle(60 - 5, centerY, 2);
        dc.drawCircle(dc.getWidth() - 60 + 5, centerY, 2);
        dc.drawLine(
          dc.getWidth() / 2, centerY,
          dc.getWidth() / 2, centerY + 100
        );
        dc.drawCircle(dc.getWidth() / 2, centerY + 100 + 5, 2);

        // accent between time and date
        dc.drawLine(
          dc.getWidth() - 112, dc.getHeight() / 2 - 45,
          dc.getWidth() - 112, dc.getHeight() / 2 + 69
        );
        dc.drawCircle(dc.getWidth() - 112, dc.getHeight() / 2 - 45 - 5, 2);
    }
    function drawDayArc(dc as Dc) as Void {
        var clockTime = System.getClockTime();
        var screenWidth = dc.getWidth();
        var screenHeight = dc.getHeight();
        var DayArcColor = Application.Properties.getValue("DayArcColor") as Number;
        var DayArcColorCharged = Application.Properties.getValue("DayArcColorCharged") as Number;
        var BackgroundColor = Application.Properties.getValue("BackgroundColor") as Number;
        var lineWidth = 4;

        var percentageHour = ((((clockTime.hour % 12) * 60.0) + clockTime.min) / (12.0 * 60.0)) * 100;
        var angleHour = 360 - (percentageHour/100*360);
        if (angleHour < 1) {
          angleHour = 1;
        }

        // Background arc
        dc.setPenWidth(lineWidth);
        dc.setColor(DayArcColorCharged, BackgroundColor);
        dc.drawArc(
          screenWidth / 2,
          screenHeight / 2,
          screenWidth / 2 - (lineWidth/2),
          Graphics.ARC_COUNTER_CLOCKWISE,
          0,
          360
        );
        // Time progress arc
        dc.setColor(DayArcColor, BackgroundColor);
        dc.drawArc(
          screenWidth / 2,
          screenHeight / 2,
          screenWidth / 2 - (lineWidth / 2),
          Graphics.ARC_COUNTER_CLOCKWISE,
          90,
          angleHour + 90
        );
        // Hours
        dc.setPenWidth(2);
        dc.setColor(DayArcColorCharged, BackgroundColor);
        self._drawArrow((percentageHour * 360 / 100) - 90, dc);
        // Minutes
        var percentageMinute = (clockTime.min / 60.0) * 100;
        dc.setPenWidth(2);
        dc.setColor(DayArcColor, BackgroundColor);
        self._drawArrow((percentageMinute * 360 / 100) - 90, dc);
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
            }
        }
        var timeString = Lang.format(timeFormat, [hours.format("%02d"), clockTime.min.format("%02d")]);

        var font = WatchUi.loadResource(Rez.Fonts.OswaldBold120);
        var text = new WatchUi.Text({
          :text => timeString,
          :color => Application.Properties.getValue("ForegroundColor") as Number,
          :font => font,
          :justification => Graphics.TEXT_JUSTIFY_LEFT
        });
        var size = dc.getTextDimensions(timeString, font);
        text.setLocation(
          dc.getWidth() - size[0] - 132,
          (dc.getHeight() / 2) - (size[1] / 2) - 8
        );
        text.draw(dc);
    }
    function drawDate(dc as Dc) as Void {
        var today = Gregorian.info(Time.now(), Time.FORMAT_MEDIUM);
        var dayOfWeek = Gregorian.info(Time.now(), Time.FORMAT_SHORT).day_of_week;
        var dateString = Lang.format("$1$\n$2$\n$3$", [
          self._getDayOfWeek(dayOfWeek),
          today.day.format("%02d"),
          today.month
        ]);
        var date = self._createText(dc, dateString, Rez.Fonts.MontserratFont22, "DateColor");
        date["text"].setLocation(
          dc.getWidth() - 88,
          (dc.getHeight() / 2) - date["height"] / 2
        );
        self._drawText(dc, date);
    }
    function drawPhoneConnection(dc as Dc) as Void {
      var isConnected = SensorsGetters.Getters.getIsConnected();
      if (isConnected) {
        self._drawIcon(
          dc,
          Rez.Fonts.connection_icon,
          (dc.getWidth() / 2) - 8,
          dc.getHeight() - 42,
          "SensorStatsColor"
        );
      }
    }
    function drawBattery(dc as Dc) as Void {
      var battery = SensorsGetters.Getters.getBattery();
      var batteryText = "___";
      if (battery != null) {
        batteryText = battery.format("%d") + "%";
        var batteryInDays = SensorsGetters.Getters.getBatteryInDays();
        batteryText += " / " + batteryInDays.format("%d") + "d";
      }  
      var text = self._createText(dc, batteryText, Rez.Fonts.MontserratFont22, "SensorStatsColor");
      var textX = (dc.getWidth() / 2) - text["width"] - 16;
      var textY = (dc.getHeight() / 2) + 80;
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
      self._drawIcon(dc, batteryIcon, textX - 22, textY + 6, "SensorStatsColor");
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
      var text = self._createText(dc, heartRateText, Rez.Fonts.MontserratFont22, "SensorStatsColor");
      var textX = (dc.getWidth() / 2) - text["width"] - 16;
      var textY = (dc.getHeight() / 2) + 80 + 30;
      text["text"].setJustification(Graphics.TEXT_JUSTIFY_LEFT);
      text["text"].setLocation(textX, textY);
      self._drawText(dc, text);
      _drawIcon(dc, Rez.Fonts.heart_icon, textX - 22, textY + 6, "SensorStatsColor");
    }
    function drawMessages(dc as Dc) as Void {
      var messages = SensorsGetters.Getters.getMessages();
      var messagesText = "___";
      if (messages != null) {
        messagesText = messages.format("%d");
      }  
      var text = self._createText(dc, messagesText, Rez.Fonts.MontserratFont22, "SensorStatsColor");
      var textX = (dc.getWidth() / 2) - text["width"] - 16;
      var textY = (dc.getHeight() / 2) + 80 + 30 + 30;
      text["text"].setJustification(Graphics.TEXT_JUSTIFY_LEFT);
      text["text"].setLocation(textX, textY);
      self._drawText(dc, text);
      self._drawIcon(dc, Rez.Fonts.messages_icon, textX - 24, textY + 6, "SensorStatsColor");
    }
    function drawSteps(dc as Dc) as Void {
      var steps = SensorsGetters.Getters.getSteps();
      var goalSteps = SensorsGetters.Getters.getStepGoal();
      var stepsText = "___";
      if (steps != null) {
        stepsText = self._formatSteps(steps);
        if (goalSteps != null && steps != null) {
          var goalText = steps.toFloat() / goalSteps.toFloat() * 100;
          stepsText += " / " + goalText.format("%.0f") + "%";
        }
      }  
      var text = self._createText(dc, stepsText, Rez.Fonts.MontserratFont22, "SensorStatsColor");
      var textX = (dc.getWidth() / 2) + 38;
      var textY = (dc.getHeight() / 2) + 80;
      text["text"].setJustification(Graphics.TEXT_JUSTIFY_LEFT);
      text["text"].setLocation(textX, textY);
      self._drawText(dc, text);
      self._drawIcon(dc, Rez.Fonts.steps_icon, textX - 22, textY + 6, "SensorStatsColor");
    }
    function drawDistance(dc as Dc) as Void {
      var distance = SensorsGetters.Getters.getDistanceMeters();
      var distanceText = "___";
      if (distance != null) {
        distanceText = self._transformMeters(distance);
      }  
      var text = self._createText(dc, distanceText, Rez.Fonts.MontserratFont22, "SensorStatsColor");
      var textX = (dc.getWidth() / 2) + 38;
      var textY = (dc.getHeight() / 2) + 80 + 30;
      text["text"].setJustification(Graphics.TEXT_JUSTIFY_LEFT);
      text["text"].setLocation(textX, textY);
      self._drawText(dc, text);
      self._drawIcon(dc, Rez.Fonts.distance_icon, textX - 22, textY + 6, "SensorStatsColor");
    }
    function drawCalories(dc as Dc) as Void {
      var calories = SensorsGetters.Getters.getCalories();
      var caloriesText = "___";
      if (calories != null) {
        caloriesText = calories.format("%d");
      }  
      var text = self._createText(dc, caloriesText, Rez.Fonts.MontserratFont22, "SensorStatsColor");
      var textX = (dc.getWidth() / 2) + 38;
      var textY = (dc.getHeight() / 2) + 80 + 30 + 30;
      text["text"].setJustification(Graphics.TEXT_JUSTIFY_LEFT);
      text["text"].setLocation(textX, textY);
      self._drawText(dc, text);
      self._drawIcon(dc, Rez.Fonts.calories_icon, textX - 22, textY + 6, "SensorStatsColor");
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
          return "Mon";
        case Time.Gregorian.DAY_TUESDAY:
          return "Tue";
        case Time.Gregorian.DAY_WEDNESDAY:
          return "Wed";
        case Time.Gregorian.DAY_THURSDAY:
          return "Thu";
        case Time.Gregorian.DAY_FRIDAY:
          return "Fri";
        case Time.Gregorian.DAY_SATURDAY:
          return "Sat";
        case Time.Gregorian.DAY_SUNDAY:
          return "Sun";
      }
      return "___";
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
    function _formatSteps(steps as Float or Number) as String {
        if (steps > 1000) {
            return (steps / 1000).format("%.1f") + "k";
        }
        return steps.format("%d");
    }
    function _getSeasonIcon() {
      var today = Gregorian.info(Time.now(), Time.FORMAT_SHORT);
      var month = today.month;
      var bitmap = Rez.Drawables.TreeJanuary;
      var seasonIconType = Application.Properties.getValue("SeasonIcon") as String;
      // month = 12;
      // seasonIconType = 1;
      if (month == 1) {
        bitmap = Rez.Drawables.TreeJanuary;
        if (seasonIconType == 1) {
          bitmap = Rez.Drawables.IllustrationJanuary;
        }
      } else if (month == 2) {
        bitmap = Rez.Drawables.TreeFebruary;
        if (seasonIconType == 1) {
          bitmap = Rez.Drawables.IllustrationFebruary;
        }
      } else if (month == 3) {
        bitmap = Rez.Drawables.TreeMarch;
        if (seasonIconType == 1) {
          bitmap = Rez.Drawables.IllustrationMarch;
        }
      } else if (month == 4) {
        bitmap = Rez.Drawables.TreeApril;
        if (seasonIconType == 1) {
          bitmap = Rez.Drawables.IllustrationApril;
        }
      } else if (month == 5) {
        bitmap = Rez.Drawables.TreeMay;
        if (seasonIconType == 1) {
          bitmap = Rez.Drawables.IllustrationMay;
        }
      } else if (month == 6) {
        bitmap = Rez.Drawables.TreeJune;
        if (seasonIconType == 1) {
          bitmap = Rez.Drawables.IllustrationJune;
        }
      } else if (month == 7) {
        bitmap = Rez.Drawables.TreeJuly;
        if (seasonIconType == 1) {
          bitmap = Rez.Drawables.IllustrationJuly;
        }
      } else if (month == 8) {
        bitmap = Rez.Drawables.TreeAugust;
        if (seasonIconType == 1) {
          bitmap = Rez.Drawables.IllustrationAugust;
        }
      } else if (month == 9) {
        bitmap = Rez.Drawables.TreeSeptember;
        if (seasonIconType == 1) {
          bitmap = Rez.Drawables.IllustrationSeptember;
        }
      } else if (month == 10) {
        bitmap = Rez.Drawables.TreeOctober;
        if (seasonIconType == 1) {
          bitmap = Rez.Drawables.IllustrationOctober;
        }
      } else if (month == 11) {
        bitmap = Rez.Drawables.TreeNovember;
        if (seasonIconType == 1) {
          bitmap = Rez.Drawables.IllustrationNovember;
        }
      } else if (month == 12) {
        bitmap = Rez.Drawables.TreeDecember;
        if (seasonIconType == 1) {
          bitmap = Rez.Drawables.IllustrationDecember;
        }
      }
      return bitmap;
    }
    function _drawArrow(angle as Float or Number, dc as Dc) as Void {
      var radius = (dc.getWidth() / 2) - 10;
      var circleX = (dc.getWidth()/2) + (radius + 10) * Math.cos(Math.toRadians(angle));
      var circleY = (dc.getHeight()/2) + (radius + 10) * Math.sin(Math.toRadians(angle));
      var x1 = (dc.getWidth()/2) + (radius - 14) * Math.cos(Math.toRadians(angle));
      var y1 = (dc.getHeight()/2) + (radius - 14) * Math.sin(Math.toRadians(angle));
      var x2 = (dc.getWidth()/2) + (radius - 10) * Math.cos(Math.toRadians(angle));
      var y2 = (dc.getHeight()/2) + (radius - 10)* Math.sin(Math.toRadians(angle));
      dc.drawLine(x1, y1, x2, y2);
      dc.drawCircle(circleX, circleY, 14);
    }
}
