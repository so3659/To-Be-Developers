import requests
import base64
import pandas as pd
import time

client_id = 'eCLLhbHJ1OlhbVxzUCw8hwyip6Fq3gtg1FlnVwrK'
client_secret = 'O6ExWX6DxYzhzlxRk7hEmQWyV3As5w3R5gvfaJUtc1oz62HNL9eoZZWnrCaZXQRSpLxIuhcrjVDIiQiuDX4uZfEOKhoJo3NxGnrDi3n4AbNFJKEqILLyCEUwIk9MW2CS'
bearer_token = base64.b64encode(f"{client_id}:{client_secret}".encode()).decode()

headers = {
    'Authorization': f'Basic {bearer_token}'
}

def fetch_data(endpoint, page, page_size):
    url = f'https://www.udemy.com/api-2.0/{endpoint}/?page={page}&page_size={page_size}'
    response = requests.get(url, headers=headers)
    if response.status_code != 200:
        raise Exception(f"Failed to fetch data: {response.status_code} - {response.text}")
    return response.json()

def save_to_csv(data, filename):
    df = pd.DataFrame(data)
    if not pd.io.common.file_exists(filename):
        df.to_csv(filename, index=False)
    else:
        df.to_csv(filename, mode='a', header=False, index=False)

def main():
    endpoints = ['courses', 'categories', 'subcategories', 'reviews']
    page_size = 100
    retries = 5

    for endpoint in endpoints:
        filename = f'udemy_{endpoint}.csv'
        page = 1

        while True:
            try:
                results = fetch_data(endpoint, page, page_size)
            except Exception as e:
                print(f"Error fetching data from {endpoint} on page {page}: {e}")
                if "Invalid page" in str(e):
                    print(f"All pages for {endpoint} processed.")
                    break
                if retries > 0:
                    retries -= 1
                    time.sleep(5)
                    continue
                else:
                    print("Max retries reached. Exiting.")
                    break

            if not results['results']:
                break

            save_to_csv(results['results'], filename)
            print(f"{endpoint.capitalize()} Page {page} processed.")
            page += 1
            time.sleep(1)

if __name__ == "__main__":
    main()
