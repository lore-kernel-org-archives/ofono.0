Content-Type: multipart/mixed; boundary="===============0469745502175668573=="
MIME-Version: 1.0
From: Slava Monich <slava.monich@jolla.com>
Subject: [PATCH] ussd: Cancel pending requests when unregistering
Date: Wed, 23 May 2018 16:48:01 +0300
Message-ID: <1527083281-21433-1-git-send-email-slava.monich@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0469745502175668573==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

And reset state to idle before unregistering the D-Bus interface.
This may occur e.g. when we receive REFRESH from STK.
---
 src/ussd.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/src/ussd.c b/src/ussd.c
index f5dd9d9..23b3323 100644
--- a/src/ussd.c
+++ b/src/ussd.c
@@ -810,6 +810,22 @@ static void ussd_unregister(struct ofono_atom *atom)
 	DBusConnection *conn =3D ofono_dbus_get_connection();
 	struct ofono_modem *modem =3D __ofono_atom_get_modem(atom);
 	const char *path =3D __ofono_atom_get_path(atom);
+	DBusMessage *reply;
+
+	if (ussd->pending) {
+		reply =3D __ofono_error_canceled(ussd->pending);
+		__ofono_dbus_pending_reply(&ussd->pending, reply);
+	}
+
+	if (ussd->cancel) {
+		reply =3D dbus_message_new_method_return(ussd->cancel);
+		__ofono_dbus_pending_reply(&ussd->cancel, reply);
+	}
+
+	if (ussd->req)
+		ussd_request_finish(ussd, -ECANCELED, 0, NULL, 0);
+
+	ussd_change_state(ussd, USSD_STATE_IDLE);
 =

 	g_slist_free_full(ussd->ss_control_list, ssc_entry_destroy);
 	ussd->ss_control_list =3D NULL;
-- =

1.9.1


--===============0469745502175668573==--

