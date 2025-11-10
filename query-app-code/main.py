from flask import Flask, render_template, request
from google.cloud import bigquery

app = Flask(__name__)
client = bigquery.Client()

QUERY_MAP = {
    "query1": "SELECT * FROM `coursework-ishwari.thelook.weekly_operational_metrics_view` LIMIT 100",
    "query2": "SELECT * FROM `coursework-ishwari.thelook.regional_insights_view` LIMIT 100"
}

@app.route("/", methods=["GET", "POST"])
def index():
    results = None
    selected_query = None

    if request.method == "POST":
        selected_query = request.form.get("query_name")
        if selected_query in QUERY_MAP:
            query = QUERY_MAP[selected_query]
            query_job = client.query(query)
            results = [dict(row) for row in query_job.result()]

    return render_template("index.html", results=results, selected_query=selected_query)

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)