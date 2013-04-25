Content-Type: multipart/mixed; boundary="===============2031344298708845343=="
MIME-Version: 1.0
From: Paulo Borges <paulo.borges@openbossa.org>
Subject: [PATCH v2 03/12] hfp_ag_bluez5: Create card when connect
Date: Thu, 25 Apr 2013 16:09:04 -0300
Message-ID: <1366916953-12967-4-git-send-email-paulo.borges@openbossa.org>
In-Reply-To: <1366916953-12967-1-git-send-email-paulo.borges@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2031344298708845343==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/hfp_ag_bluez5.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/plugins/hfp_ag_bluez5.c b/plugins/hfp_ag_bluez5.c
index 245de21..6451be4 100644
--- a/plugins/hfp_ag_bluez5.c
+++ b/plugins/hfp_ag_bluez5.c
@@ -123,6 +123,14 @@ static DBusMessage *profile_new_connection(DBusConnect=
ion *conn,
 =

 	ofono_emulator_register(em, fd);
 =

+	if (ofono_emulator_create_card(em, 0) < 0) {
+		close(fd);
+		ofono_emulator_remove(em);
+		return g_dbus_create_error(msg, BLUEZ_ERROR_INTERFACE
+						".Rejected",
+						"Not enough resources");
+	}
+
 	fd_dup =3D dup(fd);
 	io =3D g_io_channel_unix_new(fd_dup);
 	g_io_add_watch_full(io, G_PRIORITY_DEFAULT, G_IO_HUP, io_hup_cb,
-- =

1.7.9.5


--===============2031344298708845343==--

