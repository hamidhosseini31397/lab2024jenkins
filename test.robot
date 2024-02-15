*** Settings ***
Library    SeleniumLibrary
#Dölj password i logfil/kryptera plugin?
#Negativa test för ogiltliga datum, längre än 1 månad framåt i tiden, bokning som är längre än 1 månad
#efter create user, använd login istället
#Negativa tester med fel datum och fel lösenord
 
######################################BREAKFORBETTERVISABILITY#########################################################
 
*** Variables ***
#Browsers
${browser}      chrome11
${url}      https://rental2.infotiv.net/
 
#User details
${firstName1}   Adejjjrj
${lastName1}    Nionjjjj
${phoneNumber1}     0713255388
${email1}   alanjkk@infotiv.se
${password1}    123456
${wrongPassword1}    thisIsWrong
 
#Dates
${startDate1}   2024-02-12
${endDate1}     2024-02-15
${invalidStartDate1}   2025-02-10   #Date is later than acceptable
${invalidEndDate1}     2025-02-15   #Date is later than acceptable
${invalidStartDate2}   2024-02-07   #Date is earlier than acceptable
${invalidEndDate2}     2024-02-08   #Date is earlier than acceptable
${invalidEndDate3}     2026-05-12   #Date period is too long
 
#Card info
${card1}    1234567890123456
${fullName1}    adejjjrj nionjjjj
${monthCard1}   1
${yearCard1}    2025
${cvcCard1}     123
 
######################################BREAKFORBETTERVISABILITY#########################################################
 
*** Test Cases ***
rent_car
    open browser    ${url}   ${browser}
    maximize browser window
    #CreateUser    ${firstName1}     ${lastName1}    ${phoneNumber1}     ${email1}   ${password1}
    LoginUser    ${email1}   ${password1}
    SelectDate    ${startDate1}     ${endDate1}
    SelectCar
    EnterCardDetails    ${card1}    ${fullName1}    ${monthCard1}   ${yearCard1}    ${cvcCard1}
    validatebooking    ${startDate1}    ${endDate1}
    builtin.sleep    5s
 
negativDateTest1
    open browser    ${url}   ${browser}
    maximize browser window
    #CreateUser    ${firstName1}     ${lastName1}    ${phoneNumber1}     ${email1}   ${password1}
    LoginUser    ${email1}   ${password1}
    SelectDate    ${invalidStartDate1}      ${invalidEndDate1}
    element should be visible    //button[@id='continue']   #continue variabel ska fortfarande finnas kvar för att verifiera att vi ej kom vidare från datumvalet
negativDateTest2
    open browser    ${url}   ${browser}
    maximize browser window
    #CreateUser    ${firstName1}     ${lastName1}    ${phoneNumber1}     ${email1}   ${password1}
    LoginUser    ${email1}   ${password1}
    SelectDate    ${invalidStartDate2}    ${invalidEndDate2}
    element should be visible    //button[@id='continue']   #continue variabel ska fortfarande finnas kvar för att verifiera att vi ej kom vidare från datumvalet
 
negativDateTest3
    open browser    ${url}   ${browser}
    maximize browser window
    #CreateUser    ${firstName1}     ${lastName1}    ${phoneNumber1}     ${email1}   ${password1}
    LoginUser    ${email1}   ${password1}
    SelectDate    ${startDate1}     ${invalidEndDate3}
    element should be visible    //button[@id='continue']   #continue variabel ska fortfarande finnas kvar för att verifiera att vi ej kom vidare från datumvalet
 
WrongPasswordTest
    open browser    ${url}   ${browser}
    maximize browser window
    #CreateUser    ${firstName1}     ${lastName1}    ${phoneNumber1}     ${email1}   ${password1}
    LoginUser    ${email1}   ${wrongPassword1}
    element should be visible    //label[@id='signInError']     #error message synligt
    element should be visible    //button[@id='login']      #Loginknapp synlig
 
 
######################################BREAKFORBETTERVISABILITY#########################################################
 
*** Keywords ***
CreateUser
    [Arguments]     ${firstName}    ${lastName}    ${phoneNumber}   ${email}    ${password}
    click button    //button[@id='createUser']
    input text    //input[@id='name']   ${firstName}
    input text    //input[@id='last']   ${lastName}
    input text    //input[@id='phone']  ${phoneNumber}
    input text    //input[@id='emailCreate']    ${email}
    input text    //input[@id='confirmEmail']   ${email}
    input password    //input[@id='passwordCreate']     ${password}
    input password    //input[@id='confirmPassword']    ${password}
    builtin.sleep    5s
    click button    //button[@id='create']
 
SelectDate
    [Arguments]    ${startDate}     ${endDate}
    input text    //input[@id='start']      ${startDate}
    input text    //input[@id='end']        ${endDate}
    click element    //button[@id='continue']   #Funkar dåligt med "click button", kan behöva klicka utanför datumrutan
 
LoginUser
    [Arguments]    ${email}    ${password}
    input text    //input[@id='email']      ${email}
    input password    //input[@id='password']       ${password}
    click button    //button[@id='login']
 
SelectCar   #Anpassa för att hitta rätt model auto, kolla index på xPath tr[x] på märke, modell, passagerare och knapp
            #KnappID ger bookQ7pass5    kan eventuellt skippa märke då modellen är unik och bara kolla modell & passagerare
    #[Arguments]    ${brand}     ${model}    ${passengers}
    click button    //tbody/tr[1]/td[5]/form[1]/input[4]
 
EnterCardDetails
    [Arguments]    ${cardNumber}    ${fullName}     ${month}     ${year}     ${cvc}
    input text    //input[@id='cardNum']    ${cardNumber}
    input text    //input[@id='fullName']   ${fullName}
    select from list by label    //select[@title='Month']    ${month}   #Funkar ej med select from list by value
    builtin.sleep    1s
    select from list by label    //select[@title='Year']    ${year}     #Funkar ej med select from list by value
    builtin.sleep    1s
    input text    //input[@id='cvc']    ${cvc}
    builtin.sleep    5s
    click button    //button[@id='confirm']
 
ValidateBooking
    [Arguments]    ${startDate}  ${endDate}
    click button    //div[@id='backToStart']//button[@id='mypage']
    element text should be      //td[@id='startDate1']    ${startDate}
    element text should be      //td[@id='endDate1']    ${endDate}
    element should be visible    //button[@id='unBook1']
    builtin.sleep    5s
