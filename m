Content-Type: multipart/mixed; boundary="===============6795475008608368746=="
MIME-Version: 1.0
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
Subject: [PATCH v1 2/3] hfpmodem: Avoid transitional voicecall states
Date: Mon, 21 Jan 2013 16:30:23 +0100
Message-ID: <1358782224-28632-3-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1358782224-28632-1-git-send-email-mikel.astiz.oss@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6795475008608368746==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

While processing the result of AT+CLCC, process the differences in a way
that disconnections are reported first, then call state changes and
finally new calls.

The goal is to avoid unnecessary transitional states such as two active
calls existing at the same time.
---
 drivers/hfpmodem/voicecall.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/hfpmodem/voicecall.c b/drivers/hfpmodem/voicecall.c
index 9770059..e0da3fc 100644
--- a/drivers/hfpmodem/voicecall.c
+++ b/drivers/hfpmodem/voicecall.c
@@ -205,6 +205,7 @@ static void clcc_poll_cb(gboolean ok, GAtResult *result=
, gpointer user_data)
 	struct ofono_call *nc, *oc;
 	unsigned int num_active =3D 0;
 	unsigned int num_held =3D 0;
+	GSList *notify_calls =3D NULL;
 =

 	if (!ok)
 		return;
@@ -242,7 +243,7 @@ static void clcc_poll_cb(gboolean ok, GAtResult *result=
, gpointer user_data)
 		} else if (nc && (oc =3D=3D NULL || (nc->id < oc->id))) {
 			/* new call, signal it */
 			if (nc->type =3D=3D 0)
-				ofono_voicecall_notify(vc, nc);
+				notify_calls =3D g_slist_append(notify_calls, nc);
 =

 			n =3D n->next;
 		} else {
@@ -257,13 +258,22 @@ static void clcc_poll_cb(gboolean ok, GAtResult *resu=
lt, gpointer user_data)
 =

 			if (memcmp(nc, oc, sizeof(struct ofono_call)) &&
 					!nc->type)
-				ofono_voicecall_notify(vc, nc);
+				notify_calls =3D g_slist_prepend(notify_calls,
+									nc);
 =

 			n =3D n->next;
 			o =3D o->next;
 		}
 	}
 =

+	/*
+	 * Disconnections were already reported, so process the rest of the
+	 * notifications. Note that the new calls are placed at the end of the
+	 * list, after other state changes
+	 */
+	g_slist_foreach(notify_calls, voicecall_notify, vc);
+	g_slist_free(notify_calls);
+
 	g_slist_foreach(vd->calls, (GFunc) g_free, NULL);
 	g_slist_free(vd->calls);
 =

-- =

1.7.11.7


--===============6795475008608368746==--

