Please also note that:

- All prices are stored as integers (in cents)
- Running `$ ruby main.rb` from the level folder must generate the desired output, but of course feel free to add more files if needed.

## Business model error found ⚠️ ⛔️ ✋

Every rental under the line (or in the red area) is not profitable for the compagny.

![analyse_rentabilite_lineaire](https://github.com/AmineAffif/Drivy-Ruby/assets/45182137/2916671c-c6f8-4c10-a553-740bd5d08a5a)

The combination between **Low rental cost** and high **duration** make a big loss because of the rule :
- 1€/day goes to the roadside assistance

Currently, Drivy pays this fee.
If the driver had to pay this fee, we could be profitable, but the expected_output.json will not be right as expected by the exercice.

For exemple here for a rental that a driver will pay 40€ for 12 days, we are not profitable.
I saw this problem only when I was doing the Unit tests on my CommissionCalculator Service.

<img width="989" alt="image" src="https://github.com/AmineAffif/Drivy-Ruby/assets/45182137/fd15921e-3a87-482d-b2b2-7f7cb6979159">

This is the **rental data** in my unit test:
<img width="766" alt="image" src="https://github.com/AmineAffif/Drivy-Ruby/assets/45182137/ccf29512-499b-43f8-a1d1-cdd9d27ab89c">

So when I discovered this issue with my unit test, I decided to write à Ruby script that will draw a **simulation of rental price crossed with the duration**.
**You can find the two files for the two diagram (and the images that they generated) beside levels folders**
