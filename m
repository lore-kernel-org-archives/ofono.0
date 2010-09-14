Content-Type: multipart/mixed; boundary="===============0928562830481760505=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 4/6] Fix common misspelling in gisi
Date: Tue, 14 Sep 2010 00:06:03 -0300
Message-ID: <1284433565-26126-4-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <4C8EDFF9.4060006@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0928562830481760505==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Fix common misspellings by using the list available at
http://en.wikipedia.org/wiki/Wikipedia:Lists_of_common_misspellings/For_mac=
hines.

From the list cited above, the substitution script found the following
misspelling:

fomr->from
---
 gisi/client.c |    2 +-
 gisi/server.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/gisi/client.c b/gisi/client.c
index 24237b2..cf31447 100644
--- a/gisi/client.c
+++ b/gisi/client.c
@@ -525,7 +525,7 @@ void g_isi_request_cancel(GIsiRequest *req)
  * Subscribe to a given indication type for the resource that an ISI client
  * is associated with. If the same type was already subscribed, the old
  * subscription is overriden.
- * @param cl ISI client (fomr g_isi_client_create())
+ * @param cl ISI client (from g_isi_client_create())
  * @param type indication type
  * @param cb callback to process received indications
  * @param data data for the callback
diff --git a/gisi/server.c b/gisi/server.c
index 8be109d..ae252e1 100644
--- a/gisi/server.c
+++ b/gisi/server.c
@@ -253,7 +253,7 @@ int g_isi_vrespond(GIsiServer *self, const struct iovec=
 *iov, size_t iovlen,
  * Prepare to handle given request type for the resource that an ISI server
  * is associated with. If the same type was already handled, the old
  * handler is overriden.
- * @param self ISI server (fomr g_isi_server_create())
+ * @param self ISI server (from g_isi_server_create())
  * @param type request message type
  * @param cb callback to process received requests
  * @param data data for the callback
-- =

1.7.2.3


--===============0928562830481760505==--

