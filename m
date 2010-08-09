Content-Type: multipart/mixed; boundary="===============4689512966267396711=="
MIME-Version: 1.0
From: Sjur =?unknown-8bit?q?Br=C3=A6ndeland?= <sjurbren@gmail.com>
Subject: [PATCH resend 3/3] voicecall: manager_hangup_all should not terminate
 waiting calls.
Date: Mon, 09 Aug 2010 23:18:39 +0200
Message-ID: <1281388719-11781-3-git-send-email-sjurbren@gmail.com>
In-Reply-To: <1281388719-11781-2-git-send-email-sjurbren@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4689512966267396711==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Sjur Br=C3=A6ndeland <sjur.brandeland@stericsson.com>

---
 src/voicecall.c |   16 +++++++++++-----
 1 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/src/voicecall.c b/src/voicecall.c
index 49b9c79..4341d29 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -758,15 +758,21 @@ static void emit_multiparty_call_list_changed(struct =
ofono_voicecall *vc)
 				real_emit_multiparty_call_list_changed, vc);
 }
 =

-static void voicecalls_release_queue(struct ofono_voicecall *vc, GSList *c=
alls)
+static void voicecalls_release_queue(struct ofono_voicecall *vc, GSList *c=
alls,
+					gboolean skip_waiting)
 {
 	GSList *l;
+	struct ofono_call *call;
 =

 	g_slist_free(vc->release_list);
 	vc->release_list =3D NULL;
 =

-	for (l =3D calls; l; l =3D l->next)
-		vc->release_list =3D g_slist_prepend(vc->release_list, l->data);
+	for (l =3D calls; l; l =3D l->next) {
+		call =3D l->data;
+		if (!skip_waiting || call->status !=3D CALL_STATUS_WAITING)
+			vc->release_list =3D
+				g_slist_prepend(vc->release_list,call);
+	 }
 }
 =

 static void voicecalls_release_next(struct ofono_voicecall *vc)
@@ -1161,7 +1167,7 @@ static DBusMessage *manager_hangup_all(DBusConnection=
 *conn,
 	if (vc->driver->hangup_all !=3D NULL)
 		vc->driver->hangup_all(vc, generic_callback, vc);
 	else {
-		voicecalls_release_queue(vc, vc->call_list);
+		voicecalls_release_queue(vc, vc->call_list, TRUE);
 		voicecalls_release_next(vc);
 	}
 	return NULL;
@@ -1400,7 +1406,7 @@ static DBusMessage *multiparty_hangup(DBusConnection =
*conn,
 =

 	/* Fall back to the old-fashioned way */
 	vc->flags |=3D VOICECALLS_FLAG_MULTI_RELEASE;
-	voicecalls_release_queue(vc, vc->multiparty_list);
+	voicecalls_release_queue(vc, vc->multiparty_list,FALSE);
 	voicecalls_release_next(vc);
 =

 out:
-- =

1.6.3.3


--===============4689512966267396711==--

