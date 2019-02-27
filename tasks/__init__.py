from invoke import Collection, task

import tasks.release as release, tasks.docs as docs, tasks.app as app


@task()
def build(c):
    """
        Build an artifact.
        """
    print("Building!")
    print(c.config['env'])
    print(c.config['project']['name'])


@task(post=[app.publish])
def deploy(c):
    print("Deploying!")

@task(docs.hello_world, app.build,release.release)
def chain(c):
    print("Calling other tasks within a task doesn't work...")
    # docs.hello_world()
    # app.build()
    # release.release()


ns = Collection().from_module(type)
ns.add_task(build)
ns.add_task(deploy)
ns.add_task(chain)
ns.add_task(release.release)
ns.add_collection(docs)
ns.add_collection(app)
