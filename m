Content-Type: multipart/mixed; boundary="===============9200856180697027113=="
MIME-Version: 1.0
From: Paulo Borges <paulo.borges@openbossa.org>
Subject: [RFC 03/22] hfp_ag_bluez5: Create card when connect
Date: Thu, 16 May 2013 14:16:23 -0300
Message-ID: <1368724602-27781-4-git-send-email-paulo.borges@openbossa.org>
In-Reply-To: <1368724602-27781-1-git-send-email-paulo.borges@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9200856180697027113==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When the HFP AG plugin accepts an incoming connection it now creates a
Handsfree Audio Card for the corresponding emulator.
---
 plugins/hfp_ag_bluez5.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/plugins/hfp_ag_bluez5.c b/plugins/hfp_ag_bluez5.c
index 245de21..64a786c 100644
--- a/plugins/hfp_ag_bluez5.c
+++ b/plugins/hfp_ag_bluez5.c
@@ -122,6 +122,7 @@ static DBusMessage *profile_new_connection(DBusConnecti=
on *conn,
 	}
 =

 	ofono_emulator_register(em, fd);
+	ofono_emulator_create_card(em, 0);
 =

 	fd_dup =3D dup(fd);
 	io =3D g_io_channel_unix_new(fd_dup);
-- =

1.7.9.5


--===============9200856180697027113==--

