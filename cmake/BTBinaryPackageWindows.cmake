IF(WIN32 AND NOT UNIX)

    # Libs needed for packaging
    FIND_PACKAGE(ZLIB REQUIRED)
    FIND_PACKAGE(CURL REQUIRED)
    FIND_PACKAGE(Sword REQUIRED)

    SET(CPACK_PACKAGE_NAME "BibleTime")
    SET(CPACK_PACKAGE_DESCRIPTION_SUMMARY "BibleTime for Windows")
    SET(CPACK_PACKAGE_VENDOR "https://bibletime.info")
    SET(CPACK_PACKAGE_VERSION_MAJOR ${PROJECT_VERSION_MAJOR})
    SET(CPACK_PACKAGE_VERSION_MINOR ${PROJECT_VERSION_MINOR})
    SET(CPACK_PACKAGE_VERSION_PATCH ${PROJECT_VERSION_PATCH})
    SET(CPACK_PACKAGE_INSTALL_DIRECTORY "BibleTime")

    SET(CPACK_RESOURCE_FILE_LICENSE "${CMAKE_CURRENT_SOURCE_DIR}/LICENSE")

    # We need the libraries, and they're not pulled in automatically
    SET(CMAKE_INSTALL_DEBUG_LIBRARIES TRUE)

    SET(QT_BINARY_DIR "${QT_DIR}/../../../bin")
    INSTALL(DIRECTORY
        "${QT_BINARY_DIR}/../translations"
        DESTINATION "${BT_BINDIR}"
        CONFIGURATIONS "Release"
    )

    FIND_PROGRAM(QT_WINDEPLOYQT_EXECUTABLE windeployqt HINTS "${QT_BIN_DIR}")
    MESSAGE(STATUS "Running ${QT_WINDEPLOYQT_EXECUTABLE}")
    INSTALL(CODE "EXECUTE_PROCESS(COMMAND ${QT_WINDEPLOYQT_EXECUTABLE} -qmldir \"${CMAKE_CURRENT_SOURCE_DIR}/src/frontend/display/modelview/\"    \"\${CMAKE_INSTALL_PREFIX}/bin/bibletime.exe\") ")

    IF(CMAKE_BUILD_TYPE STREQUAL "Debug")
        SET(ZLIB_LIBRARY ${ZLIB_LIBRARY_DEBUG})
    ELSE()
        SET(ZLIB_LIBRARY ${ZLIB_LIBRARY_RELEASE})
    ENDIF()

    SET(ICU_DT_DLL ${CMAKE_INSTALL_PREFIX}/bin/icudt74.dll) 
    MESSAGE(STATUS  "INSTALL icudt_DLL ${ICU_DT_DLL}" )
    INSTALL(FILES ${ICU_DT_DLL} DESTINATION ${BT_BINDIR})

    SET(ICU_IN_DLL ${CMAKE_INSTALL_PREFIX}/bin/icuin74.dll) 
    MESSAGE(STATUS  "INSTALL icuin_DLL ${ICU_IN_DLL}" )
    INSTALL(FILES ${ICU_IN_DLL} DESTINATION ${BT_BINDIR})

    SET(ICU_IO_DLL ${CMAKE_INSTALL_PREFIX}/bin/icuio74.dll) 
    MESSAGE(STATUS  "INSTALL icuio_DLL ${ICU_IO_DLL}" )
    INSTALL(FILES ${ICU_IO_DLL} DESTINATION ${BT_BINDIR})

    SET(ICU_TU_DLL ${CMAKE_INSTALL_PREFIX}/bin/icutu74.dll) 
    MESSAGE(STATUS  "INSTALL icutu_DLL ${ICU_TU_DLL}" )
    INSTALL(FILES ${ICU_TU_DLL} DESTINATION ${BT_BINDIR})

    SET(ICU_UC_DLL ${CMAKE_INSTALL_PREFIX}/bin/icuuc74.dll) 
    MESSAGE(STATUS  "INSTALL icuuc_DLL ${ICU_UC_DLL}" )
    INSTALL(FILES ${ICU_UC_DLL} DESTINATION ${BT_BINDIR})

    MESSAGE(STATUS  "INSTALL Zlib_LIBRARY ${ZLIB_LIBRARY}" )
    STRING(REPLACE ".lib" ".dll" ZLIB_DLL "${ZLIB_LIBRARY}")
    INSTALL(FILES ${ZLIB_DLL} DESTINATION ${BT_BINDIR})

    MESSAGE(STATUS  "INSTALL CLucene_LIBRARY ${CLucene_LIBRARY}" )
    STRING(REPLACE ".lib" ".dll" CLUCENE_DLL "${CLucene_LIBRARY}")
    INSTALL(FILES ${CLUCENE_DLL} DESTINATION ${BT_BINDIR})

    MESSAGE(STATUS  "INSTALL CLucene_LIBRARY ${CLucene_SHARED_LIB}" )
    STRING(REPLACE ".lib" ".dll" CLUCENE_SHARED_DLL "${CLucene_SHARED_LIB}")
    INSTALL(FILES ${CLUCENE_SHARED_DLL} DESTINATION ${BT_BINDIR})

    MESSAGE(STATUS  "INSTALL CURL_LIBRARY ${CURL_LIBRARY}" )
    STRING(REPLACE "_imp.lib" ".dll" CURL_DLL "${CURL_LIBRARY}")
    INSTALL(FILES ${CURL_DLL} DESTINATION ${BT_BINDIR})

    SET(SWORD_DLL "${Sword_LIBRARY_DIRS}/sword.dll")
    MESSAGE(STATUS  "INSTALL SWORD_LIBRARY ${SWORD_DLL}" )
    INSTALL(FILES ${SWORD_DLL} DESTINATION ${BT_BINDIR})

    # Some options for the CPack system.  These should be pretty self-evident
    SET(CPACK_PACKAGE_ICON "${CMAKE_CURRENT_SOURCE_DIR}\\\\pics\\\\icons\\\\bibletime.png")
    SET(CPACK_NSIS_INSTALLED_ICON_NAME "bin\\\\bibletime.exe")
    SET(CPACK_NSIS_DISPLAY_NAME "${CPACK_PACKAGE_INSTALL_DIRECTORY}")
    SET(CPACK_NSIS_HELP_LINK "https:\\\\\\\\bibletime.info")
    SET(CPACK_NSIS_URL_INFO_ABOUT "https:\\\\\\\\bibletime.info")
    SET(CPACK_NSIS_CONTACT "bt-devel@crosswire.org")
    SET(CPACK_NSIS_MODIFY_PATH OFF)
    SET(CPACK_GENERATOR "NSIS")

    SET(CPACK_PACKAGE_EXECUTABLES "bibletime" "BibleTime")

    # This adds in the required Windows system libraries
    MESSAGE(STATUS  "INSTALL Microsoft Redist ${MSVC_REDIST}" )
    SET(CPACK_NSIS_EXTRA_INSTALL_COMMANDS "
        ExecWait \\\"$INSTDIR\\\\bin\\\\vcredist_x86.exe  /q\\\"
        Delete   \\\"$INSTDIR\\\\bin\\\\vcredist_x86.exe\\\"
    ")

    INCLUDE(CPack)

ENDIF(WIN32 AND NOT UNIX)

