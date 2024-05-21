package org.oscwii.shop.utils;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.Instant;
import java.util.Date;
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

    private static final char[] OPEN = {'o', 'p', 'e', 'n'};
    private static final DateFormat DATE_FORMAT = new SimpleDateFormat("MMMM d, y", Locale.ENGLISH);
}
