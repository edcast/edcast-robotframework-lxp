*** Settings ***

Documentation  https://github.com/NaviNet-OSS/robotframework-excellibrary/blob/master/doc/ChangeLog.txt

Library       ExcelLibrary

*** Keywords ***

Read Excel file
    [Arguments]      ${file_path}      ${sheet_name}      ${row_number}      ${coloumn_number}
  	Open Excel Document          ${file_path}
    