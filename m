Content-Type: multipart/mixed; boundary="===============7309091551508172317=="
MIME-Version: 1.0
From: sjur.brandeland@stericsson.com
Subject: [RFC 2/3] STE-plugin: Mechanism for inheritance
Date: Sun, 17 Jan 2010 18:28:31 +0100
Message-ID: <1263749312-6567-3-git-send-email-sjur.brandeland@stericsson.com>
In-Reply-To: <1263749312-6567-2-git-send-email-sjur.brandeland@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7309091551508172317==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Sjur Brandeland <sjur.brandeland@stericsson.com>

This patch adds a mechanism to inherit/specialize from the standard "atmode=
m".
This is used in the initialization of voice call driver and the network =

registration driver in order to re-use functions from "atmodems" whenever =

possible. We realize this is not the standard way of doing it, so I would
appreciate your comments on this approach.


---
 include/netreg.h    |    5 +++++
 include/voicecall.h |    7 ++++++-
 src/network.c       |   22 ++++++++++++++++++++++
 src/voicecall.c     |   22 ++++++++++++++++++++++
 4 files changed, 55 insertions(+), 1 deletions(-)

diff --git a/include/netreg.h b/include/netreg.h
old mode 100644
new mode 100755
index 0079477..ee0b201
--- a/include/netreg.h
+++ b/include/netreg.h
@@ -17,6 +17,10 @@
  *  along with this program; if not, write to the Free Software
  *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
  *
+ *  Copyright (C) 2010 ST-Ericsson AB.
+ *  Author: Marit Henriksen, marit.xx.henriksen(a)stericsson.com.
+ *  STE specific implementation.
+ *
  */
 =

 #ifndef __OFONO_NETREG_H
@@ -96,6 +100,7 @@ void ofono_netreg_status_notify(struct ofono_netreg *net=
reg, int status,
 =

 int ofono_netreg_driver_register(const struct ofono_netreg_driver *d);
 void ofono_netreg_driver_unregister(const struct ofono_netreg_driver *d);
+struct ofono_netreg_driver *ofono_netreg_driver_get(const char *driver);
 =

 struct ofono_netreg *ofono_netreg_create(struct ofono_modem *modem,
 						unsigned int vendor,
diff --git a/include/voicecall.h b/include/voicecall.h
index 6ceb3d8..ca43c91 100644
--- a/include/voicecall.h
+++ b/include/voicecall.h
@@ -17,6 +17,10 @@
  *  along with this program; if not, write to the Free Software
  *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
  *
+ *  Copyright (C) 2010 ST-Ericsson AB.
+ *  Author: Marit Henriksen, marit.xx.henriksen(a)stericsson.com.
+ *  STE specific implementation.
+ *
  */
 =

 #ifndef __OFONO_VOICECALL_H
@@ -29,7 +33,7 @@ extern "C" {
 #include <ofono/types.h>
 =

 struct ofono_voicecall;
-
+struct ofono_modem;
 typedef void (*ofono_voicecall_cb_t)(const struct ofono_error *error,
 					void *data);
 =

@@ -102,6 +106,7 @@ void ofono_voicecall_disconnected(struct ofono_voicecal=
l *vc, int id,
 =

 int ofono_voicecall_driver_register(const struct ofono_voicecall_driver *d=
);
 void ofono_voicecall_driver_unregister(const struct ofono_voicecall_driver=
 *d);
+struct ofono_voicecall_driver *ofono_voicecall_driver_get(const char *driv=
er);
 =

 struct ofono_voicecall *ofono_voicecall_create(struct ofono_modem *modem,
 					unsigned int vendor,
diff --git a/src/network.c b/src/network.c
index 8b4eb09..75ee98b 100644
--- a/src/network.c
+++ b/src/network.c
@@ -17,6 +17,10 @@
  *  along with this program; if not, write to the Free Software
  *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
  *
+ *  Copyright (C) 2010 ST-Ericsson AB.
+ *  Author: Marit Henriksen, marit.xx.henriksen(a)stericsson.com.
+ *  STE specific implementation.
+ *
  */
 =

 #ifdef HAVE_CONFIG_H
@@ -1596,6 +1600,24 @@ void ofono_netreg_driver_unregister(const struct ofo=
no_netreg_driver *d)
 	g_drivers =3D g_slist_remove(g_drivers, (void *)d);
 }
 =

+struct ofono_netreg_driver *ofono_netreg_driver_get(const char *driver)
+{
+	GSList *l;
+
+	if (driver =3D=3D NULL)
+		return NULL;
+
+	for (l =3D g_drivers; l; l =3D l->next) {
+		struct ofono_netreg_driver *drv =3D l->data;
+
+		if (g_strcmp0(drv->name, driver))
+			continue;
+		else
+			return drv;
+	}
+	return NULL;
+}
+
 static void netreg_unregister(struct ofono_atom *atom)
 {
 	struct ofono_netreg *netreg =3D __ofono_atom_get_data(atom);
diff --git a/src/voicecall.c b/src/voicecall.c
index 73de35f..1cd5bd7 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -17,6 +17,10 @@
  *  along with this program; if not, write to the Free Software
  *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
  *
+ *  Copyright (C) 2010 ST-Ericsson AB.
+ *  Author: Marit Henriksen, marit.xx.henriksen(a)stericsson.com.
+ *  STE specific implementation.
+ *
  */
 =

 #ifdef HAVE_CONFIG_H
@@ -1751,6 +1755,24 @@ void ofono_voicecall_driver_unregister(const struct =
ofono_voicecall_driver *d)
 	g_drivers =3D g_slist_remove(g_drivers, (void *)d);
 }
 =

+struct ofono_voicecall_driver *ofono_voicecall_driver_get(const char *driv=
er)
+{
+	GSList *l;
+
+	if (driver =3D=3D NULL)
+		return NULL;
+
+	for (l =3D g_drivers; l; l =3D l->next) {
+		struct ofono_voicecall_driver *drv =3D l->data;
+
+		if (g_strcmp0(drv->name, driver))
+			continue;
+		else
+			return drv;
+	}
+	return NULL;
+}
+
 static void voicecall_unregister(struct ofono_atom *atom)
 {
 	DBusConnection *conn =3D ofono_dbus_get_connection();
-- =

1.6.0.4


--===============7309091551508172317==--

