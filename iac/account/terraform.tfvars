env = {
    name         = "dev"
    region       = "us-east-1"
    project_name = "binance-challenge"
    domain_zone = "lipato.dev"
    domain_name = "binance-challenge"
}

subnets = {
    public-subnet-a  = "10.10.0.0/20"
    public-subnet-b  = "10.10.16.0/20"
    private-subnet-a = "10.10.32.0/20"
    private-subnet-b = "10.10.48.0/20"
}

account = { id = "011241237512", name = "dev", vpc_cidr = "10.10.0.0/16"  }
ecr_name = "binance-challenge-ecr"
