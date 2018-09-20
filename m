Content-Type: multipart/mixed; boundary="===============1215771088457067286=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: [PATCH] src/gprs.c: make sure that the context is properly released
Date: Thu, 20 Sep 2018 06:42:59 +0200
Message-ID: <1537418579-18547-1-git-send-email-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1215771088457067286==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/gprs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/gprs.c b/src/gprs.c
index 8f5d195..40f43e3 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -1642,6 +1642,9 @@ static void release_active_contexts(struct ofono_gprs=
 *gprs)
 =

 		if (gc->driver->detach_shutdown !=3D NULL)
 			gc->driver->detach_shutdown(gc, ctx->context.cid);
+
+		/* Make sure the context is properly cleared */
+		release_context(ctx);
 	}
 }
 =

@@ -2241,6 +2244,7 @@ static DBusMessage *gprs_remove_context(DBusConnectio=
n *conn,
 	}
 =

 	DBG("Unregistering context: %s", ctx->path);
+	release_context(ctx);
 	context_dbus_unregister(ctx);
 	gprs->contexts =3D g_slist_remove(gprs->contexts, ctx);
 =

-- =

1.9.1


--===============1215771088457067286==--

