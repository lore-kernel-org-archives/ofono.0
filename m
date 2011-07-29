Content-Type: multipart/mixed; boundary="===============4680041451909669095=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH] connman: Initialize req->path to NULL to avoid crash on g_free
Date: Fri, 29 Jul 2011 15:49:09 +0200
Message-ID: <1311947349-27741-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4680041451909669095==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/connman.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/plugins/connman.c b/plugins/connman.c
index bb29cd5..875dd2d 100644
--- a/plugins/connman.c
+++ b/plugins/connman.c
@@ -264,6 +264,7 @@ static int connman_request(ofono_private_network_cb_t c=
b, void *data)
 	req->data =3D data;
 	req->uid =3D id;
 	req->redundant =3D FALSE;
+	req->path =3D NULL;
 =

 	dbus_pending_call_set_notify(call, request_reply, req, NULL);
 	g_hash_table_insert(requests, &req->uid, req);
-- =

1.7.1


--===============4680041451909669095==--

