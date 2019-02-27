from invoke import task


@task
def build(c):
    print("Building!")
    c.run(f"docker build --tag={c.config['project_a']['tag']} project_a/")


@task
def run(c):
    print("Running!")
    c.run(f"docker run -p {c.config['project_a']['port']}:80 {c.config['project_a']['tag']}")


@task
def run_detached(c):
    print("Running in detached mode!")
    c.run(
        f"MY_ID=$(docker container ls | grep {c.config['project_a']['tag']} | awk '{{print $1}}');"
        f"""echo "MY_ID: $MY_ID";"""
        f"""if test -z $MY_ID; then docker run -d -p {c.config['project_a']['port']}:80 {c.config['project_a'][
            'tag']}; else echo "container is already running ..."; fi"""
    )


@task
def check(c):
    print("Checking")
    c.run(f"""curl http://localhost:{c.config['project_a'][
        'port']} | grep "^<h3>Hello World!</h3><b>Hostname:</b> .*<br/><b>Visits:</b> <i>cannot connect to Redis, counter disabled</i>" """)


@task
def stop(c):
    print("Stopping!")
    c.run(
        f"MY_ID=$(docker container ls | grep {c.config['project_a']['tag']} | awk '{{print $1}}');"
        f"""echo "MY_ID: $MY_ID";"""
        f"""if test ! -z $MY_ID; then docker container stop $MY_ID; else echo "container is already gone ..."; fi"""
    )
