{% docs __overview__ %}

# Airstats pipeline

Welcome to Airstats pipeline documentation.

## Source

Data colleted from [Our Airports](https://ourairports.com/)

Here is the schema:
![input schema](/assets/airstats_schema.png)

## Discuss

The three Silver tables are interconnected through airport identifiers. silver_airports is the central table, containing one record per airport, identified by airport_id internally and airport_ident externally. silver_runways links to airports through airport_ref and airport_ident, with each airport potentially having multiple runways or landing surfaces. Similarly, silver_airport_comments links member comments to airports using the same identifiers, with each airport potentially having multiple comments. Together, these tables allow airport details to be analysed alongside runway characteristics and community feedback.

{% enddocs %}
