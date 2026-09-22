{
  # A GitHub identity with no directories is the machine's default: it's
  # wired to the bare `github.com` SSH host rather than an aliased one, and
  # needs no git `includeIf` rewrite since it's already what
  # `git@github.com:` resolves to.
  isDefaultIdentity = identity: identity.directories == [];
}
