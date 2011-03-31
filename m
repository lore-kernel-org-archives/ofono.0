Content-Type: multipart/mixed; boundary="===============6794663151170334185=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [RFC PATCH 5/9] modem: add increment/decrement emergency mode api
Date: Thu, 31 Mar 2011 09:18:28 -0700
Message-ID: <1301588312-6932-6-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1301588312-6932-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6794663151170334185==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/modem.c |   36 ++++++++++++++++++++++++++++++++++++
 src/ofono.h |    3 +++
 2 files changed, 39 insertions(+), 0 deletions(-)

diff --git a/src/modem.c b/src/modem.c
index 0aef463..72937a3 100644
--- a/src/modem.c
+++ b/src/modem.c
@@ -2050,3 +2050,39 @@ ofono_bool_t ofono_modem_get_emergency_mode(struct o=
fono_modem *modem)
 {
 	return modem->emergency !=3D 0;
 }
+
+void __ofono_modem_inc_emergency_mode(struct ofono_modem *modem)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	dbus_bool_t emergency =3D TRUE;
+
+	if (++modem->emergency > 1)
+		return;
+
+	ofono_dbus_signal_property_changed(conn, modem->path,
+						OFONO_MODEM_INTERFACE,
+						"Emergency", DBUS_TYPE_BOOLEAN,
+						&emergency);
+}
+
+void __ofono_modem_dec_emergency_mode(struct ofono_modem *modem)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	dbus_bool_t emergency =3D FALSE;
+
+	if (modem->emergency =3D=3D 0) {
+		ofono_error("emergency mode is already deactivated!!!");
+		return;
+	}
+
+	if (modem->emergency > 1)
+		goto out;
+
+	ofono_dbus_signal_property_changed(conn, modem->path,
+						OFONO_MODEM_INTERFACE,
+						"Emergency", DBUS_TYPE_BOOLEAN,
+						&emergency);
+
+out:
+	modem->emergency--;
+}
diff --git a/src/ofono.h b/src/ofono.h
index 511be8a..a80af4f 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -212,6 +212,9 @@ void __ofono_modem_remove_powered_watch(struct ofono_mo=
dem *modem,
 =

 void __ofono_modem_sim_reset(struct ofono_modem *modem);
 =

+void __ofono_modem_inc_emergency_mode(struct ofono_modem *modem);
+void __ofono_modem_dec_emergency_mode(struct ofono_modem *modem);
+
 #include <ofono/call-barring.h>
 =

 gboolean __ofono_call_barring_is_busy(struct ofono_call_barring *cb);
-- =

1.7.0.4


--===============6794663151170334185==--

