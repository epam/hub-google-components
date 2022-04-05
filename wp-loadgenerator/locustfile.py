import string
import random

from locust import HttpUser, between, task


def rand_str(str_length):
    return ''.join(random.choices(string.ascii_uppercase + string.digits, k=str_length))


class MyUser(HttpUser):
    wait_time = between(5, 10)

    def on_start(self):
        self.client.verify = False

    @task
    def index(self):
        self.client.get("/")

    @task
    def search_post(self):
        self.client.get("/?p=1")

    @task
    def post_comment(self):
        author = rand_str(6)
        self.client.post("/wp-comments-post.php", data={
            "comment": rand_str(200),
            "author": author,
            "email": author + "@test.com",
            "url": "",
            "wp-comment-cookies-consent": "yes",
            "submit": "Post Comment",
            "comment_post_ID": 1,
            "comment_parent": 0,
        }, verify=False)
