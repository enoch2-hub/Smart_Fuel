% ==========================================
% GLOBAL SYSTEM SETTINGS (The "Today" Facts)
% ==========================================
% Change these facts to test different scenarios (e.g., date 13 or holiday false)
today_date(16).          % Today is April 16th
is_holiday(false).       % The April holiday suspension is active

% ==========================================
% SECTOR DATA (Fisheries Records)
% ==========================================
% vessel(VesselID, LastFuelingDate)
vessel(v001, 5).   % Last fueled 11 days ago
vessel(v002, 14).  % Last fueled 2 days ago
vessel(v003, 10).  % Last fueled 6 days ago

% ==========================================
% CORE LOGIC: VEHICLE ELIGIBILITY (Everyday Users)
% ==========================================
% Rule for Petrol
check_petrol(Plate) :-
    is_holiday(true),
    write('Holiday Protocol Active: All Petrol vehicles approved regardless of Plate Number.').

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
check_diesel(Plate) :-
    is_holiday(true),
    write('Holiday Protocol Active: All Diesel vehicles approved regardless of Plate Number.').

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
        format('Vessel ~w Verified. ~w days since last fueling. Allocation: ~w Litres.', [ID, DaysPassed, Litres])
    ;
        Wait is 5 - DaysPassed,
        format('Access Denied. Vessel ~w must wait ~w more day(s).', [ID, Wait])
    ).

% Error handling for unknown vessels
check_vessel(ID) :- 
    \+ vessel(ID, _),
    write('Error: Vessel ID not found in the National Registry.').

% ==========================================
% INTERACTIVE USER INTERFACE
% ==========================================
% This starts the application
start :-
    nl, write('--- Welcome to SmartFuel National Distribution ---'), nl,
    write('1. General Vehicle (Everyday User)'), nl,
    write('2. Fisheries Sector'), nl,
    write('Type stop. to exit the system.'), nl,
    write('Select Option (1 or 2 followed by a dot): '),
    read(Choice),
    ( Choice == stop -> 
        write('System Shutdown. Goodbye!') 
    ; 
        run_choice(Choice),
        start % Returns to main menu automatically
    ).

run_choice(1) :-
    write('Enter Plate Number (e.g. 4082.): '), read(Plate),
    ( Plate == stop -> write('Returning to menu...') ;
        write('Enter Fuel Type (petrol. or diesel.): '), read(Type),
        ( Type == stop -> write('Returning to menu...') ;
            (Type == petrol -> check_petrol(Plate) ; check_diesel(Plate))
        )
    ), nl.

run_choice(2) :-
    vessel_loop, nl.

% Recursive loop for Fisheries sector
vessel_loop :-
    write('Enter Vessel ID (or type stop. to return to menu): '), 
    read(ID),
    ( ID == stop -> 
        write('Exiting Fisheries Portal...') 
    ; 
        check_vessel(ID), nl,
        vessel_loop % Recursion logic
    ).
