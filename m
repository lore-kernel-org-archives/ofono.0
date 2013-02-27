Content-Type: multipart/mixed; boundary="===============8677885535263794801=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v0 3/7] hfp_hf_bluez5: Add local Bluetooth address to Audio
 Card
Date: Wed, 27 Feb 2013 14:58:40 -0300
Message-ID: <1361987924-497-4-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1361987924-497-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8677885535263794801==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/hfp_hf_bluez5.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
index 9674635..432e95a 100644
--- a/plugins/hfp_hf_bluez5.c
+++ b/plugins/hfp_hf_bluez5.c
@@ -323,7 +323,7 @@ static DBusMessage *profile_new_connection(DBusConnecti=
on *conn,
 	socklen_t optlen;
 	DBusMessageIter entry;
 	const char *device;
-	char remote[18];
+	char local[18], remote[18];
 	int fd, err;
 =

 	DBG("Profile handler NewConnection");
@@ -362,6 +362,17 @@ static DBusMessage *profile_new_connection(DBusConnect=
ion *conn,
 =

 	memset(&saddr, 0, sizeof(saddr));
 	optlen =3D sizeof(saddr);
+	if (getsockname(fd, (struct sockaddr *) &saddr, &optlen) < 0) {
+		err =3D errno;
+		ofono_error("RFCOMM getsockname(): %s (%d)", strerror(err), err);
+		close(fd);
+		goto invalid;
+	}
+
+	bt_ba2str(&saddr.rc_bdaddr, local);
+
+	memset(&saddr, 0, sizeof(saddr));
+	optlen =3D sizeof(saddr);
 	if (getpeername(fd, (struct sockaddr *) &saddr, &optlen) < 0) {
 		err =3D errno;
 		ofono_error("RFCOMM getpeername(): %s (%d)", strerror(err), err);
@@ -373,7 +384,7 @@ static DBusMessage *profile_new_connection(DBusConnecti=
on *conn,
 =

 	hfp =3D ofono_modem_get_data(modem);
 	hfp->msg =3D dbus_message_ref(msg);
-	hfp->card =3D ofono_handsfree_card_create(NULL, remote);
+	hfp->card =3D ofono_handsfree_card_create(local, remote);
 =

 	return NULL;
 =

-- =

1.7.11.7


--===============8677885535263794801==--

