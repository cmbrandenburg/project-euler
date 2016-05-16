ifdef RELEASE
kind = release
with_release = --release
else
kind = debug
endif

solve_target = target/$(kind)/$(notdir $(CURDIR))

.PHONY: all
all: $(solve_target)

.PHONY: clean
clean:
	cargo clean $(with_release)

.PHONY: run
run: $(solve_target)
	$(solve_target)

.PHONY: test
test:
	cargo test $(with_release)

# Always try to rebuild. Otherwise make won't detect source file changes.

.PHONY: $(solve_target)
$(solve_target):
	cargo build --quiet $(with_release)
