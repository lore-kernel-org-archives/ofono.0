Content-Type: multipart/mixed; boundary="===============0891205231054496976=="
MIME-Version: 1.0
From: Forest Bond <forest@alittletooquiet.net>
Subject: [PATCH 1/2] gprs: Support probing provision data from device.
Date: Wed, 05 Dec 2012 14:01:44 -0500
Message-ID: <20121205190143.GA27739@alittletooquiet.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0891205231054496976==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Forest Bond <forest.bond@rapidrollout.com>

Many devices retain previously defined PDP context parameters.  Now
drivers can retrieve and store this information during probe and it is
used as a fallback if normal provisioning fails.
---
 include/gprs.h |    3 +++
 src/gprs.c     |   12 ++++++++++++
 2 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/include/gprs.h b/include/gprs.h
index 6c46d18..72ac0fa 100644
--- a/include/gprs.h
+++ b/include/gprs.h
@@ -30,6 +30,7 @@ extern "C" {
 =

 struct ofono_gprs;
 struct ofono_gprs_context;
+struct ofono_gprs_provision_data;
 =

 typedef void (*ofono_gprs_status_cb_t)(const struct ofono_error *error,
 						int status, void *data);
@@ -75,6 +76,8 @@ void *ofono_gprs_get_data(struct ofono_gprs *gprs);
 =

 void ofono_gprs_set_cid_range(struct ofono_gprs *gprs,
 				unsigned int min, unsigned int max);
+void ofono_gprs_set_probed_ap(struct ofono_gprs *gprs,
+				struct ofono_gprs_provision_data *ap);
 void ofono_gprs_add_context(struct ofono_gprs *gprs,
 				struct ofono_gprs_context *gc);
 =

diff --git a/src/gprs.c b/src/gprs.c
index e379f7b..5768642 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -96,6 +96,7 @@ struct ofono_gprs {
 	void *driver_data;
 	struct ofono_atom *atom;
 	unsigned int spn_watch;
+	struct ofono_gprs_provision_data *probed_ap;
 };
 =

 struct ipv4_settings {
@@ -2594,6 +2595,8 @@ static void gprs_unregister(struct ofono_atom *atom)
 		ofono_sim_remove_spn_watch(sim, &gprs->spn_watch);
 	}
 =

+	g_free(gprs->probed_ap);
+
 	ofono_modem_remove_interface(modem,
 					OFONO_CONNECTION_MANAGER_INTERFACE);
 	g_dbus_unregister_interface(conn, path,
@@ -3016,6 +3019,12 @@ static void ofono_gprs_finish_register(struct ofono_=
gprs *gprs)
 	__ofono_atom_register(gprs->atom, gprs_unregister);
 }
 =

+void ofono_gprs_set_probed_ap(struct ofono_gprs *gprs,
+				struct ofono_gprs_provision_data *ap)
+{
+	gprs->probed_ap =3D ap;
+}
+
 static void spn_read_cb(const char *spn, const char *dc, void *data)
 {
 	struct ofono_gprs *gprs	=3D data;
@@ -3027,6 +3036,9 @@ static void spn_read_cb(const char *spn, const char *=
dc, void *data)
 =

 	ofono_sim_remove_spn_watch(sim, &gprs->spn_watch);
 =

+	if (gprs->contexts =3D=3D NULL && gprs->probed_ap !=3D NULL)
+		provision_context(gprs->probed_ap, gprs);
+
 	ofono_gprs_finish_register(gprs);
 }
 =

-- =

1.7.0.4

--===============0891205231054496976==--

