Content-Type: multipart/mixed; boundary="===============9142759147811511052=="
MIME-Version: 1.0
From: Antti Paila <antti.paila@nokia.com>
Subject: [PATCH 2/5] cell-info: Atom for ECID info of neighb cells
Date: Tue, 28 Dec 2010 15:27:24 +0200
Message-ID: <1293542847-24248-3-git-send-email-antti.paila@nokia.com>
In-Reply-To: <1293542847-24248-1-git-send-email-antti.paila@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9142759147811511052==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/cell-info.c |  512 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 512 insertions(+), 0 deletions(-)
 create mode 100644 src/cell-info.c

diff --git a/src/cell-info.c b/src/cell-info.c
new file mode 100644
index 0000000..1a561e4
--- /dev/null
+++ b/src/cell-info.c
@@ -0,0 +1,512 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2009-2010 Nokia Corporation and/or its subsidiary(-ies).
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <string.h>
+#include <stdio.h>
+#include <errno.h>
+
+#include <glib.h>
+#include <gdbus.h>
+#include <sys/time.h>
+
+#include "ofono.h"
+
+#include "common.h"
+#include "util.h"
+#include "ofono/cell-info.h"
+
+
+struct ofono_cell_info {
+	DBusMessage *pending;
+	struct ofono_atom *atom;
+	const struct ofono_cell_info_driver *driver;
+	void *driver_data;
+	gboolean incl_neigh;
+};
+
+
+static DBusMessage *ci_get_cells(DBusConnection *, DBusMessage *, void *);
+static DBusMessage *ci_get_properties(DBusConnection *, DBusMessage *, voi=
d *);
+
+static GSList *g_drivers =3D NULL;
+
+static GDBusMethodTable ci_methods[] =3D {
+	{ "GetNeighborCellInfo",	"",	"a{sv}aa{sv}",	ci_get_cells,
+					G_DBUS_METHOD_FLAG_ASYNC },
+	{ "GetProperties",	"",	"a{sv}",	ci_get_properties,
+					G_DBUS_METHOD_FLAG_ASYNC },
+
+	{ }
+};
+
+static GDBusSignalTable ci_signals[] =3D {
+	{ }
+};
+
+int ofono_cell_info_driver_register(struct ofono_cell_info_driver *driver)
+{
+	DBG("driver: %p, name: %s", driver, driver->name);
+
+	if (driver->probe =3D=3D NULL)
+		return -EINVAL;
+
+	g_drivers =3D g_slist_prepend(g_drivers, (void *) driver);
+
+	return 0;
+}
+
+void ofono_cell_info_driver_unregister(struct ofono_cell_info_driver *driv=
er)
+{
+	DBG("driver: %p, name: %s", driver, driver->name);
+
+	g_drivers =3D g_slist_remove(g_drivers, (void *) driver);
+}
+
+void ofono_cell_info_remove(struct ofono_cell_info *ci)
+{
+	__ofono_atom_free(ci->atom);
+}
+
+static void cell_info_unregister(struct ofono_atom *atom)
+{
+	struct ofono_cell_info *ci =3D __ofono_atom_get_data(atom);
+	const char *path =3D __ofono_atom_get_path(ci->atom);
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(ci->atom);
+
+	ofono_modem_remove_interface(modem, OFONO_CELL_INFO_INTERFACE);
+
+	if (!g_dbus_unregister_interface(conn, path, OFONO_CELL_INFO_INTERFACE))
+		ofono_error("Failed to unregister interface %s",
+				OFONO_CELL_INFO_INTERFACE);
+}
+
+static void cell_info_remove(struct ofono_atom *atom)
+{
+	struct ofono_cell_info *ci =3D __ofono_atom_get_data(atom);
+	DBG("atom: %p", atom);
+
+	if (ci =3D=3D NULL)
+		return;
+
+	if (ci->driver && ci->driver->remove)
+		ci->driver->remove(ci);
+
+	g_free(ci);
+}
+
+void ofono_cell_info_register(struct ofono_cell_info *ci)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(ci->atom);
+	const char *path =3D __ofono_atom_get_path(ci->atom);
+
+	DBG("Modem: %p", modem);
+
+	if (!g_dbus_register_interface(conn, path,
+					OFONO_CELL_INFO_INTERFACE,
+					ci_methods, ci_signals, NULL,
+					ci, NULL)) {
+		ofono_error("Could not create %s interface",
+					OFONO_CELL_INFO_INTERFACE);
+
+		return;
+	}
+
+	ofono_modem_add_interface(modem, OFONO_CELL_INFO_INTERFACE);
+
+	__ofono_atom_register(ci->atom, cell_info_unregister);
+}
+
+struct ofono_cell_info *ofono_cell_info_create(struct ofono_modem *modem,
+					unsigned int vendor,
+					const char *driver,
+					void *data)
+{
+	struct ofono_cell_info *ci;
+	GSList *l;
+
+	if (driver =3D=3D NULL)
+		return NULL;
+
+	ci =3D g_try_new0(struct ofono_cell_info, 1);
+	if (ci =3D=3D NULL)
+		return NULL;
+
+	ci->atom =3D __ofono_modem_add_atom(modem,
+					OFONO_ATOM_TYPE_CELL_INFO,
+					cell_info_remove, ci);
+
+	for (l =3D g_drivers; l; l =3D l->next) {
+		const struct ofono_cell_info_driver *drv =3D l->data;
+
+		if (g_strcmp0(drv->name, driver))
+			continue;
+
+		if (drv->probe(ci, vendor, data) < 0)
+			continue;
+
+		ci->driver =3D drv;
+		break;
+	}
+
+	return ci;
+}
+
+void *ofono_cell_info_get_data(struct ofono_cell_info *ci)
+{
+	return ci->driver_data;
+}
+
+void ofono_cell_info_set_data(struct ofono_cell_info *ci, void *cid)
+{
+	ci->driver_data =3D cid;
+}
+
+static int append_geran_meta_data(DBusMessageIter *iter,
+		 struct ofono_cell_info_results *ci)
+{
+	DBusMessageIter iter_array;
+	const char *type =3D "GERAN";
+
+	dbus_message_iter_open_container(iter,
+					DBUS_TYPE_ARRAY,
+					"{sv}",
+					&iter_array);
+
+	ofono_dbus_dict_append(&iter_array,
+				"Type",
+				DBUS_TYPE_STRING,
+				&type);
+	ofono_dbus_dict_append(&iter_array,
+				"MobileNetworkCode",
+				DBUS_TYPE_UINT16,
+				&ci->mnc);
+	ofono_dbus_dict_append(&iter_array,
+				"MobileCountryCode",
+				DBUS_TYPE_UINT16,
+				&ci->mcc);
+	ofono_dbus_dict_append(&iter_array,
+				"LocationAreaCode",
+				DBUS_TYPE_UINT16,
+				&ci->geran.lac);
+	ofono_dbus_dict_append(&iter_array,
+				"CellId",
+				DBUS_TYPE_UINT16,
+				&ci->geran.ci);
+
+	if (ci->geran.ta !=3D 1)
+		ofono_dbus_dict_append(&iter_array,
+					"TimingAdvance",
+					DBUS_TYPE_BYTE,
+					&ci->geran.ta);
+
+	dbus_message_iter_close_container(iter, &iter_array);
+
+	return 0;
+
+}
+
+static void add_geran_neighbor(DBusMessageIter *iter,
+		struct geran_neigh_cell *cell)
+{
+	DBusMessageIter iter_array;
+
+	dbus_message_iter_open_container(iter,
+				DBUS_TYPE_ARRAY,
+				"{sv}",
+				&iter_array);
+	ofono_dbus_dict_append(&iter_array,
+				"AbsoluteRadioFrequencyChannelNumber",
+				DBUS_TYPE_UINT16,
+				&cell->arfcn);
+	ofono_dbus_dict_append(&iter_array,
+				"BaseStationIdentityCode",
+				DBUS_TYPE_BYTE,
+				&cell->bsic);
+	ofono_dbus_dict_append(&iter_array,
+				"RXLEV",
+				DBUS_TYPE_BYTE,
+				&cell->rxlev);
+
+	dbus_message_iter_close_container(iter, &iter_array);
+}
+
+static int fill_geran_ci(DBusMessage *msg,
+		  struct ofono_cell_info_results *ci,
+		  gboolean incl_neigh)
+{
+	DBusMessageIter iter, iter_array;
+	int i;
+
+	dbus_message_iter_init_append(msg, &iter);
+	append_geran_meta_data(&iter, ci);
+
+	if (!incl_neigh)
+		return 0;
+
+	dbus_message_iter_open_container(&iter,
+					DBUS_TYPE_ARRAY,
+					"a{sv}",
+					&iter_array);
+
+	for (i =3D 0; i < ci->geran.no_cells; ++i)
+		add_geran_neighbor(&iter_array, &ci->geran.nmr[i]);
+
+	dbus_message_iter_close_container(&iter, &iter_array);
+
+	return 0;
+}
+
+static int append_utra_neigh_cell_data(DBusMessageIter *iter,
+		struct cell_measured_results *cmr)
+{
+		ofono_dbus_dict_append(iter,
+					"ScramblingCode",
+					DBUS_TYPE_UINT16,
+					&cmr->sc);
+
+		if (cmr->ucid !=3D OFONO_CI_FIELD_UCID_UNDEFINED)
+			ofono_dbus_dict_append(iter,
+					"UniqueCellId",
+					DBUS_TYPE_UINT32,
+					&cmr->ucid);
+
+		if (cmr->ecn0 !=3D OFONO_CI_FIELD_ECN0_UNDEFINED)
+			ofono_dbus_dict_append(iter,
+					"CPICH-ECN0",
+					DBUS_TYPE_BYTE,
+					&cmr->ecn0);
+
+		if (cmr->rscp !=3D OFONO_CI_FIELD_RSCP_UNDEFINED)
+			ofono_dbus_dict_append(iter,
+					"CPICH-RSCP",
+					DBUS_TYPE_INT16,
+					&cmr->rscp);
+
+		if (cmr->pathloss !=3D OFONO_CI_FIELD_PATHLOSS_UNDEFINED)
+			ofono_dbus_dict_append(iter,
+					"Pathloss",
+					DBUS_TYPE_BYTE,
+					&cmr->pathloss);
+
+	return 0;
+}
+
+static int append_utra_neigh_freq_data(DBusMessageIter *iter,
+		struct measured_results_list *mrl)
+{
+	ofono_dbus_dict_append(iter,
+				"ReceivedSignalStrengthIndicator",
+				DBUS_TYPE_BYTE,
+				&mrl->rssi);
+
+	ofono_dbus_dict_append(iter,
+				"UARFCN-DL",
+				DBUS_TYPE_UINT16,
+				&mrl->dl_freq);
+
+	if (mrl->ul_freq !=3D OFONO_CI_FIELD_FREQ_UNDEFINED)
+		ofono_dbus_dict_append(iter,
+				"UARFCN-UL",
+				DBUS_TYPE_UINT16,
+				&mrl->ul_freq);
+
+	return 0;
+}
+
+static int append_utra_neighbors(DBusMessageIter *iter,
+			struct utran *utran)
+{
+	DBusMessageIter iter_array, iter_array_array;
+	int i, j;
+
+	dbus_message_iter_open_container(iter,
+					DBUS_TYPE_ARRAY,
+					"a{sv}",
+					&iter_array);
+
+	for (i =3D 0; i < utran->no_freq; ++i) {
+
+		for (j =3D 0; j < utran->mrl[i].no_cells; ++j) {
+			dbus_message_iter_open_container(&iter_array,
+						DBUS_TYPE_ARRAY,
+						"{sv}",
+						&iter_array_array);
+			append_utra_neigh_freq_data(&iter_array_array,
+						&utran->mrl[i]);
+			append_utra_neigh_cell_data(&iter_array_array,
+						&utran->mrl[i].cmr[j]);
+
+			dbus_message_iter_close_container(&iter_array,
+					&iter_array_array);
+		}
+	}
+
+	dbus_message_iter_close_container(iter, &iter_array);
+
+	return 0;
+}
+
+static void append_utran_meta_data(DBusMessageIter *iter,
+		struct ofono_cell_info_results *ci)
+{
+	DBusMessageIter iter_array;
+	const char *type =3D "UTRA-FDD";
+
+	dbus_message_iter_open_container(iter,
+					DBUS_TYPE_ARRAY,
+					"{sv}",
+					&iter_array);
+
+	ofono_dbus_dict_append(&iter_array,
+				"Type",
+				DBUS_TYPE_STRING,
+				&type);
+	ofono_dbus_dict_append(&iter_array,
+				"MobileNetworkCode",
+				DBUS_TYPE_UINT16,
+				&ci->mnc);
+	ofono_dbus_dict_append(&iter_array,
+				"MobileCountryCode",
+				DBUS_TYPE_UINT16,
+				&ci->mcc);
+	ofono_dbus_dict_append(&iter_array,
+				"UniqueCellId",
+				DBUS_TYPE_UINT32,
+				&ci->utran.ucid);
+	ofono_dbus_dict_append(&iter_array,
+				"ScramblingCode",
+				DBUS_TYPE_UINT16,
+				&ci->utran.sc);
+	ofono_dbus_dict_append(&iter_array,
+				"UARFCN-DL",
+				DBUS_TYPE_UINT16,
+				&ci->utran.dl_freq);
+
+	if (ci->utran.ul_freq !=3D OFONO_CI_FIELD_FREQ_UNDEFINED) {
+		ofono_dbus_dict_append(&iter_array,
+				"UARFCN-UL",
+				DBUS_TYPE_UINT16,
+				&ci->utran.ul_freq);
+	}
+
+	dbus_message_iter_close_container(iter, &iter_array);
+}
+
+static int fill_utra_ci(DBusMessage *msg,
+			struct ofono_cell_info_results *ci,
+			gboolean incl_neigh)
+{
+	DBusMessageIter iter;
+
+	dbus_message_iter_init_append(msg, &iter);
+	append_utran_meta_data(&iter, ci);
+
+	if (incl_neigh)
+		append_utra_neighbors(&iter, &ci->utran);
+
+	return 0;
+}
+
+static void ofono_neigh_cell_info_query_cb(const struct ofono_error *error,
+		struct ofono_cell_info_results *ci_results, void *data)
+{
+	struct ofono_cell_info *ci =3D data;
+	DBusMessage *msg =3D ci->pending;
+	DBusMessage *reply;
+	int status;
+
+	DBG("");
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
+		ofono_error("Neighbor cell info query failed");
+		goto error;
+	}
+
+	reply =3D dbus_message_new_method_return(msg);
+	if (reply =3D=3D NULL) {
+		ofono_error("Failed to create response");
+		goto error;
+	}
+
+	if (ci_results->rat =3D=3D OFONO_CELL_TYPE_GERAN) {
+		ofono_debug("GERAN CELL INFO RECEIVED");
+
+		status =3D fill_geran_ci(reply, ci_results, ci->incl_neigh);
+		if (status !=3D 0) {
+			ofono_error("Failed to fill geran info");
+			goto error;
+		}
+
+	} else if (ci_results->rat =3D=3D OFONO_CELL_TYPE_UTRAN_FDD) {
+		ofono_debug("UTRAN CELL INFO RECEIVED");
+
+		status =3D fill_utra_ci(reply, ci_results, ci->incl_neigh);
+		if (status !=3D 0) {
+			ofono_error("Failed to fill utran info");
+			goto error;
+		}
+
+	} else {
+		ofono_error("Unrecognized cell type.");
+		goto error;
+	}
+
+	__ofono_dbus_pending_reply(&msg, reply);
+	return;
+
+error:
+	reply =3D __ofono_error_failed(msg);
+	__ofono_dbus_pending_reply(&msg, reply);
+	return;
+
+}
+
+static DBusMessage *ci_get_cells(DBusConnection *conn, DBusMessage *msg,
+					void *data)
+{
+	struct ofono_cell_info *ci =3D data;
+	DBG("");
+
+	ci->incl_neigh =3D TRUE;
+	ci->pending =3D dbus_message_ref(msg);
+	ci->driver->query(ci, ofono_neigh_cell_info_query_cb, ci->driver_data);
+
+	return NULL;
+}
+
+static DBusMessage *ci_get_properties(DBusConnection *conn, DBusMessage *m=
sg,
+					void *data)
+{
+	struct ofono_cell_info *ci =3D data;
+	DBG("");
+
+	ci->incl_neigh =3D FALSE;
+	ci->pending =3D dbus_message_ref(msg);
+	ci->driver->query(ci, ofono_neigh_cell_info_query_cb, ci->driver_data);
+
+	return NULL;
+}
-- =

1.7.1


--===============9142759147811511052==--

