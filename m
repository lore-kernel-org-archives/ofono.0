Content-Type: multipart/mixed; boundary="===============3214551336438460180=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: [PATCH] hfp: Don't reply to crashed bluetoothd
Date: Thu, 10 Feb 2011 20:31:21 +0100
Message-ID: <1297366281-25850-1-git-send-email-wagi@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3214551336438460180==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In case bluetoothd crashes randomly the data pointer can
be NULL. So we shouldn't derefernce it.
---
 plugins/hfp.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/plugins/hfp.c b/plugins/hfp.c
index 12d3457..acb297f 100644
--- a/plugins/hfp.c
+++ b/plugins/hfp.c
@@ -569,6 +569,9 @@ static void hfp_connect_reply(DBusPendingCall *call, gp=
ointer user_data)
 =

 	DBG("Connect reply: %s", derr.message);
 =

+	if (data =3D=3D NULL)
+		goto poweroff;
+
 	if (dbus_error_has_name(&derr, DBUS_ERROR_NO_REPLY)) {
 		msg =3D dbus_message_new_method_call(BLUEZ_SERVICE,
 				data->handsfree_path,
@@ -579,6 +582,7 @@ static void hfp_connect_reply(DBusPendingCall *call, gp=
ointer user_data)
 			g_dbus_send_message(connection, msg);
 	}
 =

+poweroff:
 	ofono_modem_set_powered(modem, FALSE);
 =

 	dbus_error_free(&derr);
-- =

1.7.3.3


--===============3214551336438460180==--

