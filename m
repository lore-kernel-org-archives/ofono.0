Content-Type: multipart/mixed; boundary="===============2355757130211479920=="
MIME-Version: 1.0
From: Paulo Borges <paulo.borges@openbossa.org>
Subject: [RFC 06/22] hfp_ag_bluez5: Check if card creation fails
Date: Thu, 16 May 2013 14:16:26 -0300
Message-ID: <1368724602-27781-7-git-send-email-paulo.borges@openbossa.org>
In-Reply-To: <1368724602-27781-1-git-send-email-paulo.borges@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2355757130211479920==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If the card creation fails, the HFP AG plugin aborts the connection
and removes the emulator.
---
 plugins/hfp_ag_bluez5.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/plugins/hfp_ag_bluez5.c b/plugins/hfp_ag_bluez5.c
index 64a786c..6451be4 100644
--- a/plugins/hfp_ag_bluez5.c
+++ b/plugins/hfp_ag_bluez5.c
@@ -122,7 +122,14 @@ static DBusMessage *profile_new_connection(DBusConnect=
ion *conn,
 	}
 =

 	ofono_emulator_register(em, fd);
-	ofono_emulator_create_card(em, 0);
+
+	if (ofono_emulator_create_card(em, 0) < 0) {
+		close(fd);
+		ofono_emulator_remove(em);
+		return g_dbus_create_error(msg, BLUEZ_ERROR_INTERFACE
+						".Rejected",
+						"Not enough resources");
+	}
 =

 	fd_dup =3D dup(fd);
 	io =3D g_io_channel_unix_new(fd_dup);
-- =

1.7.9.5


--===============2355757130211479920==--

