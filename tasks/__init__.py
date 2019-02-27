from invoke import Collection, task

import tasks.release as release, tasks.docs as docs, tasks.app as main


@task()
def build(c):
    """
        Build an artifact.
        """
    print("Building!")


@task()
def deploy(c):
    print("Deploying!")


ns = Collection().from_module(type)
ns.add_task(build)
ns.add_task(deploy)
ns.add_task(release.release)
ns.add_collection(docs)
ns.add_collection(main)
