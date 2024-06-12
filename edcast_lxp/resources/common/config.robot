*** Settings ***
Library  	SeleniumLibrary              ${TIMEOUT}
Library	 	Collections
Library		String
Library 	OperatingSystem
Library     BuiltIn
Library		DateTime

*** Variables ***
#${IMAGE_COMPARATOR_COMMAND}   /opt/homebrew/Cellar/imagemagick/7.1.1-33/bin/convert expected_image_path tested_image_path -metric RMSE -compare -format  "%[distortion]" info:
${IMAGE_COMPARATOR_COMMAND}   /usr/local/Cellar/imagemagick/7.1.1-33/bin/magick expected_image_path tested_image_path -metric RMSE -compare -format  "%[distortion]" info:
${TIMEOUT}			          60s
${DEFAULT_LOG_LEVEL}	      INFO
${BROWSER}                    chrome
${USE_PROXY}                  ${False}
${SELENIUM_GRID_HUB}          http://localhost:4444
#{SELENIUM_GRID_HUB}          https://demo:demo@carina01-qa.edcastqa.com/selenoid/wd/hub
${FF_PROFILE}                 ${Empty}

${LOG_DIR}                    ${EXECDIR}/edcast_lxp/output
