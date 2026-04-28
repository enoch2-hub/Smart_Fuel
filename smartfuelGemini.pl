% ==========================================
% GLOBAL SYSTEM SETTINGS (The "Today" Facts)
% ==========================================
today_date(20).
today_day(tuesday).
is_holiday(false).

% Fuel distribution rules
even_days([tuesday, thursday, saturday]).
odd_days([monday, wednesday, friday]).

fuel_rate_per_day(25).
minimum_days_from_last_fueled_date(5).

% ==========================================
% SECTOR DATA (Fisheries & Vehicles)
% ==========================================
% vessel(VesselID, LastFuelingDate)
vessel(b01, 5).
vessel(b02, 14).
vessel(b03, 10).

% Note: Vehicle facts are stored for registry checks if needed
vehicle(v01, 3, petrol, 10, false).
vehicle(v02, 8, diesel, 8, true).
vehicle(v03, 5, diesel, 14, false).

% ==========================================
% CORE LOGIC: VEHICLE ELIGIBILITY
% ==========================================
% Checking eligibility for petrol
check_petrol(_) :-
    is_holiday(true),
    write('Holiday Protocol Active: All Petrol vehicles approved regardless of Plate Number.'), nl.

check_petrol(Plate) :-
    is_holiday(false),
    LastDigit is Plate mod 10,
    LastDigitMod is LastDigit mod 2,
    (LastDigitMod == 0 -> 
        write('---------------------------------------------'), nl,
        write('Access Granted: Even Plate (Tue/Thu/Sat).'), nl,
        write('Status: Provisionally APPROVED.'), nl,
        write('Please scan QR Code to authorize pump.'), nl,
        write('---------------------------------------------'), nl
    ; 
        write('---------------------------------------------'), nl,
        write('Access Denied: Odd Number (Mon/Wed/Fri).'), nl,
        write('Status: DENIED. Your vehicle is not eligible.'), nl,
        write('Please return on your assigned day.'), nl,
        write('---------------------------------------------'), nl
    ).

% Rule for Diesel
check_diesel(_) :-
    is_holiday(true),
    write('Holiday Protocol Active: All Diesel vehicles approved regardless of Plate Number.'), nl.

check_diesel(Plate) :-
    is_holiday(false),
    LastDigit is Plate mod 10,
    LastDigitMod is LastDigit mod 2,
    (LastDigitMod == 0 -> 
        write('---------------------------------------------'), nl,
        write('Access Granted: Even Plate (Tue/Thu/Sat).'), nl,
        write('Status: Provisionally APPROVED.'), nl,
        write('Please scan QR Code to authorize pump.'), nl,
        write('---------------------------------------------'), nl
    ; 
        write('---------------------------------------------'), nl,
        write('Access Denied: Odd Number (Mon/Wed/Fri).'), nl,
        write('Status: DENIED. Your vehicle is not eligible.'), nl,
        write('Please return on your assigned day.'), nl,
        write('---------------------------------------------'), nl
    ).

% ==========================================
% CORE LOGIC: FISHERIES ALLOCATION
% ==========================================
check_vessel(ID) :-
    vessel(ID, LastDate),
    today_date(Today),
    DaysPassed is Today - LastDate,
    (DaysPassed >= 5 ->
        Litres is DaysPassed * 25,
        format('Verification Successful! ~w days since last fuel.', [DaysPassed]), nl,
        format('Fuel allocated: ~w litres.', [Litres]), nl
    ;
        Remaining is 5 - DaysPassed,
        write('Status: NOT ELIGIBLE YET.'), nl,
        format('Please come back after ~w days.', [Remaining]), nl
    ).

% Error handling for unknown vessel (Negation)
check_vessel(ID) :-
    \+ vessel(ID, _),
    write('--------------!-Error-!---------------'), nl,
    write('-> Vessel ID not found in the National Registry.'), nl,
    write('-> Please Register Your Vessel!'), nl.

% ==========================================
% INTERACTIVE USER INTERFACE
% ==========================================
start :-
    nl,
    write('======================================'), nl,
    write('      Welcome to SmartFuel System      '), nl,
    write('======================================'), nl,
    write('Type stop. to exit the system.'), nl,
    nl,
    write('Please select the sector you belong to:'), nl,
    write('[1] - I just drive for personal use'), nl,
    write('[2] - Vessel Operator in the Fisheries Sector'), nl,
    write('Selection: '),
    read(UserChoice),
    ( UserChoice == stop -> 
        write('System Shutdown. Goodbye!') 
    ; 
        process_user_selection(UserChoice),
        start % Loop back to main menu
    ).

process_user_selection(1) :-
    write('Enter Plate Number (e.g. 4082.): '), read(Plate),
    ( Plate == stop -> write('Returning to menu...') ;
        write('Enter Fuel Type (petrol. or diesel.): '), read(Type),
        ( Type == stop -> write('Returning to menu...') ;
            (Type == petrol -> check_petrol(Plate) ; check_diesel(Plate))
        )
    ), nl.

process_user_selection(2) :-
    vessel_loop.

vessel_loop :-
    write('Enter Vessel ID (e.g. b01. or type stop.): '), 
    read(ID),
    ( ID == stop -> 
        write('Exiting Fisheries Portal...') 
    ; 
        check_vessel(ID), nl,
        vessel_loop 
    ).