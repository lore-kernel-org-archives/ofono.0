Content-Type: multipart/mixed; boundary="===============6965515841140370361=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCH 2/3] network: Add SPN watch capability
Date: Wed, 28 Dec 2011 15:18:43 +0200
Message-ID: <1325078324-30548-3-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1325078324-30548-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6965515841140370361==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/network.c |   95 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
+---
 src/ofono.h   |    7 ++++
 2 files changed, 97 insertions(+), 5 deletions(-)

diff --git a/src/network.c b/src/network.c
index 92256a8..9a685d4 100644
--- a/src/network.c
+++ b/src/network.c
@@ -84,6 +84,7 @@ struct ofono_netreg {
 	struct ofono_atom *atom;
 	unsigned int hfp_watch;
 	char *spn;
+	struct ofono_watchlist *spn_watches;
 };
 =

 struct network_operator_data {
@@ -1638,6 +1639,69 @@ static void sim_spdi_read_cb(int ok, int length, int=
 record,
 	netreg_emit_operator_display_name(netreg);
 }
 =

+gboolean __ofono_netreg_add_spn_watch(struct ofono_netreg *netreg,
+					unsigned int *id, GFunc cb,
+					void *data, ofono_destroy_func destroy)
+{
+	struct ofono_watchlist_item *item;
+	unsigned int watch_id;
+
+	DBG("%p", netreg);
+
+	if (netreg =3D=3D NULL)
+		return 0;
+
+	item =3D g_new0(struct ofono_watchlist_item, 1);
+
+	item->notify =3D cb;
+	item->destroy =3D destroy;
+	item->notify_data =3D data;
+
+	watch_id =3D __ofono_watchlist_add_item(netreg->spn_watches, item);
+	if (watch_id =3D=3D 0)
+		return FALSE;
+
+	*id =3D watch_id;
+
+	if (item->notify !=3D NULL && netreg->spn !=3D NULL)
+		cb(netreg->spn, item->notify_data);
+
+	return TRUE;
+}
+
+gboolean __ofono_netreg_remove_spn_watch(struct ofono_netreg *netreg,
+						unsigned int *id)
+{
+	gboolean ret;
+
+	DBG("%p", netreg);
+
+	if (netreg =3D=3D NULL)
+		return FALSE;
+
+	ret =3D __ofono_watchlist_remove_item(netreg->spn_watches, *id);
+	if (ret =3D=3D TRUE)
+		*id =3D 0;
+
+	return ret;
+}
+
+static void spn_watch_cb(gpointer data, gpointer user_data)
+{
+	struct ofono_watchlist_item *item =3D data;
+
+	if (item->notify)
+		((GFunc) item->notify)(user_data, item->notify_data);
+}
+
+static inline void spn_watches_notify(struct ofono_netreg *netreg)
+{
+	if (netreg->spn_watches->items =3D=3D NULL)
+		return;
+
+	g_slist_foreach(netreg->spn_watches->items, spn_watch_cb, netreg->spn);
+}
+
 static void sim_spn_display_condition_parse(struct ofono_netreg *netreg,
 						guint8 dcbyte)
 {
@@ -1691,10 +1755,16 @@ static void sim_cphs_spn_short_read_cb(int ok, int =
length, int record,
 =

 	netreg->flags &=3D ~NETWORK_REGISTRATION_FLAG_READING_SPN;
 =

-	if (!ok)
+	if (!ok) {
+		spn_watches_notify(netreg);
 		return;
+	}
+
+	sim_spn_parse(data, length, &netreg->spn);
 =

-	if (!sim_spn_parse(data, length, &netreg->spn))
+	spn_watches_notify(netreg);
+
+	if (netreg->spn =3D=3D NULL)
 		return;
 =

 	if (netreg->current_operator)
@@ -1714,15 +1784,21 @@ static void sim_cphs_spn_read_cb(int ok, int length=
, int record,
 					SIM_EF_CPHS_SPN_SHORT_FILEID,
 					OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
 					sim_cphs_spn_short_read_cb, netreg);
-		else
+		else {
 			netreg->flags &=3D ~NETWORK_REGISTRATION_FLAG_READING_SPN;
+			spn_watches_notify(netreg);
+		}
 =

 		return;
 	}
 =

 	netreg->flags &=3D ~NETWORK_REGISTRATION_FLAG_READING_SPN;
 =

-	if (!sim_spn_parse(data, length, &netreg->spn))
+	sim_spn_parse(data, length, &netreg->spn);
+
+	spn_watches_notify(netreg);
+
+	if (netreg->spn =3D=3D NULL)
 		return;
 =

 	if (netreg->current_operator)
@@ -1746,7 +1822,11 @@ static void sim_spn_read_cb(int ok, int length, int =
record,
 =

 	netreg->flags &=3D ~NETWORK_REGISTRATION_FLAG_READING_SPN;
 =

-	if (!sim_spn_parse(data + 1, length - 1, &netreg->spn))
+	sim_spn_parse(data + 1, length - 1, &netreg->spn);
+
+	spn_watches_notify(netreg);
+
+	if (netreg->spn =3D=3D NULL)
 		return;
 =

 	sim_spn_display_condition_parse(netreg, data[0]);
@@ -1888,6 +1968,9 @@ static void netreg_unregister(struct ofono_atom *atom)
 =

 	__ofono_modem_remove_atom_watch(modem, netreg->hfp_watch);
 =

+	__ofono_watchlist_free(netreg->spn_watches);
+	netreg->spn_watches =3D NULL;
+
 	__ofono_watchlist_free(netreg->status_watches);
 	netreg->status_watches =3D NULL;
 =

@@ -2171,6 +2254,8 @@ void ofono_netreg_register(struct ofono_netreg *netre=
g)
 		return;
 	}
 =

+	netreg->spn_watches =3D __ofono_watchlist_new(g_free);
+
 	netreg->status_watches =3D __ofono_watchlist_new(g_free);
 =

 	ofono_modem_add_interface(modem, OFONO_NETWORK_REGISTRATION_INTERFACE);
diff --git a/src/ofono.h b/src/ofono.h
index 0e3009e..5427f0c 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -423,6 +423,13 @@ unsigned int __ofono_netreg_add_status_watch(struct of=
ono_netreg *netreg,
 gboolean __ofono_netreg_remove_status_watch(struct ofono_netreg *netreg,
 						unsigned int id);
 =

+gboolean __ofono_netreg_add_spn_watch(struct ofono_netreg *netreg,
+					unsigned int *id, GFunc cb,
+					void *data, ofono_destroy_func destroy);
+
+gboolean __ofono_netreg_remove_spn_watch(struct ofono_netreg *netreg,
+						unsigned int *id);
+
 void __ofono_netreg_set_base_station_name(struct ofono_netreg *netreg,
 						const char *name);
 =

-- =

1.7.5.4


--===============6965515841140370361==--

