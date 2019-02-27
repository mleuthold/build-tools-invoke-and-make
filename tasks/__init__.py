from invoke import Collection, task

import tasks.project_a as project_a
import tasks.project_b as project_b


@task(pre=[project_a.build, project_b.build])
def build(c):
    print()


@task(pre=[project_a.run_detached, project_b.run_detached])
def deploy(c):
    print()


@task(project_a.check, project_b.check)
def test(c):
    print()


@task(project_a.stop, project_b.stop)
def undeploy(c):
    print()


ns = Collection(build, deploy, test, undeploy, project_a, project_b)
