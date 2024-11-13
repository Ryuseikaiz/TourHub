package utils;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Comparator;
import java.util.List;
import java.util.concurrent.TimeUnit;
import model.Tour;

public class CSVReader {

    public List<Tour> readTourFromFile(String filePath) {
        List<Tour> tours = new ArrayList<>();
        String line;

        // Define the parsing and formatting date formats
        SimpleDateFormat inputFormat = new SimpleDateFormat("MM/dd/yyyy");
        SimpleDateFormat outputFormat = new SimpleDateFormat("yyyy-MM-dd");

        // Use InputStreamReader with UTF-8 encoding to read the file
        try (BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(filePath), "UTF-8"))) {
            // Skip the header line
            br.readLine();

            // Read each data line
            while ((line = br.readLine()) != null) {
                // Parse line manually to handle quoted commas
                List<String> values = parseCsvLine(line);

                if (values.size() < 6) {
                    System.out.println("Skipping line due to insufficient data: " + line);
                    continue;
                }

                try {
                    // Parse the data into appropriate types
                    String tourName = values.get(0);
                    String tourDescription = values.get(1);
                    Date startDate = parseDate(values.get(2), inputFormat, outputFormat);
                    Date endDate = parseDate(values.get(3), inputFormat, outputFormat);
                    String location = values.get(4);
                    int slot = Integer.parseInt(values.get(5));
                    LocalDate currentDate = LocalDate.now();
                    Date createAt = Date.valueOf(currentDate);

                    // Calculate the duration in days
                    long durationInMillis = endDate.getTime() - startDate.getTime();
                    long days = TimeUnit.MILLISECONDS.toDays(durationInMillis) + 1;
                    long nights = days - 1;
                    String duration = days + "N" + nights + "D";

                    // Add new Tour object to the list
                    tours.add(new Tour(tourName, tourDescription, startDate, endDate, location, duration, slot, "Pending", createAt));

                } catch (ParseException e) {
                    System.out.println("Skipping line due to date parse error: " + line);
                }
            }

        } catch (IOException e) {
            e.printStackTrace();
        }
        return tours;
    }

    // Helper method to parse a line with quoted fields
    private List<String> parseCsvLine(String line) {
        List<String> values = new ArrayList<>();
        StringBuilder current = new StringBuilder();
        boolean inQuotes = false;

        for (char ch : line.toCharArray()) {
            if (ch == '"') {
                inQuotes = !inQuotes; // Toggle quotes flag
            } else if (ch == ',' && !inQuotes) {
                // If not in quotes and a comma is encountered, add the value to the list
                values.add(current.toString().trim());
                current.setLength(0); // Reset the current StringBuilder
            } else {
                current.append(ch);
            }
        }
        // Add the last value after the loop ends
        values.add(current.toString().trim());
        return values;
    }

    // Helper method to parse and format date
    private Date parseDate(String dateStr, SimpleDateFormat inputFormat, SimpleDateFormat outputFormat) throws ParseException {
        dateStr = dateStr.trim();
        java.util.Date parsedDate = inputFormat.parse(dateStr); // Parse using the input format
        String formattedDate = outputFormat.format(parsedDate); // Format to the desired output format
        return Date.valueOf(formattedDate);
    }

    // Method to get the latest file in a directory
    public File getLatestFileFromDir(String dirPath) {
        File dir = new File(dirPath);

        if (!dir.exists() || !dir.isDirectory()) {
            System.out.println("Directory does not exist or is not a directory.");
            return null;
        }

        // Get all files in the directory
        File[] files = dir.listFiles(File::isFile);

        if (files == null || files.length == 0) {
            System.out.println("No files found in the directory.");
            return null; // No files found
        }

        // Sort files by last modified date, in descending order (latest first)
        Arrays.sort(files, Comparator.comparingLong(File::lastModified).reversed());

        // Return the latest file (first file after sorting)
        return files[0];
    }

    // Method to delete all files in a directory
    public void deleteAllFilesInDir(String dirPath) {
        File dir = new File(dirPath);

        if (!dir.exists() || !dir.isDirectory()) {
            System.out.println("Directory does not exist or is not a directory.");
            return;
        }

        // Get all files in the directory
        File[] files = dir.listFiles(File::isFile);

        if (files == null || files.length == 0) {
            System.out.println("No files to delete in the directory.");
            return;
        }

        // Delete each file
        for (File file : files) {
            if (file.delete()) {
                System.out.println("Deleted file: " + file.getName());
            } else {
                System.out.println("Failed to delete file: " + file.getName());
            }
        }
    }
}
