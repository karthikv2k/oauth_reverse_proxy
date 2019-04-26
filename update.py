import os

envs = [
    "CLIENT_ID",
    "CLIENT_SECRET",
    "DST_SERVICE_URL",
    "SERVICE_URL",
    "PORT"
]

files = [
    "nginx.conf",
    "vouch_proxy_config.yml",
]

if __name__ == "__main__":
    for f in files:
        contents = open(f, 'r').read()
        for env in envs:
            if env in os.environ:
                contents = contents.replace(env, os.environ[env])
            else:
                raise RuntimeError(f"No env variable {env} found")
        with open(os.path.join("config", f), 'w') as f:
            f.write(contents)
