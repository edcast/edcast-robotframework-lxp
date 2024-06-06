*** Settings ***
Library  	SeleniumLibrary              ${TIMEOUT}
Library	 	Collections
Library		String
Library 	OperatingSystem
Library     BuiltIn
Library		DateTime

*** Variables ***
${TIMEOUT}			          60s
${DEFAULT_LOG_LEVEL}	      INFO
${BROWSER}                    gc
${USE_PROXY}                  ${False}
${SELENIUM_GRID_HUB}          http://localhost:4444
${FF_PROFILE}                 ${Empty}

${LOG_DIR}                    ${EXECDIR}/edcast_lxp/output