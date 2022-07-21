import requests
from prometheus_client import Gauge


class ApiClient:

    def __init__(self):
        self.endpoint = 'https://api.binance.com/api'
        self.gauge = Gauge('absolute_delta_value',
                                'Absolute Delta Value of Price Spread', ['symbol'])

    def get_symbols(self, asset, field, limit):
        uri = "/v3/ticker/24hr"
        request = requests.get(self.endpoint + uri)
        values_filtered = [value for value in request.json() if value['symbol'].endswith(asset)]
        sorted_results = sorted(values_filtered, key=lambda value: float(value[field]), reverse=True)
        return sorted_results[:limit]

    def get_notional(self, asset, field, limit):
        uri = "/v3/depth"
        symbols = self.get_symbols(asset, field, limit)
        notional_list = []
        for symbol_dict in symbols:
            symbol_name = symbol_dict["symbol"]
            payload = {'symbol': symbol_name, 'limit': 500}
            request = requests.get(self.endpoint + uri, params=payload)
            result = {}
            for col in ["bids", "asks"]:
                result["symbol"] = symbol_name
                list_of_dict = [dict(zip(("price", "quantity"), values)) for values in request.json()[col]]
                sorted_results = sorted(list_of_dict, key=lambda value: float(value["price"]), reverse=True)[:200]
                result[col] = sum((float(value["price"]) * float(value["quantity"])) for value in sorted_results)
            notional_list.append(result)
        return notional_list

    def get_spread(self, asset, field, limit):
        uri = '/v3/ticker/bookTicker'
        symbols = self.get_symbols(asset, field, limit)
        spread_list = []

        for symbol_dict in symbols:
            symbol_name = symbol_dict["symbol"]
            payload = {'symbol': symbol_name}
            result = requests.get(self.endpoint + uri, params=payload)
            price_spread = result.json()
            result = {"symbol": symbol_name,
                      "price_spread": float(price_spread['askPrice']) - float(price_spread['bidPrice'])}
            spread_list.append(result)
        return spread_list

    def get_delta(self, asset, field, old_spread, limit):
        delta = []
        new_spread = self.get_spread(asset, field, limit)
        if old_spread is None:
            old_spread = new_spread

        for old_value, new_value in zip(old_spread, new_spread):
            absolute_delta = abs(old_value['price_spread']) - new_value['price_spread']
            result = {"symbol": new_value['symbol'], "price_spread": new_value['price_spread'],
                      "absolute_delta": absolute_delta}
            self.gauge.labels(new_value['symbol']).set(absolute_delta)
            delta.append(result)

        return {"items": delta, "old_data": new_spread}
