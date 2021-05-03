
add_executable(sandbox EXCLUDE_FROM_ALL "sandbox.cpp" )

target_link_libraries(sandbox PUBLIC LibTest)

if( BUILD_SHARED_LIBS )
	# Add post-build command to copy shared library to sandbox output directory.
	message(DEBUG "Adding sandbox post-build copy of shared lib.")
	add_custom_command(TARGET sandbox POST_BUILD
		COMMAND ${CMAKE_COMMAND} -E copy 
			$<TARGET_FILE:LibTest>
			$<TARGET_FILE_DIR:sandbox>
	)
endif()
