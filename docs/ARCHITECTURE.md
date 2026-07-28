# Architecture

Windows Power Timer follows a modular architecture where each Batch script has a clearly defined responsibility. The application is divided into reusable components for input validation, time parsing, formatting, countdown management and power actions, reducing duplication and keeping the codebase easy to maintain.

The following diagram provides a high-level overview of how the different modules interact during execution.

---

## Overview

            PowerTimer.bat
                  │
                  ▼
              ui.bat
                  │
                  ▼
          validator.bat
                  │
                  ▼
        instructions.bat
                  │
                  ▼
            parser.bat
                  │
                  ▼
          countdown.bat
            │         │
            │         ├────────► formatter.bat
            │                      │
            │                      ▼
            │              calculateTime
            │              formatClock
            │
            ├────────► progressbar.bat
            │
            ▼
    actions/<action>.bat
            │
            ├── shutdown.bat
            ├── restart.bat
            ├── sleep.bat
            ├── hibernate.bat
            ├── lock.bat
            └── logoff.bat

---

## Entry Point

[`PowerTimer.bat`](../PowerTimer.bat) is the entry point of the application. It coordinates the execution flow by calling the project's modules in sequence.

The script:

1. Initialises the application environment.
2. Verifies that it is running with Administrator privileges.
3. Displays the main menu by calling [`functions/ui.bat`](../functions/ui.bat).
4. Shows the instructions screen through [`functions/instructions.bat`](../functions/instructions.bat).
5. Reads and parses the supplied duration using [`functions/parser.bat`](../functions/parser.bat).
6. Starts the live countdown via [`functions/countdown.bat`](../functions/countdown.bat).
7. Executes the selected power action from the [`actions/`](../actions/) directory.

---

## Functions

### [`ui.bat`](../functions/ui.bat)

Displays the application's main menu, presents the available power actions and captures the user's selection before handing control back to the main application flow.

### [`validator.bat`](../functions/validator.bat)

Checks whether the current system supports Sleep mode by reading the output of `powercfg /a`. The result is stored in the `sleepSupported` variable and is used by the application to determine whether the Sleep option should be available.

---

### [`parser.bat`](../functions/parser.bat)

Converts the duration entered by the user into a total number of seconds. The parser accepts multiple human-friendly formats, normalises common unit names and validates each component before calculating the final duration.

Supported examples:

```text
30s
15m
2h
1h 30m
2h 15m 45s
```

---

### [`formatter.bat`](../functions/formatter.bat)

Formats time values used throughout the application. It generates the human-readable duration displayed in the summary screen, the live `HH:MM:SS` countdown and the expected execution time shown before the countdown begins.

---

### [`countdown.bat`](../functions/countdown.bat)

Controls the live countdown once the timer has been started. During execution it updates the remaining time, refreshes the progress bar, changes the countdown colour based on the remaining duration and invokes the selected power action when the timer expires.

---

### [`progressbar.bat`](../functions/progressbar.bat)

Calculates the current completion percentage based on the elapsed time and generates the progress bar displayed during the countdown.

---

### [`instructions.bat`](../functions/instructions.bat)

Displays the instructions shown before the timer starts, including the selected action, supported time units, accepted input formats and usage tips.

## Actions

Each power operation is implemented in its own script.

```text
actions/
```

| Script        | Action    |
| ------------- | --------- |
| shutdown.bat  | Shutdown  |
| restart.bat   | Restart   |
| sleep.bat     | Sleep     |
| hibernate.bat | Hibernate |
| lock.bat      | Lock      |
| logoff.bat    | Log Off   |

Keeping actions isolated makes it easy to add new operations without affecting the rest of the application.

---

## Design Principles

Windows Power Timer was built around a few simple principles that influenced both its implementation and project structure.

- **Single-purpose modules** – Each script focuses on one responsibility, whether it's parsing input, formatting output or performing a power operation.
- **Modular design** – Shared functionality is grouped under the [`functions/`](../functions/) directory, reducing duplication and making individual components reusable.
- **Native Windows tools** – The application relies only on Batch scripting and commands already available in Windows, with no external dependencies.
- **Readable code** – Scripts follow a consistent structure and naming convention to make them easier to navigate and maintain.
- **Simple to extend** – New power actions or helper modules can be added without significantly changing the existing codebase.

---

## Extending the Project

The project has been structured so that new power operations can be added with minimal changes.

In most cases, adding a new action involves:

1. Creating a new script in the [`actions/`](../actions/) directory.
2. Registering the new option in [`functions/ui.bat`](../functions/ui.bat).
3. Updating the help text in [`functions/instructions.bat`](../functions/instructions.bat).
4. Adding any required validation in [`functions/validator.bat`](../functions/validator.bat), if the action depends on system capabilities.

Since input parsing, formatting and the countdown are handled by [`functions/parser.bat`](../functions/parser.bat), [`functions/formatter.bat`](../functions/formatter.bat) and [`functions/countdown.bat`](../functions/countdown.bat), these modules typically do not require modification when introducing a new power action.
