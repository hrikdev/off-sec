import requests
import time

def submit_flags(flags, api_url):
    with open("submission_log.txt", "a") as log:
        for flag in flags:
            try:
                time.sleep(1.5)
                response = requests.post(api_url, data={"flag": flag}, headers={"User-Agent": "Mozilla/5.0"})
                if response.status_code == 200:
                    print(f"✅ Submitted: {flag}")
                    log.write(f"✅ {flag}\n")
                else:
                    print(f"⚠️ Failed: {flag} (HTTP {response.status_code})")
                    log.write(f"⚠️ {flag} HTTP {response.status_code}\n")
            except Exception as e:
                print(f"❌ Error: {flag} -> {str(e)}")
                log.write(f"❌ {flag} -> {str(e)}\n")

if __name__ == "__main__":
    try:
        with open("flags.txt", "r") as f:
            flags = [line.strip() for line in f]
    except:
        print("❌ Create flags.txt with your flags.")
        exit(1)

    api_url = input("Enter flag submission URL: ").strip()
    submit_flags(flags, api_url)
