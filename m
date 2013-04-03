Content-Type: multipart/mixed; boundary="===============2434219320596042748=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 3/5] hfp_hf_bluez5: Select the audio card driver based on
 version
Date: Wed, 03 Apr 2013 20:24:39 -0300
Message-ID: <1365031481-10467-3-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1365031481-10467-1-git-send-email-vinicius.gomes@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2434219320596042748==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/hfp_hf_bluez5.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
index 4c8f412..41ea549 100644
--- a/plugins/hfp_hf_bluez5.c
+++ b/plugins/hfp_hf_bluez5.c
@@ -436,7 +436,7 @@ static DBusMessage *profile_new_connection(DBusConnecti=
on *conn,
 	struct sockaddr_rc saddr;
 	socklen_t optlen;
 	DBusMessageIter entry;
-	const char *device;
+	const char *device, *driver;
 	char local[18], remote[18];
 	uint16_t version =3D HFP_VERSION_1_5;
 	int fd, err;
@@ -510,7 +510,15 @@ static DBusMessage *profile_new_connection(DBusConnect=
ion *conn,
 =

 	hfp =3D ofono_modem_get_data(modem);
 	hfp->msg =3D dbus_message_ref(msg);
-	hfp->card =3D ofono_handsfree_card_create(0, NULL, NULL);
+
+	driver =3D NULL;
+
+	if (version >=3D HFP_VERSION_1_6)
+		driver =3D HFP16_HF_DRIVER;
+
+	hfp->card =3D ofono_handsfree_card_create(0, driver, hfp);
+	ofono_handsfree_card_set_data(hfp->card, hfp);
+
 	ofono_handsfree_card_set_local(hfp->card, local);
 	ofono_handsfree_card_set_remote(hfp->card, remote);
 =

-- =

1.8.2


--===============2434219320596042748==--

