part of terminal_widget;

List<Widget> windowController() {
  return [
    MinimizeWindowButton(colors: buttonColors),
    MaximizeWindowButton(colors: buttonColors),
    CloseWindowButton(
      colors: closeButtonColors,
    ),
  ];
}
