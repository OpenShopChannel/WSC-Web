package org.oscwii.shop.utils;

@SuppressWarnings("unused")
public class TemplateUtil
{
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
}
