SET(CHIBIOS_CONTRIB_MODULES hal_timcap)

SET(CHIBIOS_hal_timcap_SEARCH_PATH ${CHIBIOS_ROOT}/community/os/hal/include ${CHIBIOS_ROOT}/community/os/hal/src)
SET(CHIBIOS_hal_timcap_SOURCES hal_timcap.c)
SET(CHIBIOS_hal_timcap_SEARCH_HEADERS hal_timcap.h)

SET(CHIBIOS_hal_timcap_PLATFORM_SEARCH_PATH ${CHIBIOS_ROOT}/community/os/hal/ports/STM32/LLD/TIMv1)
SET(CHIBIOS_hal_timcap_PLATFORM_SOURCES hal_timcap_lld.c)
SET(CHIBIOS_hal_timcap_PLATFORM_SEARCH_HEADERS hal_timcap_lld.h)

