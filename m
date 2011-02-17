Content-Type: multipart/mixed; boundary="===============8251664932554138911=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH] bluetooth: remove unneeded g_io_channel_shutdown
Date: Thu, 17 Feb 2011 17:52:57 +0100
Message-ID: <1297961577-9130-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8251664932554138911==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/hfp_ag.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/plugins/hfp_ag.c b/plugins/hfp_ag.c
index 6acb4dd..6edd73d 100644
--- a/plugins/hfp_ag.c
+++ b/plugins/hfp_ag.c
@@ -95,19 +95,19 @@ static void hfp_ag_connect_cb(GIOChannel *io, GError *e=
rr, gpointer user_data)
 =

 	if (err) {
 		DBG("%s", err->message);
-		goto failed;
+		return;
 	}
 =

 	/* Pick the first voicecall capable modem */
 	modem =3D modems->data;
 	if (modem =3D=3D NULL)
-		goto failed;
+		return;
 =

 	DBG("Picked modem %p for emulator", modem);
 =

 	em =3D ofono_emulator_create(modem, OFONO_EMULATOR_TYPE_HFP);
 	if (em =3D=3D NULL)
-		goto failed;
+		return;
 =

 	fd =3D g_io_channel_unix_get_fd(io);
 	ofono_emulator_register(em, fd);
@@ -115,9 +115,6 @@ static void hfp_ag_connect_cb(GIOChannel *io, GError *e=
rr, gpointer user_data)
 	g_io_channel_set_close_on_unref(io, FALSE);
 =

 	return;
-
-failed:
-	g_io_channel_shutdown(io, TRUE, NULL);
 }
 =

 static void voicecall_watch(struct ofono_atom *atom,
-- =

1.7.1


--===============8251664932554138911==--

