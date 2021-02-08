## Commit Formatter

Tiny script used with [Left Hook + Git Prepare Commit Msg](https://github.com/Arkweid/lefthook) to allow change/format Github commit messages before real commit `pre-commit`.

## Usage

Import `CommitlintFormatter` and use `.formatThis()` to format commit message

```dart
void main() {
  final commmitlintFormatter = CommitlintFormatter();

  final rawCommit = 'fix, backend, this closes #40';

  final formattedCommit = commmitlintFormatter.formatThis(rawCommit);

  print(formattedCommit); // 🐛 Fix(Backend): This closes #40

  // Note, you can also use `Fix`|`Feat`|`Docs`|`Chore`|`Test` commmit types
}
```

## Custom behavior

Note that `CommitlintFormatter` class is limited: you cannot edit emojis or the template, so, you can create you own `Formatter`.

While `CommitlintFormatter` uses `type`, `scope`, `subject` and `emoji` fields, you can too use anything else:

```dart
class MyCustomFormatter extends CommitFormatter {
  @override
  Map<String, String> getFields(String rawCommit) {
    // rawCommit is the commit that you typed in terminal
    // Consider rawCommit = 'Blue Orange'

    final myCustomFields = rawCommit.split(' ');

    // You can return a map to use to fill your template after
    return <String, String>{
      'FIRST_COLOR': myCustomFields[0], // 'Blue'
      'SECOND_COLOR': myCustomFields[1], // 'Orange'
    };
  }

  @override
  String getCommitTemplate(Map<String, String> fields) {
    return 'My favorite color is FIRST_COLOR, but I also like SECOND_COLOR';
  }
}
```

Now, you can use your `MyCustomFormatter`:

```dart
void main() {
  final myFormatter = MyCustomFormatter();

  final rawCommit = 'Red Purple';

  final formattedCommit = myFormatter.formatThis(rawCommit);

  print(formattedCommit); // 'My favorite color is Red, but I also like Purple'
}
```

<sub>**Thx**</sub>
