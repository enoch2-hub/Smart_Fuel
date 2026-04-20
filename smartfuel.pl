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
% Rule for Petrol






% Rule for Diesel (Always requires QR)
check_diesel(_) :-
    write('Safety Protocol: Diesel requires a valid QR Code verification. Please scan now.').







% ==========================================
% CORE LOGIC: FISHERIES ALLOCATION
% ==========================================












check_vessel(_) :- 
    write('Error: Vessel ID not found in the National Registry.').

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

run_choice(1) :-
 write('Enter Plate Number (e.g. 4082.): '), read(Plate),
 write('Enter Fuel Type (petrol. or diesel.): '), read(Type),
 (Type == petrol -> check_petrol(Plate) ; check_diesel(Plate)), nl.
 
run_choice(2) :-
 write('Enter Vessel ID (e.g. v001.): '), read(ID),
 check_vessel(ID), nl.



% End---------
