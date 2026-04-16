# SmartFuel: Multi-Tiered Fuel Distribution System

**SmartFuel** is a logic-based Expert System developed in **Prolog**. It is designed to manage national fuel distribution by balancing everyday consumer needs with industrial sector requirements (specifically Fisheries). 

The system utilizes conditional logic, pattern matching, and recursive arithmetic to determine fuel eligibility based on real-time regulations.

## 🚀 Features

* **Everyday User Portal:** * **Holiday Protocol:** Automatically relaxes restrictions during holiday periods (e.g., April suspension).
    * **Plate Logic:** Implements an Odd/Even fueling schedule based on the last digit of the vehicle's plate number.
    * **Fuel Type Safety:** Enforces mandatory QR verification for Diesel vehicles.
* **Fisheries Sector Assistant:** * **Quota Management:** Calculates fuel allowance based on a 25L/day rate.
    * **Eligibility Guard:** Ensures a mandatory 5-day waiting period between fueling sessions.
* **Interactive CLI:** A user-friendly console interface for easy interaction.

---

## 🛠️ Prerequisites

To run this project, you need to have **SWI-Prolog** installed on your machine.
* **macOS:** `brew install swi-prolog` or download the [Mac App](https://www.swi-prolog.org/download/stable).
* **Windows/Linux:** Download from the [official website](https://www.swi-prolog.org/).

---

## 💻 How to Run

1.  **Clone the Repository:**
    ```bash
    git clone https://github.com/your-username/your-repo-name.git
    cd your-repo-name
    ```

2.  **Load the System:**
    Open your terminal or the SWI-Prolog app and run:
    ```prolog
    ?- consult('smartfuel.pl').
    ```

3.  **Start the Application:**
    Type the following command to launch the interactive menu:
    ```prolog
    ?- start.
    ```
    *Note: Remember to end all inputs in the Prolog console with a period (`.`). For example, if prompted for a plate, type `4082.`*

---

## 📂 Project Structure

* `today_date/1`: Defines the current simulation date.
* `is_holiday/1`: A boolean flag to toggle holiday regulations.
* `check_petrol/1`: Logic for plate-based or holiday-based petrol distribution.
* `check_vessel/1`: Arithmetic rules for calculating vessel quotas.

## 🤝 Contributing
This project was developed for the **BSc in IT (Level 4)** curriculum. Teammates are encouraged to submit Pull Requests for:
* Adding Emergency Vehicle priority logic.
* Integrating a GUI or Web interface.
* Expanding the "Sector" logic to include Essential Services (Health/Police).
