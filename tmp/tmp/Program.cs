using System;
using System.Drawing;

public class Class1
{
    public static void Main(string[] args)
    {
        getColors(@"C:\Users\Rubén\Downloads\image.png");
    }
    public static void getColors(string ImagePath)
    {
        Dictionary<int, int[]> colors = new Dictionary<int, int[]>();

        int key = 0;
        Bitmap bmp = new Bitmap(ImagePath);
        int[,] colorKeys = new int[bmp.Height, bmp.Width];
        for (int i = 0; i < bmp.Height; i++)
        {
            for (int j = 0; j < bmp.Width; j++)
            {
                int[] color = new int[3];
                Color pixel = bmp.GetPixel(i, j);
                color[0] = pixel.B;
                color[1] = pixel.G;
                color[2] = pixel.R;



                if (!findColor(color, colors.Values.ToArray(), out int[]? coincidence))
                {
                    colors.Add(key, color);
                    colorKeys[i, j] = key;
                    key++;
                }
                else
                {
                    colorKeys[i, j] = colors.FirstOrDefault(x => x.Value == coincidence).Key;
                }
            }
        }

        foreach (KeyValuePair<int, int[]> i in colors)
        {
            Console.WriteLine($"{i.Key}: {string.Join(", ", i.Value)}");
        }

        Console.WriteLine("");
        Console.WriteLine("");
        Console.WriteLine("");
        Console.WriteLine("");


        for (int i = 0; i < colorKeys.GetLength(0); i++)
        {
            Console.Write("DC.B ");
            for (int j = 0; j < colorKeys.GetLength(1); j++)
            {
                Console.Write(colorKeys[j, i]+",");
            }
            Console.WriteLine();
        }
    }


    static bool findColor(int[] original, int[][] objectives, out int[]? coincidence)
    {
        for (int j = 0; j < objectives.Length; j++)
        {
            for (int i = 0; i < 3; i++)
            {
                if (!(objectives[j][i] - 15 <= original[i] && original[i] <= objectives[j][i] + 15))
                {
                    break;
                }
                if (i==2)
                {
                    coincidence = objectives[j];
                    return true;
                }
            }
        }

        coincidence = null;
        return false;
    }
}
