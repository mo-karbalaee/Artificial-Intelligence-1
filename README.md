# AI1

Coursework and assignments for AI1.

## Repository layout

```
assignments/
  prolog/
    family.pl    # starter knowledge base: facts, rules, recursion
```

## Prolog

### Setup (macOS)

SWI-Prolog is the implementation used here. Install it with Homebrew:

```bash
brew install swi-prolog
swipl --version      # expect: SWI-Prolog version 10.x for arm64-darwin
```

The binary lands at `/opt/homebrew/bin/swipl` on Apple Silicon.

### Running a program

Prolog is not compile-then-run. You start an interactive REPL, load (*consult*) a
`.pl` file into it, and then pose queries against the loaded knowledge base.
SWI compiles to bytecode internally; there is no separate compiler to invoke.

```bash
cd assignments/prolog
swipl family.pl
```

That opens the REPL with the file loaded. At the `?-` prompt:

```prolog
?- father(hassan, X).      % X = hassan's children, one at a time
?- ancestor(hassan, X).    % recursive query
?- halt.                   % quit
```

- `;` — ask for the next answer
- `Enter` — stop at the current answer
- `Ctrl-D` or `halt.` — leave the REPL

### Running a goal without the REPL

Useful for scripts, CI, or a quick check:

```bash
swipl -q -g "forall(ancestor(hassan,X), (write(X),nl))" -t halt family.pl
```

| Flag | Meaning |
| --- | --- |
| `-q` | suppress the startup banner |
| `-g GOAL` | goal to run after loading |
| `-t halt` | what to do once the goal finishes |

### Reloading after an edit

Do not restart the REPL. Type:

```prolog
?- make.
```

This recompiles only the files that changed.

### Useful REPL commands

| Command | Effect |
| --- | --- |
| `?- listing(father/2).` | print a predicate's current clauses |
| `?- trace.` | step through resolution — the clearest way to see backtracking |
| `?- nodebug.` | leave trace mode |
| `?- help(findall).` | built-in documentation |

### Gotcha worth knowing early

`findall/3` keeps duplicates. In `family.pl`, `sibling/2` succeeds once per
shared parent, so Mohammad and Leila — who share two parents — produce:

```prolog
?- findall(S, sibling(mohammad, S), L).
L = [leila, leila].
```

Use `setof/3` when you want deduplicated, sorted results:

```prolog
?- setof(S, sibling(mohammad, S), L).
L = [leila].
```

### Editor support

For VS Code, the **VSC-Prolog** extension (arthurwang) adds syntax highlighting,
snippets, and loading the current file into a terminal REPL. Optional — `swipl`
plus any editor works.

### Other implementations

- **GNU Prolog** (`brew install gprolog`) — has a true native compiler, `gplc`,
  which produces standalone binaries. Stricter ISO conformance.
- **SICStus Prolog** — commercial; occasionally required in academic settings.

Use SWI unless an assignment specifies otherwise.
