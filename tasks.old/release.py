from invoke import task


@task
def release(c):
    c.run("echo Releasing!")
