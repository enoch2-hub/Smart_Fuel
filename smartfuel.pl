% ==========================================
% GLOBAL SYSTEM SETTINGS (The "Today" Facts)
% ==========================================
% Change these facts to test different scenarios (e.g., date 13 or holiday false)

today_date(20).
is_holiday(false).

vehicle(v01, 3, petrol, 10, false).
vehicle(v02, 8, diesel, 8, true).
vehicle(v03, 5, diesel, 14, false).


% ==========================================
% SECTOR DATA (Fisheries Records)
% ==========================================
% vessel(VesselID, LastFuelingDate)

boat(b01, 5).
boat(b02, 14).
boat(b03, 10).


% ==========================================
% CORE LOGIC: VEHICLE ELIGIBILITY (Everyday Users)

% ==========================================
check
% ==========================================








% Rule for Diesel
check_diesel(Plate) :-
    is_holiday(true),
    write('Holiday Protocol Active: All Diesel vehicles approved regardless of Plate Number.').

check_diesel(Plate) :-
    LastDigit is Plate mod 10,
    LastDigitMod is LastDigit mod 2,
    (LastDigitMod == 0 -> 
        write ('Access Granted: Even Plate (Tue/Thu/Sat).'), nl,
        write ('---------------------------------------------'), nl,
        write('Status: Provisionally APPROVED.'), nl,
        write('Please scan QR Code to authorize pump.')
        write('---------------------------------------------'), nl
    ; 
        write('Access Denied: Odd Number (Mon/Wed/Fri).'), nl,
        write ('---------------------------------------------'), nl,
        write('Status: DENIED. Your vehicle is not eligible.'), nl,
        write('Please return on your assigned day.')
        write('---------------------------------------------'), nl
    ).







% ==========================================
% CORE LOGIC: FISHERIES ALLOCATION
% ==========================================
check_vessel(ID):-
today_date(Today),
Days Passed is today -Last date,
Days passed>=5,
Litres is Dayspassed *25,
write('fuel allocated:'),write (Litres),write('litres'),nl.

check_vessel(ID):-
vessel(ID,LastDate),
Days Passed is Today- Lastdate,
Days Passed <5,
write('not eligible yet.'),nl,
write('come back after'),write(Remaining),write('days'),nl


%Error handling for unknown vessel 
check_vessel(ID) :-
\+vessel(ID,_),
write(Error:Vessel ID not found.'),nl.
% ==========================================
check_petrol(_) :-
write('Holiday protocol active:All Petrol Vechicles approved regardless of number plate ').












check_vessel(_) :- 
    write('--------------!-Error-!---------------'), nl,
    write('-> Vessel ID not found in the National Registry.'), nl,
    write('-> Please Register Your Vessel!').

% ==========================================
% INTERACTIVE USER INTERFACE
% ==========================================
% This starts the application
start :-
    nl,
    write('======================================'), nl,
    write('   Welcome to SmartFuel System      '), nl,
    write('======================================'), nl,
    nl,
    write('Before starting the process, please select the sector you belong to:'), nl,
    write('[1] - I just drive for personal use'), nl,
    write('[2] - Vessel Operator in the Fisheries Sector'), nl,
    nl,
    write('Please enter the number of your choice. Remember to end with a period (e.g 1.): '),
    read(UserChoice),
    nl,
    process_user_selection(UserChoice).

Process_User_selection(1) :-
 write('Enter Plate Number (e.g. 4082.): '), read(Plate),
 write('Enter Fuel Type (petrol. or diesel.): '), read(Type),
 (Type == petrol -> check_petrol(Plate) ; check_diesel(Plate)), nl.
 
Process_User_Selection(2) :-
 write('Enter Vessel ID (e.g. v001.): '), read(ID),
 check_vessel(ID), nl.



% End---------
