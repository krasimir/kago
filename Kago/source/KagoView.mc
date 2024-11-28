import Toybox.Application;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
using Toybox.Graphics as Gfx;

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
        // Get the current time and format it correctly
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

        // Update the view
        var view = View.findDrawableById("TimeLabel") as Text;
        view.setColor(Application.Properties.getValue("ForegroundColor") as Number);
        view.setText(timeString);

        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);

        drawBatteryArc(dc);
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
        var lineWidth = 2;
        var chargedArcStartOffset = 0;
        // var chargedDegree = (batteryLevel/100*360)
        var chargedDegree = 180;

        dc.setPenWidth(lineWidth);
        dc.setColor(batteryColor, BackgroundColor);
        dc.drawArc(screenWidth / 2, screenHeight / 2, screenWidth / 2 - (lineWidth/2), Graphics.ARC_COUNTER_CLOCKWISE, 0, 360);
        dc.setColor(batteryColorCharged, BackgroundColor);
        dc.drawArc(
          screenWidth / 2,
          screenHeight / 2,
          screenWidth / 2 - (lineWidth/2),
          Graphics.ARC_CLOCKWISE,
          chargedArcStartOffset,
          chargedDegree + chargedArcStartOffset
        );
        /*
        0 degrees: 3 o'clock position.
        90 degrees: 12 o'clock position.
        180 degrees: 9 o'clock position.
        270 degrees: 6 o'clock position.
        */
    }

}
