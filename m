Content-Type: multipart/mixed; boundary="===============5249148303823841351=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH 5/8] lte: activate default bearer on network registration
Date: Tue, 11 Apr 2017 10:18:15 +0200
Message-ID: <20170411081818.19544-6-jonas@southpole.se>
In-Reply-To: <20170411081818.19544-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5249148303823841351==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The LTE atom should watch the network status and automatically activate
the default bearer when the modem becomes registered to the LTE network.

This patch adds a device callback, activate_default_bearer(), to allow
the device to start networking.
---
 include/lte.h |   2 +
 src/lte.c     | 115 ++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 117 insertions(+)

diff --git a/include/lte.h b/include/lte.h
index f3ff405..9dc0109 100644
--- a/include/lte.h
+++ b/include/lte.h
@@ -43,6 +43,8 @@ struct ofono_lte_driver {
 	void (*set_default_attach_info)(const struct ofono_lte *lte,
 			const struct ofono_lte_default_attach_info *info,
 			ofono_lte_cb_t cb, void *data);
+	void (*activate_default_bearer)(struct ofono_lte *lte,
+			ofono_lte_cb_t cb, void *data);
 };
 =

 int ofono_lte_driver_register(const struct ofono_lte_driver *d);
diff --git a/src/lte.c b/src/lte.c
index 70e0c18..3c6a0f8 100644
--- a/src/lte.c
+++ b/src/lte.c
@@ -37,11 +37,15 @@
 #include "common.h"
 #include "storage.h"
 =

+#define LTE_FLAG_ACTIVATING 0x1
+#define LTE_FLAG_RECHECK 0x2
+
 #define SETTINGS_STORE "lte"
 #define SETTINGS_GROUP "Settings"
 #define DEFAULT_APN_KEY "DefaultAccessPointName"
 =

 struct ofono_lte {
+	int flags;
 	const struct ofono_lte_driver *driver;
 	void *driver_data;
 	struct ofono_atom *atom;
@@ -50,10 +54,117 @@ struct ofono_lte {
 	DBusMessage *pending;
 	struct ofono_lte_default_attach_info pending_info;
 	struct ofono_lte_default_attach_info info;
+	int netreg_status;
+	struct ofono_netreg *netreg;
+	unsigned int netreg_watch;
+	unsigned int status_watch;
+	ofono_bool_t online;
+	ofono_bool_t roaming_allowed;
 };
 =

 static GSList *g_drivers =3D NULL;
 =

+static void lte_netreg_removed(struct ofono_lte *lte)
+{
+	lte->netreg =3D NULL;
+
+	lte->status_watch =3D 0;
+	lte->netreg_status =3D NETWORK_REGISTRATION_STATUS_NOT_REGISTERED;
+	lte->online =3D 0;
+
+//	lte_netreg_update(lte);
+}
+
+static void lte_netreg_update(struct ofono_lte *lte);
+
+static void activate_default_bearer_cb(const struct ofono_error* error,
+					void *data)
+{
+	struct ofono_lte *lte =3D data;
+
+	DBG("error %d", error->type);
+
+	lte->flags &=3D ~LTE_FLAG_ACTIVATING;
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
+		ofono_lte_remove(lte);
+		return;
+	}
+
+	lte->online =3D TRUE;
+
+	if (lte->flags & LTE_FLAG_RECHECK) {
+		lte->flags &=3D ~LTE_FLAG_RECHECK;
+		lte_netreg_update(lte);
+	}
+}
+
+static void lte_netreg_update(struct ofono_lte *lte)
+{
+	ofono_bool_t attach;
+
+	DBG("");
+
+	attach =3D lte->netreg_status =3D=3D NETWORK_REGISTRATION_STATUS_REGISTER=
ED;
+
+	attach =3D attach || (lte->roaming_allowed &&
+		lte->netreg_status =3D=3D NETWORK_REGISTRATION_STATUS_ROAMING);
+
+	if (!attach)
+		return;
+
+	if (lte->online)
+		return;
+
+	if (ofono_netreg_get_technology(lte->netreg) !=3D
+			ACCESS_TECHNOLOGY_EUTRAN)
+		return;
+
+	if (lte->flags & LTE_FLAG_ACTIVATING) {
+		lte->flags |=3D LTE_FLAG_RECHECK;
+		return;
+	}
+
+	if (lte->driver->activate_default_bearer) {
+		lte->flags |=3D LTE_FLAG_ACTIVATING;
+		lte->driver->activate_default_bearer(lte,
+				activate_default_bearer_cb, lte);
+	}
+}
+
+static void netreg_status_changed(int status, int lac, int ci, int tech,
+					const char *mcc, const char *mnc,
+					void *data)
+{
+	struct ofono_lte *lte =3D data;
+
+	DBG("%d", status);
+
+	lte->netreg_status =3D status;
+
+	lte_netreg_update(lte);
+}
+
+
+static void netreg_watch(struct ofono_atom *atom,
+				enum ofono_atom_watch_condition cond,
+				void *data)
+{
+	struct ofono_lte *lte =3D data;
+
+	if (cond =3D=3D OFONO_ATOM_WATCH_CONDITION_UNREGISTERED) {
+		lte_netreg_removed(lte);
+		return;
+	}
+
+	lte->netreg =3D __ofono_atom_get_data(atom);
+	lte->netreg_status =3D ofono_netreg_get_status(lte->netreg);
+	lte->status_watch =3D __ofono_netreg_add_status_watch(lte->netreg,
+					netreg_status_changed, lte, NULL);
+
+	lte_netreg_update(lte);
+}
+
 static void lte_load_settings(struct ofono_lte *lte)
 {
 	char *apn;
@@ -327,6 +438,10 @@ static void ofono_lte_finish_register(struct ofono_lte=
 *lte)
 =

 	ofono_modem_add_interface(modem, OFONO_LTE_INTERFACE);
 =

+	lte->netreg_watch =3D __ofono_modem_add_atom_watch(modem,
+					OFONO_ATOM_TYPE_NETREG,
+					netreg_watch, lte, NULL);
+
 	__ofono_atom_register(lte->atom, lte_atom_unregister);
 }
 =

-- =

2.9.3


--===============5249148303823841351==--

