package org.oscwii.shop.utils;

import org.oscwii.api.Package;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.Instant;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;
import java.util.Locale;

@SuppressWarnings("unused")
public class FormatUtil
{
    public static String date(long seconds)
    {
        Date date = Date.from(Instant.ofEpochSecond(seconds));
        return DATE_FORMAT.format(date);
    }

    public static String openify(String text)
    {
        String result = "";
        char[] array = text.toCharArray();
        for(int i = 0; i < array.length; i++)
        {
            char oscChar = OPEN[i % 4];
            //noinspection StringConcatenationInLoop
            result += "<span class=\"osc-%c\">%c</span>".formatted(oscChar, array[i]);
        }

        return result;
    }

    // TODO localization
    public static String peripheralsDescription(Package app)
    {
        List<String> peripherals = app.peripherals();
        List<String> toJoin = new LinkedList<>();
        StringBuilder desc = new StringBuilder("You can use this software with ");

        // Check Wii Remotes
        if(peripherals.contains("wii_remote"))
        {
            long wiiRemotes = calculateNumberOfRemotes(peripherals);
            String str = wiiRemotes == 1 ? "a Wii Remote" : "up to %d Wii Remotes".formatted(wiiRemotes);
            // Check Nunchuk
            if(peripherals.contains("nunchuk"))
                str += " and Nunchuk";
            // Check Wii Zapper
            if(peripherals.contains("wii_zapper"))
                str += " with the Wii Zapper";
            toJoin.add(str);
        }
        // Check Classic Controller
        if(peripherals.contains("classic_controller"))
            toJoin.add("the Classic Controller");
        // Check GameCube Controller
        if(peripherals.contains("gamecube_controller"))
            toJoin.add("the GameCube Controller");
        // Check Keyboard
        if(peripherals.contains("usb_keyboard"))
            toJoin.add("a USB Keyboard");

        desc.append(String.join(", ", toJoin));
        if(desc.lastIndexOf(",") != -1)
            desc.replace(desc.lastIndexOf(","), desc.lastIndexOf(",") + 1, " and");
        return desc.toString();
    }

    private static long calculateNumberOfRemotes(List<String> peripherals)
    {
        return peripherals.stream()
            .filter(peripheral -> peripheral.equals("wii_remote"))
            .count();
    }

    private static final char[] OPEN = {'o', 'p', 'e', 'n'};
    private static final DateFormat DATE_FORMAT = new SimpleDateFormat("MMMM d, y", Locale.ENGLISH);
}
