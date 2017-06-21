Content-Type: multipart/mixed; boundary="===============7542600584955370998=="
MIME-Version: 1.0
From: Slava Monich <slava.monich@jolla.com>
Subject: [PATCH] ussd: Switch the state from USER_ACTION to IDLE
Date: Wed, 21 Jun 2017 14:54:48 +0300
Message-ID: <1498046088-545-1-git-send-email-slava.monich@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7542600584955370998==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

... when a USSD notification is received. Some networks
send 0 (no further user action required) after the response
timeout expires. That should result in the user input form
getting removed from the ME screen.
---
 src/ussd.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/src/ussd.c b/src/ussd.c
index 99fa753..84f64c6 100644
--- a/src/ussd.c
+++ b/src/ussd.c
@@ -512,6 +512,20 @@ void ofono_ussd_notify(struct ofono_ussd *ussd, int st=
atus, int dcs,
 =

 		ussd_change_state(ussd, new_state);
 		goto free;
+	} else if (ussd->state =3D=3D USSD_STATE_USER_ACTION &&
+				status !=3D OFONO_USSD_STATUS_ACTION_REQUIRED) {
+		ussd_change_state(ussd, USSD_STATE_IDLE);
+
+		if (status =3D=3D OFONO_USSD_STATUS_NOTIFY && str && str[0]) {
+			const char *path =3D __ofono_atom_get_path(ussd->atom);
+
+			g_dbus_emit_signal(conn, path,
+				OFONO_SUPPLEMENTARY_SERVICES_INTERFACE,
+				"NotificationReceived", DBUS_TYPE_STRING,
+				&str, DBUS_TYPE_INVALID);
+		}
+
+		goto free;
 	} else {
 		ofono_error("Received an unsolicited USSD but can't handle.");
 		DBG("USSD is: status: %d, %s", status, str);
-- =

1.9.1


--===============7542600584955370998==--

