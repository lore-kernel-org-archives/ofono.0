Content-Type: multipart/mixed; boundary="===============8678522352318492414=="
MIME-Version: 1.0
From: Paulo Borges <paulo.borges@openbossa.org>
Subject: [PATCH 3/6] hfp_ag_bluez5: Create card when connect
Date: Wed, 24 Apr 2013 14:13:48 -0300
Message-ID: <1366823631-26262-4-git-send-email-paulo.borges@openbossa.org>
In-Reply-To: <1366823631-26262-1-git-send-email-paulo.borges@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8678522352318492414==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/hfp_ag_bluez5.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/plugins/hfp_ag_bluez5.c b/plugins/hfp_ag_bluez5.c
index 245de21..e971a22 100644
--- a/plugins/hfp_ag_bluez5.c
+++ b/plugins/hfp_ag_bluez5.c
@@ -123,6 +123,14 @@ static DBusMessage *profile_new_connection(DBusConnect=
ion *conn,
 =

 	ofono_emulator_register(em, fd);
 =

+	if (ofono_emulator_create_card(em, 0, 0) < 0) {
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


--===============8678522352318492414==--

