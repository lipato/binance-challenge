from flask import render_template, jsonify, request
from app import app
from app.binance import ApiClient
from prometheus_client import generate_latest

client = ApiClient()

@app.route('/')
def template():
    return render_template('home.html')


@app.route('/top_symbols', methods=['GET'])
def top_symbols():
    args = request.args
    symbol = args.get("symbols", default="BTC", type=str)
    volume = args.get("field", default="volume", type=str)
    return jsonify(client.get_symbols(symbol, volume, 5))


@app.route('/notional_value', methods=['GET'])
def notional_value():
    args = request.args
    symbol = args.get("symbols", default="BTC", type=str)
    volume = args.get("field", default="volume", type=str)
    return jsonify(client.get_notional(symbol, volume, 5))


@app.route('/price_spread', methods=['GET'])
def price_spread():
    args = request.args
    symbol = args.get("symbols", default="USDT", type=str)
    volume = args.get("field", default="count", type=str)
    return jsonify(client.get_spread(symbol, volume, 5))

@app.route('/spread_delta', methods=['POST'])
def spread_delta():
    result = {}
    content = request.get_json()
    if request.is_json:
        result = client.get_delta(content["symbols"], content["field"], content["old_spread"], 5)
    return jsonify(result)

@app.route('/metrics')
def metrics():
    return generate_latest()