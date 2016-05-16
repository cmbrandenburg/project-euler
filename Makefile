SHELL=bash

solutions = $(shell ls | grep '^pe-[0-9]\+$$' | sed -e s/^pe-// | sort -n | sed -e s/^/pe-/)

solutions_clean = $(addprefix .clean_, $(solutions))
solutions_print = $(addprefix .print_, $(solutions))
solutions_run = $(addprefix .run_, $(solutions))
solutions_test = $(addprefix .test_, $(solutions))
solutions_time = $(addprefix .time_, $(solutions))

.PHONY: all
all: run

.PHONY: clean
clean: $(solutions_clean)

.PHONY: run
run: $(solutions_print)
	@ \
	pass=$$(ls -a | grep '^\.pe-[[:digit:]]\+\.pass$$' | wc -l) && \
	fail=$$(ls -a | grep '^\.pe-[[:digit:]]\+\.fail$$' | wc -l) && \
	if test "$$fail" != "0"; then \
		echo "$$fail of $$(($$pass + $$fail)) solutions failed"; \
	fi

.PHONY: test
test: $(solutions_test)

.PHONY: time
time: .time_all

# ------------------------------------------------------------------------------

.PHONY: $(solutions_clean)
$(solutions_clean): .clean_%:
	$(MAKE) -C $* clean

.PHONY: $(solutions_print)
$(solutions_print): .print_%: .run_%
	@ \
	exp=$$(grep "$*:" answers | awk '{ print $$2 }') && \
	got=$$(<.$*.out) && \
	echo -n "$*: " && \
	if test "$$exp" = "$$got"; then \
		echo "$$got" && \
		echo >.$*.pass; \
	else \
		echo "FAIL (expected $$exp, got $$got)" && \
		echo >.$*.fail; \
	fi

.PHONY: .run_prep
.run_prep:
	@rm -f .pe-*.out .pe-*.fail

.PHONY: $(solutions_run)
$(solutions_run): .run_%: .run_prep
	@ \
	TIMEFORMAT=%3R && \
	(time $(MAKE) --quiet -C $* run >.$*.out) 2>.$*.time

.PHONY: $(solutions_test)
$(solutions_test): .test_%:
	$(MAKE) -C $* test

name_len=8
time_len=8
time_fmt=%$(time_len).3f
ans_pad_len=2

.PHONY: .time_all
.time_all: .run_prep
	@ \
	$(MAKE) --quiet clean && \
	parse() { \
		printf "%-$(name_len)s%$(time_len)s%$(time_len)s%$(ans_pad_len)sANSWER\n" "" RUN FULL "" && \
		total_run_t=0 && \
		total_full_t=0 && \
		while read t name ans; do \
			if echo $$name | grep -q '^pe-[[:digit:]]\+:$$'; then \
				pbase=$$(echo $$name | sed -e 's/:$$//') && \
				full_t=$$(echo $$t-$$prev_t | bc | sed -e 's/^\./0./') && \
				run_t=$$(<.$$pbase.time) && \
				printf "%-$(name_len)s$(time_fmt)$(time_fmt)%$(ans_pad_len)s%s\n" "$$pbase:" $$run_t $$full_t "" "$$ans" && \
				total_full_t=$$(echo $$total_full_t + $$full_t | bc) && \
				total_run_t=$$(echo $$total_run_t + $$run_t | bc) && \
				prev_t=$$t; \
			fi \
		done && \
		printf "%-$(name_len)s$(time_fmt)$(time_fmt)\n" "TOTAL:" $$total_run_t $$total_full_t; \
	} && \
	prev_t=$$(echo | ts %.s) && \
	$(MAKE) --quiet .time_all_no_prep | ts %.s | parse

.PHONY: .time_all_no_prep
.time_all_no_prep: $(solutions_print)

.SECONDEXPANSION:

print_car = $(firstword $(solutions_print))
$(print_car):

print_cdr = $(wordlist 2, $(words $(solutions_print)), $(solutions_print))
$(print_cdr): .print_%: $$(shell echo $$(solutions_print) | tr -s '[[:space:]]' '\n' | grep -B1 $$* | head -n1)
