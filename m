Content-Type: multipart/mixed; boundary="===============0934190807091857444=="
MIME-Version: 1.0
From: Paulo Borges <paulo.borges@openbossa.org>
Subject: [RFC 11/22] emulator: Set card driver
Date: Thu, 16 May 2013 14:16:31 -0300
Message-ID: <1368724602-27781-12-git-send-email-paulo.borges@openbossa.org>
In-Reply-To: <1368724602-27781-1-git-send-email-paulo.borges@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0934190807091857444==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If the version is 1.6, send the corresponding card driver name to card
creation. If the version is not 1.6, send NULL.
---
 src/emulator.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/src/emulator.c b/src/emulator.c
index a2e895a..490ee73 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -1075,10 +1075,14 @@ static int card_set_local_remote(struct ofono_hands=
free_card *card, int fd)
 =

 int ofono_emulator_create_card(struct ofono_emulator *em, int version)
 {
+	char *driver =3D NULL;
 	GIOChannel *io;
 	int fd;
 =

-	em->card =3D ofono_handsfree_card_create(0, NULL, NULL);
+	if (version =3D=3D HFP_VERSION_1_6)
+		driver =3D HFP_16_AG_DRIVER;
+
+	em->card =3D ofono_handsfree_card_create(0, driver, NULL);
 =

 	io =3D g_at_server_get_channel(em->server);
 	fd =3D g_io_channel_unix_get_fd(io);
-- =

1.7.9.5


--===============0934190807091857444==--

