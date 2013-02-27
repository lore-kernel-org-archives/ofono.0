Content-Type: multipart/mixed; boundary="===============6467766662026075884=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v2 1/6] hfp_hf_bluez5: Add registering Audio Card
Date: Wed, 27 Feb 2013 18:03:03 -0300
Message-ID: <1361998983-26780-1-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1361997234-13804-2-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6467766662026075884==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch registers the Handsfree Audio Card when the service level
connection is established.
---
 plugins/hfp_hf_bluez5.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
index 7057d71..dbb1303 100644
--- a/plugins/hfp_hf_bluez5.c
+++ b/plugins/hfp_hf_bluez5.c
@@ -46,6 +46,7 @@
 #include <ofono/netreg.h>
 #include <ofono/voicecall.h>
 #include <ofono/call-volume.h>
+#include <ofono/handsfree-audio.h>
 #include <ofono/handsfree.h>
 =

 #include <drivers/hfpmodem/slc.h>
@@ -61,6 +62,7 @@
 struct hfp {
 	struct hfp_slc_info info;
 	DBusMessage *msg;
+	struct ofono_handsfree_card *card;
 };
 =

 static GDBusClient *bluez =3D NULL;
@@ -88,6 +90,8 @@ static void slc_established(gpointer userdata)
 	hfp->msg =3D NULL;
 =

 	ofono_info("Service level connection established");
+
+	ofono_handsfree_card_register(hfp->card);
 }
 =

 static void slc_failed(gpointer userdata)
@@ -315,8 +319,11 @@ static DBusMessage *profile_new_connection(DBusConnect=
ion *conn,
 {
 	struct hfp *hfp;
 	struct ofono_modem *modem;
+	struct sockaddr_rc saddr;
+	socklen_t optlen;
 	DBusMessageIter entry;
 	const char *device;
+	char remote[18];
 	int fd, err;
 =

 	DBG("Profile handler NewConnection");
@@ -353,8 +360,21 @@ static DBusMessage *profile_new_connection(DBusConnect=
ion *conn,
 					"Not enough resources");
 	}
 =

+	memset(&saddr, 0, sizeof(saddr));
+	optlen =3D sizeof(saddr);
+	if (getpeername(fd, (struct sockaddr *) &saddr, &optlen) < 0) {
+		err =3D errno;
+		ofono_error("RFCOMM getpeername(): %s (%d)", strerror(err),
+									err);
+		close(fd);
+		goto invalid;
+	}
+
+	bt_ba2str(&saddr.rc_bdaddr, remote);
+
 	hfp =3D ofono_modem_get_data(modem);
 	hfp->msg =3D dbus_message_ref(msg);
+	hfp->card =3D ofono_handsfree_card_create(remote, NULL);
 =

 	return NULL;
 =

-- =

1.7.11.7


--===============6467766662026075884==--

