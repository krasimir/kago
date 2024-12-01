import Toybox.Application;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

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
        drawTime(dc);
        drawDate(dc);
        // drawHeartRate(dc);
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

        var view = View.findDrawableById("TimeLabel") as Text;
        view.setColor(Application.Properties.getValue("ForegroundColor") as Number);
        view.setFont(WatchUi.loadResource(Rez.Fonts.MontserratFont));
        view.setText(timeString);
        view.setLocation(
          (dc.getWidth() / 2),
          (dc.getHeight() / 2) - (view.height / 2)
        );
    }
    function drawDate(dc as Dc) as Void {
        var today = Gregorian.info(Time.now(), Time.FORMAT_MEDIUM);
        var dateString = Lang.format("$1$  $2$  $3$", [
          today.day_of_week,
          today.day.format("%02d"),
          today.month
        ]);
        var view = View.findDrawableById("DateLabel") as Text;
        view.setColor(Application.Properties.getValue("ForegroundColor") as Number);
        view.setFont(WatchUi.loadResource(Rez.Fonts.MontserratFont32));
        view.setText(dateString);
        view.setLocation(
          (dc.getWidth() / 2) - (view.width / 2),
          (dc.getHeight() / 2) - 100
        );
    }
    function drawHeartRate(dc as Dc) as Void {
      var actInfo = Activity.getActivityInfo();
      if (actInfo != null) {
        var heartRate = actInfo.currentHeartRate;
        var view = View.findDrawableById("HeartRateLabel") as Text;
        view.setColor(Application.Properties.getValue("ForegroundColor") as Number);
        if (heartRate != null) {
          view.setText('♥ ' + heartRate.format("%d"));
        } else {
          view.setText("♥ ...");
        }
        view.setLocation(
          (dc.getWidth() / 2),
          (dc.getHeight() / 2) + (view.height / 2)
        );
      }
    }
}
