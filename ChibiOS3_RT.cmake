SET(CHIBIOS_rt_SEARCH_PATH 
  ${CHIBIOS_ROOT}/os/rt/src
  ${CHIBIOS_ROOT}/os/rt/include
  ${CHIBIOS_ROOT}/os/rt/ports/ARMCMx
  ${CHIBIOS_ROOT}/os/rt/ports/ARMCMx/compilers/GCC
  ${CHIBIOS_ROOT}/os/common/ports/ARMCMx/compilers/GCC
  ${CHIBIOS_ROOT}/os/rt/src
)
  
SET(CHIBIOS_rt_SEARCH_HEADERS
  ch.h
  chcore.h
  chtypes.h
)
SET(CHIBIOS_rt_SOURCES  
  crt0_v7m.s
  crt1.c
  vectors.c
  chcore.c
  chcore_v7m.c
  chcoreasm_v7m.s
  chsys.c
  chdebug.c
  chvt.c
  chschd.c
  chthreads.c
  chtm.c
  chstats.c
  chdynamic.c
  chregistry.c
  chsem.c
  chmtx.c
  chcond.c
  chevents.c
  chmsg.c
  chmboxes.c
  chqueues.c
  chmemcore.c
  chheap.c
  chmempools.c
)

IF(STM32_FAMILY STREQUAL "F0")
  SET(CHIBIOS_rt_PLATFORM_SEARCH_PATH
    ${CHIBIOS_ROOT}/os/common/ports/ARMCMx/devices/STM32F0xx
    ${CHIBIOS_ROOT}/os/ext/CMSIS/include
    ${CHIBIOS_ROOT}/os/ext/CMSIS/ST
  )
  SET(CHIBIOS_rt_PLATFORM_SEARCH_HEADERS
    core_cm3.h
    stm32f0xx.h
    cmparams.h
  )
ELSEIF(STM32_FAMILY STREQUAL "F1")
  SET(CHIBIOS_rt_PLATFORM_SEARCH_PATH
    ${CHIBIOS_ROOT}/os/common/ports/ARMCMx/devices/STM32F1xx
    ${CHIBIOS_ROOT}/os/ext/CMSIS/include
    ${CHIBIOS_ROOT}/os/ext/CMSIS/ST
  )
  SET(CHIBIOS_rt_PLATFORM_SEARCH_HEADERS
    core_cm4.h
    stm32f10x.h
    cmparams.h
  )
ELSEIF(STM32_FAMILY STREQUAL "F3")
  SET(CHIBIOS_rt_PLATFORM_SEARCH_PATH
    ${CHIBIOS_ROOT}/os/common/ports/ARMCMx/devices/STM32F3xx
    ${CHIBIOS_ROOT}/os/ext/CMSIS/include
    ${CHIBIOS_ROOT}/os/ext/CMSIS/ST
  )
  SET(CHIBIOS_rt_PLATFORM_SEARCH_HEADERS
    core_cm4.h
    stm32f3xx.h
    cmparams.h
  )
ELSEIF(STM32_FAMILY STREQUAL "F4")
  SET(CHIBIOS_rt_PLATFORM_SEARCH_PATH
    ${CHIBIOS_ROOT}/os/common/ports/ARMCMx/devices/STM32F4xx
    ${CHIBIOS_ROOT}/os/ext/CMSIS/include
    ${CHIBIOS_ROOT}/os/ext/CMSIS/ST
  )
  SET(CHIBIOS_rt_PLATFORM_SEARCH_HEADERS
    core_cm4.h
    stm32f4xx.h
    cmparams.h
  )
ENDIF()