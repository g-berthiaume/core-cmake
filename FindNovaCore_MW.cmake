IF( NOT NOVA_CORE_MW_ROOT )
  IF( NOT NOVA_ROOT )
    SET( NOVA_CORE_MW_ROOT /opt/nova/middleware )
  ELSE()
    SET( NOVA_CORE_MW_ROOT ${NOVA_ROOT}/core-mw )
  ENDIF()

  MESSAGE( STATUS "No NOVA_CORE_MW_ROOT specified, using default: ${NOVA_CORE_MW_ROOT}" )
ENDIF()

SET( NOVA_CORE_MW_SOURCES
  ${NOVA_CORE_MW_ROOT}/src/core-mw.cpp
  
  ${NOVA_CORE_MW_ROOT}/src/impl/ArrayQueue_.cpp
  ${NOVA_CORE_MW_ROOT}/src/impl/SimplePool_.cpp
  ${NOVA_CORE_MW_ROOT}/src/impl/StaticList_.cpp
  ${NOVA_CORE_MW_ROOT}/src/impl/StaticQueue_.cpp
  ${NOVA_CORE_MW_ROOT}/src/BasePublisher.cpp
  ${NOVA_CORE_MW_ROOT}/src/BaseSubscriber.cpp
  ${NOVA_CORE_MW_ROOT}/src/BaseSubscriberQueue.cpp
  ${NOVA_CORE_MW_ROOT}/src/BootloaderMaster.cpp
  ${NOVA_CORE_MW_ROOT}/src/BootMsg.cpp
  ${NOVA_CORE_MW_ROOT}/src/Checksummer.cpp
  ${NOVA_CORE_MW_ROOT}/src/LocalPublisher.cpp
  ${NOVA_CORE_MW_ROOT}/src/LocalSubscriber.cpp
  ${NOVA_CORE_MW_ROOT}/src/MessagePtrQueue.cpp
  ${NOVA_CORE_MW_ROOT}/src/Message.cpp
  ${NOVA_CORE_MW_ROOT}/src/Middleware.cpp
  ${NOVA_CORE_MW_ROOT}/src/Node.cpp
  ${NOVA_CORE_MW_ROOT}/src/RemotePublisher.cpp
  ${NOVA_CORE_MW_ROOT}/src/RemoteSubscriber.cpp
  ${NOVA_CORE_MW_ROOT}/src/RPC.cpp
  ${NOVA_CORE_MW_ROOT}/src/TimestampedMsgPtrQueue.cpp
  ${NOVA_CORE_MW_ROOT}/src/Topic.cpp
  ${NOVA_CORE_MW_ROOT}/src/Transport.cpp
  ${NOVA_CORE_MW_ROOT}/src/Utils.cpp
  
  ${NOVA_CORE_MW_ROOT}/src/CoreNode.cpp
  ${NOVA_CORE_MW_ROOT}/src/CoreNodeManager.cpp
  ${NOVA_CORE_MW_ROOT}/src/CoreConfiguration.cpp
  ${NOVA_CORE_MW_ROOT}/src/CoreConfigurationManager.cpp
  ${NOVA_CORE_MW_ROOT}/src/CoreModule.cpp
  
  ${NOVA_CORE_MW_ROOT}/src/UID.cpp

  ${NOVA_CORE_MW_ROOT}/port/chibios/src/impl/Middleware_.cpp
)

SET( NOVA_CORE_MW_INCLUDE_DIRS
  ${NOVA_CORE_MW_ROOT}/include
  ${NOVA_CORE_MW_ROOT}/port/chibios/include
)

IF( CORE_USE_RTCANTRANSPORT )
  FIND_PACKAGE( NovaCore_Transport_RTCAN REQUIRED)
  LIST( APPEND NOVA_CORE_MW_SOURCES ${NOVA_CORE_TRANSPORT_RTCAN_SOURCES} )
  LIST( APPEND NOVA_CORE_MW_INCLUDE_DIRS ${NOVA_CORE_TRANSPORT_RTCAN_INCLUDE_DIRS} )
ENDIF()

IF( CORE_USE_DEBUGTRANSPORT )
  FIND_PACKAGE( NovaCore_Transport_Debug REQUIRED)
  LIST( APPEND NOVA_CORE_MW_SOURCES ${NOVA_CORE_TRANSPORT_DEBUG_SOURCES} )
  LIST( APPEND NOVA_CORE_MW_INCLUDE_DIRS ${NOVA_CORE_TRANSPORT_DEBUG_INCLUDE_DIRS} )
ENDIF()

IF( NOVA_CORE_MW_SOURCES )
  LIST( REMOVE_DUPLICATES NOVA_CORE_MW_SOURCES )
ENDIF()

IF( NOVA_CORE_MW_INCLUDE_DIRS )
  LIST( REMOVE_DUPLICATES NOVA_CORE_MW_INCLUDE_DIRS )
ENDIF()

INCLUDE( FindPackageHandleStandardArgs )
FIND_PACKAGE_HANDLE_STANDARD_ARGS( NovaCore_MW DEFAULT_MSG NOVA_CORE_MW_SOURCES NOVA_CORE_MW_INCLUDE_DIRS )
