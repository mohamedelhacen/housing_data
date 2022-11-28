from flask import Flask, render_template, url_for, request
import joblib
import pandas as pd

app = Flask(__name__)
app.config['DEBUG']=True


pipeline = joblib.load('/home/california/app/static/pipeline.pkl')
model = joblib.load('/home/california/app/static/forest_reg.pkl')


@app.route('/', methods=["GET", "POST"])
def index():
	res = ''
	if request.method == "POST":
		longitude = request.form.get("longitude")
		latitude = request.form.get("latitude")
		age = request.form.get("age")
		totalrooms = request.form.get("totalrooms")
		totalbedrooms = request.form.get("totalbedrooms")
		population = request.form.get("population")
		households = request.form.get("households")
		income = request.form.get("income")
		oceanproximity = request.form.get("oceanproximity")

		columns = ['longitude', 'latitude', 'housing_median_age', 'total_rooms', 'total_bedrooms', 'population', 
		'households', 'median_income', 'ocean_proximity']
		vals = [[longitude], [latitude], [age], [totalrooms], [totalbedrooms], [population], [households],
		[income], [oceanproximity]]

		housing = pd.DataFrame.from_dict(dict(zip(columns, vals)))
		housing.to_csv('/home/california/app/static/housing.csv', index=False)

		housing_prepared = pipeline.transform(housing)
		result = model.predict(housing_prepared)

		return render_template('index.html', res=result, cols=columns, rows=vals)

	return render_template('index.html', res=res)