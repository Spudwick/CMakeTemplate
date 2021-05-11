macro(get_version_from_header)
	# Create lists of Arguments.
	set(singleValArgs FILE PREFIX)
	# Parse macro arguments to VER_**.
	cmake_parse_arguments(VER "${options}" "${singleValArgs}" "${multiValArgs}" ${ARGN})

    message(DEBUG "Checking header file '${VER_FILE}' for version number.")

    file(READ ${VER_FILE} ver_hdr)

    # TODO : Make this ignore the version number if it is commented out in the version header.

    string(REGEX MATCH "#define[ \t]+VERSION_MAJOR[ \t]+([0-9]*)" _ ${ver_hdr})
    if( CMAKE_MATCH_1 )
        set(${VER_PREFIX}_VER_MAJOR ${CMAKE_MATCH_1})
    else()
        set(${VER_PREFIX}_VER_MAJOR 0)
    endif()

    string(REGEX MATCH "#define[ \t]+VERSION_MINOR[ \t]+([0-9]*)" _ ${ver_hdr})
    if( CMAKE_MATCH_1 )
        set(${VER_PREFIX}_VER_MINOR ${CMAKE_MATCH_1})
    else()
        set(${VER_PREFIX}_VER_MINOR 0)
    endif()

    string(REGEX MATCH "#define[ \t]+VERSION_PATCH[ \t]+([0-9]*)" _ ${ver_hdr})
    if( CMAKE_MATCH_1 )
        set(${VER_PREFIX}_VER_PATCH ${CMAKE_MATCH_1})
    else()
        set(${VER_PREFIX}_VER_PATCH 0)
    endif()

    string(REGEX MATCH "#define[ \t]+VERSION_TWEAK[ \t]+([0-9]*)" _ ${ver_hdr})
    if( CMAKE_MATCH_1 )
        set(${VER_PREFIX}_VER_TWEAK ${CMAKE_MATCH_1})
    else()
        set(${VER_PREFIX}_VER_TWEAK 0)
    endif()

    message(DEBUG "Got version ${${VER_PREFIX}_VER_MAJOR}.${${VER_PREFIX}_VER_MINOR}.${${VER_PREFIX}_VER_PATCH}.${${VER_PREFIX}_VER_TWEAK} from header file.")
endmacro(get_version_from_header)