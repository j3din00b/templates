# To run these commands, read CONTRIBUTING.md

# Affects authoring this Justfile:
# https://github.com/casey/just?tab=readme-ov-file#positional-arguments
set positional-arguments

# List all available commands when running `just` without arguments
_default:
  @just --list

# After making some changes, run this to create fixup commits
[no-cd]
absorb-prepare:
    @echo You were on: $(git rev-parse --short HEAD)
    git absorb -b $(git rev-list --max-parents=0 HEAD)
    @echo Now review the fixup commits via your favorite '`git log`' variant.
    @echo Then run '`just absorb-rebase`'
    @echo Any uncommited changes cannot be absorbed and you need to absorb them manually via '`git rebase -i --root`'

# After running `just absorb-prepare`, run this to squash the fixup commits
[no-cd]
absorb-rebase:
    GIT_SEQUENCE_EDITOR=true git rebase -i --root --autosquash

# How to revert after absorb-prepare
[no-cd]
absorb-revert:
    @echo Run '`git reset --soft <the commit hash of you were on>`'

# Commit a template change in the `templates` repo
commit message:
    git add template-*
    git commit -m "$1"

[no-cd]
[no-exit-message]
template-publish:
    @echo Publishing $(echo "{{invocation_directory()}}" | sed "s|^{{justfile_directory()}}/||")...

    @read -p "Do you want to immediately publish this version of the template? [Y/n] " answer; \
    if [ "$answer" = "y" ] || [ "$answer" = "Y" ] || [ "$answer" = "" ]; then \
        git push -f https://github.com/get-convex/$(echo "{{invocation_directory()}}" | sed "s|^{{justfile_directory()}}/||") HEAD:main; \
    else \
        echo "Not publishing."; exit 1; \
    fi
