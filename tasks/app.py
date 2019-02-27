from invoke import Collection, task
import tasks.docs as docs


@task
def clean(c):
    print("Cleaning")


@task
def publish(c):
    print("Publishing")


@task(pre=[clean], post=[publish], help={'clean': "Feature toogle to clean output first."})
def build(c, clean=False):
    """
    Build an artifact.
    """
    if clean:
        print("Cleaning!")
    print("Building!")
    c.run("(date)")


@task(aliases=('release', 'pypi'))
def deploy(c):
    c.run("python setup.py sdist")
    c.run("twine upload dist/*")


@task(name='sayHi')
def hi(c, name):
    print("Hi {}!".format(name))

@task
def do_something(c, name):
    print("Do it, {}!".format(name))


namespace = Collection(docs, build, deploy, hi)
namespace.add_task(task=clean, name='cleanup')
namespace.add_task(task=publish, aliases=('publishing', 'pub'))
namespace.add_task(do_something)

my = Collection('my')
my.add_task(deploy)
my.add_task(hi)

namespace.add_collection(my, 'custom')
