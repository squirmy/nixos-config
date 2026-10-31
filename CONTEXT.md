# nixos-config

Personal machine configuration: a declarative description of how each of this user's machines should be set up, covering system defaults, developer tooling, and account credentials.

## Language

**GitHub identity**:
A named SSH key paired with the set of directories that should authenticate as it. A machine can have several, and each machine's set is independent of the others.
_Avoid_: account, profile.

**Default identity**:
The GitHub identity a machine falls back to everywhere it hasn't been told otherwise. A machine has at most one. Plain `git@github.com:` remotes and SSH connections already resolve to it, so it needs no explicit routing.
_Avoid_: primary identity, main account.

**Scoped identity**:
A GitHub identity that only applies inside specific directories, and is otherwise inactive on that machine.
_Avoid_: secondary identity, work account.
