% ==========================================
% GLOBAL SYSTEM SETTINGS (The "Today" Facts)
% ==========================================
% Change these facts to test different scenarios (e.g., date 13 or holiday false)
today_date(16).          % Today is April 16th
is_holiday(false).        % The April holiday suspension is active

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
        write('Standard Day: Even Plate (Tue/Thu/Sat) - Access GRANTED.')
    ; 
        write('Standard Day: Odd Plate (Mon/Wed/Fri) - Access DENIED.')
    ).

% Rule for Diesel (Always requires QR)
check_diesel(_) :-
    write('Safety Protocol: Diesel requires a valid QR Code verification. Please scan now.').

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

check_vessel(_) :- 
    write('Error: Vessel ID not found in the National Registry.').

% ==========================================
% INTERACTIVE USER INTERFACE
% ==========================================
% This starts the application
start :-
    write('--- Welcome to SmartFuel National Distribution ---'), nl,
    write('1. General Vehicle (Everyday User)'), nl,
    write('2. Fisheries Sector'), nl,
    write('Select Option (1 or 2 followed by a dot): '),
    read(Choice),
    run_choice(Choice).

run_choice(1) :-
    write('Enter Plate Number (e.g. 4082.): '), read(Plate),
    write('Enter Fuel Type (petrol. or diesel.): '), read(Type),
    (Type == petrol -> check_petrol(Plate) ; check_diesel(Plate)), nl.

run_choice(2) :-
    write('Enter Vessel ID (e.g. v001.): '), read(ID),
    check_vessel(ID), nl.