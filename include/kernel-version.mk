# Use the default kernel version if the Makefile doesn't override it

LINUX_RELEASE?=1

LINUX_VERSION-3.8  = .13
LINUX_VERSION-3.10 = .58
LINUX_VERSION-3.13 = .7
LINUX_VERSION-3.14 = .32
LINUX_VERSION-3.18 = .7
LINUX_VERSION-3.19 = 
LINUX_VERSION-4.0 = -rc1

LINUX_KERNEL_MD5SUM-3.8.13  = 2af19d06cd47ec459519159cdd10542d
LINUX_KERNEL_MD5SUM-3.10.58 = 3ff3478b6351143cef22d4b81cf48b01
LINUX_KERNEL_MD5SUM-3.13.7  = 370adced5e5c1cb1d0d621c2dae2723f
LINUX_KERNEL_MD5SUM-3.14.32 = 3178fb8f6f1eafcffdd730fec68754f8
LINUX_KERNEL_MD5SUM-3.18.7  = b4ff3e1d591f7464e678c43d421c85fc
LINUX_KERNEL_MD5SUM-3.19    = d3fc8316d4d4d04b65cbc2d70799e763
LINUX_KERNEL_MD5SUM-4.0-rc1 = 547b340dca94d358b68d2658822080fa

ifdef KERNEL_PATCHVER
  LINUX_VERSION:=$(KERNEL_PATCHVER)$(strip $(LINUX_VERSION-$(KERNEL_PATCHVER)))
endif

split_version=$(subst ., ,$(1))
merge_version=$(subst $(space),.,$(1))
KERNEL_BASE=$(firstword $(subst -, ,$(LINUX_VERSION)))
KERNEL=$(call merge_version,$(wordlist 1,2,$(call split_version,$(KERNEL_BASE))))
KERNEL_PATCHVER ?= $(KERNEL)

# disable the md5sum check for unknown kernel versions
LINUX_KERNEL_MD5SUM:=$(LINUX_KERNEL_MD5SUM-$(strip $(LINUX_VERSION)))
LINUX_KERNEL_MD5SUM?=x
