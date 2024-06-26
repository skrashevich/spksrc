###

KERNEL_REQUIRED = $(MAKE) kernel-required
ifeq ($(strip $(KERNEL_REQUIRED)),)
ALL_ACTION = $(sort $(basename $(subst -,.,$(basename $(subst .,,$(ARCHS_WITH_KERNEL_SUPPORT))))))
endif

#### used as subroutine to test whether any dependency has REQUIRE_KERNEL defined

.PHONY: kernel-required
kernel-required:
	@if [ -n "$(REQUIRE_KERNEL)" -o -n "$(REQUIRE_KERNEL_MODULE)" ]; then \
	  exit 1 ; \
	fi
	@for depend in $(BUILD_DEPENDS) $(DEPENDS) ; do \
	  if $(MAKE) --no-print-directory -C ../../$$depend kernel-required >/dev/null 2>&1 ; then \
	    exit 0 ; \
	  else \
	    exit 1 ; \
	  fi ; \
	done

####
