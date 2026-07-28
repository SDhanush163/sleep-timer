# ANSI Styling & Terminal Control

Windows Power Timer uses ANSI escape sequences to build its terminal interface. Rather than clearing and redrawing the console every second, the application updates only the parts of the screen that change, resulting in a smoother countdown and a cleaner user experience.

---

## Escape Character

All ANSI escape sequences begin with the escape character stored in the `ESC` variable.

```bat
echo %ESC%[31mHello%ESC%[0m
```

The `ESC` variable acts as the prefix for every ANSI sequence used throughout the project.

---

## Text Colours

The following colour codes are used by Windows Power Timer.

|                                           Preview                                           | ANSI Code | Escape Sequence | Example                 |
| :-----------------------------------------------------------------------------------------: | :-------: | --------------- | ----------------------- |
|          <img src="https://img.shields.io/badge/91-Red-8B0000?style=flat-square"/>          |   `91`    | `ESC[91m`       | `%ESC%[91mText%ESC%[0m` |
|         <img src="https://img.shields.io/badge/92-Green-228B22?style=flat-square"/>         |   `92`    | `ESC[92m`       | `%ESC%[92mText%ESC%[0m` |
|        <img src="https://img.shields.io/badge/93-Yellow-DAA520?style=flat-square"/>         |   `93`    | `ESC[93m`       | `%ESC%[93mText%ESC%[0m` |
|         <img src="https://img.shields.io/badge/94-Blue-1E90FF?style=flat-square"/>          |   `94`    | `ESC[94m`       | `%ESC%[94mText%ESC%[0m` |
|        <img src="https://img.shields.io/badge/95-Magenta-C71585?style=flat-square"/>        |   `95`    | `ESC[95m`       | `%ESC%[95mText%ESC%[0m` |
|         <img src="https://img.shields.io/badge/96-Cyan-00ACC1?style=flat-square"/>          |   `96`    | `ESC[96m`       | `%ESC%[96mText%ESC%[0m` |
| <img src="https://img.shields.io/badge/97-White-F5F5F5?style=flat-square&logoColor=black"/> |   `97`    | `ESC[97m`       | `%ESC%[97mText%ESC%[0m` |

---

## Text Formatting

Text attributes can be combined with colour codes to improve readability.

|                                   Preview                                   | ANSI Code | Escape Sequence | Example                |
| :-------------------------------------------------------------------------: | :-------: | --------------- | ---------------------- |
| <img src="https://img.shields.io/badge/0-Normal-6B7280?style=flat-square"/> |    `0`    | `ESC[0m`        | `%ESC%[0m`             |
|  <img src="https://img.shields.io/badge/1-Bold-111827?style=flat-square"/>  |    `1`    | `ESC[1m`        | `%ESC%[1mText%ESC%[0m` |

Formatting options can be combined using semicolons.

```bat
%ESC%[1;92mWindows Power Timer%ESC%[0m
```

The example above displays <font color="#228B22">**bold green**</font> text.

---

## Cursor Control

Cursor positioning allows Windows Power Timer to refresh only the countdown area instead of redrawing the entire console.

|                                     Preview                                      | Escape Sequence       | Description                                                |
| :------------------------------------------------------------------------------: | --------------------- | ---------------------------------------------------------- |
| <img src="https://img.shields.io/badge/H-Move_Cursor-2563EB?style=flat-square"/> | `ESC[<row>;<column>H` | Moves the cursor to the specified row and column.          |
| <img src="https://img.shields.io/badge/2K-Clear_Line-EA580C?style=flat-square"/> | `ESC[2K`              | Clears the current line before writing new content.        |
|   <img src="https://img.shields.io/badge/0m-Reset-16A34A?style=flat-square"/>    | `ESC[0m`              | Resets all colours and formatting to the console defaults. |

---

## Implementation

The following sequences are used by the countdown screen.

| Escape Sequence | Purpose                                                   |
| --------------- | --------------------------------------------------------- |
| `ESC[13;1H`     | Move the cursor to the **Remaining Time** line.           |
| `ESC[14;1H`     | Move the cursor to the **Progress** line.                 |
| `ESC[15;1H`     | Move the cursor below the progress bar after each update. |
| `ESC[2K`        | Clear the current line before writing updated content.    |
| `ESC[0m`        | Reset colours after every coloured output.                |

The countdown is refreshed using these sequences instead of repeatedly calling `cls`, significantly reducing screen flickering.

---

## Example From The Project

The following code updates the countdown in place.

```bat
echo %ESC%[13;1H%ESC%[2KRemaining Time : %ESC%[1;%timeColor%m%formattedTime%%ESC%[0m
echo %ESC%[14;1H%ESC%[2KProgress       : %progressBar% %percent%%%
<nul set /p "=%ESC%[15;1H"
```

---

## Where It's Used

ANSI escape sequences are primarily used in the following modules.

| Module                                                  | Purpose                                                                                     |
| ------------------------------------------------------- | ------------------------------------------------------------------------------------------- |
| [`functions/ui.bat`](../functions/ui.bat)               | Colours the main menu, headings and status messages.                                        |
| [`functions/countdown.bat`](../functions/countdown.bat) | Updates the countdown timer, progress bar and cursor position without clearing the console. |

The application only uses ANSI sequences where they improve the terminal experience, while the rest of the project relies on standard Windows Batch commands to remain lightweight and portable.
