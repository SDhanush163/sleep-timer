# Troubleshooting

Most issues can be traced back to terminal compatibility, Windows power settings, or an invalid timer input. This guide covers the problems you're most likely to encounter and where to start looking.

---

## The application exits immediately

If the window opens and closes before you can read the error, launch the script from an existing Command Prompt instead of double-clicking it.

```cmd
PowerTimer.bat
```

The console will remain open, making it easier to identify Batch syntax errors or missing files.

Things to verify:

- All project folders are present.
- No Batch files have been renamed.
- The project structure matches the repository.

---

## Administrator privileges are required

Shutdown, restart, sleep and hibernate are Windows power operations and may require elevated privileges.

Run the application from an **Administrator Command Prompt**.

If the privilege check fails unexpectedly, verify that:

- User Account Control (UAC) isn't blocking elevation.
- The terminal was opened using **Run as administrator**.

---

## ANSI colours or formatting are missing

Windows Power Timer relies on ANSI escape sequences for coloured output and the live countdown display.

If colours are missing or escape sequences appear as plain text:

- Use **Windows Terminal**, or
- Use the modern Command Prompt included with Windows 10 or Windows 11.

Older console hosts may not fully support ANSI escape sequences.

---

## The countdown freezes or doesn't refresh

The countdown updates only a small section of the console instead of redrawing the entire window.

If the timer stops refreshing:

- Verify `functions/countdown.bat` is being called.
- Check `functions/formatter.bat` for formatting errors.
- Check `functions/progressbar.bat` if the progress bar is not updating.
- Confirm the parsed duration is greater than zero.

---

## Sleep or Hibernate doesn't work

Windows can disable these power states depending on hardware or system configuration.

To enable hibernation:

```cmd
powercfg /hibernate on
```

To check which power states are available:

```cmd
powercfg /a
```

If Sleep is unavailable, Windows Power Timer will automatically disable that option in the menu.

---

## Invalid duration

Timer values must include a unit.

Supported formats include:

```text
30s
10m
2h
1h 30m
2h 15m 45s
```

Units are not case-sensitive, so both `30M` and `30m` are accepted.

---

## Sleep isn't available in the menu

Before displaying the menu, Windows Power Timer checks whether your system supports the Sleep state.

If Sleep isn't shown, it's because Windows reported that the feature isn't available on your machine.

To view the available power states:

```cmd
powercfg /a
```

---

## Still having problems?

If you find a bug that isn't covered here, please open an issue and include the following information:

- Windows version
- Terminal application (Command Prompt or Windows Terminal)
- The timer value you entered
- Steps to reproduce the problem
- Expected behaviour
- Actual behaviour
- Screenshots or error messages, if available
