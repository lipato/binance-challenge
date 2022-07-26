# Binance technical challenge

---

Hi. This project is my technical challenge. Code is located at https://github.com/lipato/binance-challenge.
The Backend of project is written in Python/Flask and the frontend is implemented on the Bootstrap framework using the Flask templating engine.
Infrastructure as a code prepared with Terraform and deployed for testing in the AWS Cloud on ECS (Fargate) cluster.
The infrastructure code is located at https://github.com/lipato/binance-challenge/tree/master/iac/account

---
**Assignment**:
- Use public market data from the SPOT API at https://api.binance.com
- Binance API spot documentation is at https://github.com/binance-exchange/binance-official-api-docs/
- All answers should be provided as source code written in either Go, Python, Java, Rust, and/or Bash.

**Questions**:
1. Print the top 5 symbols with quote asset BTC and the highest volume over the last 24 hours in descending order.
2. Print the top 5 symbols with quote asset USDT and the highest number of trades over the last 24 hours in descending order.
3. Using the symbols from Q1, what is the total notional value of the top 200 bids and asks currently on each order book?
4. What is the price spread for each of the symbols from Q2?
5. Every 10 seconds print the result of Q4 and the absolute delta from the previous value for each symbol.
6. Make the output of Q5 accessible by querying http://localhost:8080/metrics using the Prometheus Metrics format.


---

I will be glad to hear your comments!!

My LinkedIn account https://www.linkedin.com/in/lipato/

```hcl
George.Lipatov
```
---
**Usefull commands:**

###### _How to start this python application?_
```hcl
pip install -r requirements.txt
python3 -m gunicorn -b 0.0.0.0:8080 wsgi:app
```

###### _How to build docker container and run it?_
```hcl
docker build -t binance-challenge .
docker run -d -p 8080:8080 —name=binance-challenge-container binance-challenge
```