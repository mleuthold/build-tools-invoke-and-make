from invoke import task


@task
def hello_world(c):
    c.run("echo Hello World!")
