Content-Type: multipart/mixed; boundary="===============6137156425598828195=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 3/3] call-forwarding: Watch for changes to relevant SIM files.
Date: Sat, 19 Feb 2011 04:54:29 +0100
Message-ID: <1298087669-11558-3-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1298087669-11558-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6137156425598828195==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/call-forwarding.c |   45 ++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 44 insertions(+), 1 deletions(-)

diff --git a/src/call-forwarding.c b/src/call-forwarding.c
index d13f990..fe535b8 100644
--- a/src/call-forwarding.c
+++ b/src/call-forwarding.c
@@ -1358,8 +1358,31 @@ static void sim_cphs_cff_read_cb(int ok, int total_l=
ength, int record,
 					DBUS_TYPE_BOOLEAN, &cfu_voice);
 }
 =

-static void sim_read_cf_indicator(struct ofono_call_forwarding *cf)
+static void sim_cfis_changed(int id, void *userdata)
 {
+	struct ofono_call_forwarding *cf =3D userdata;
+
+	if (((cf->flags & CALL_FORWARDING_FLAG_CPHS_CFF) ||
+			cf->cfis_record_id > 0) && is_cfu_enabled(cf, NULL)) {
+		DBusConnection *conn =3D ofono_dbus_get_connection();
+		const char *path =3D __ofono_atom_get_path(cf->atom);
+		ofono_bool_t status =3D FALSE;
+
+		ofono_dbus_signal_property_changed(conn, path,
+					OFONO_CALL_FORWARDING_INTERFACE,
+					"ForwardingFlagOnSim",
+					DBUS_TYPE_BOOLEAN, &status);
+	}
+
+	cf->cfis_record_id =3D 0;
+	cf->flags &=3D ~CALL_FORWARDING_FLAG_CPHS_CFF;
+
+	/*
+	 * TODO: remove forwarding rules in
+	 * cf->cf_conditions[CALL_FORWARDING_TYPE_UNCONDITIONAL] that
+	 * originate from EFcfis before adding the new rules?
+	 */
+
 	if (__ofono_sim_service_available(cf->sim,
 			SIM_UST_SERVICE_CFIS,
 			SIM_SST_SERVICE_CFIS) =3D=3D TRUE)
@@ -1372,6 +1395,26 @@ static void sim_read_cf_indicator(struct ofono_call_=
forwarding *cf)
 				sim_cphs_cff_read_cb, cf);
 }
 =

+static void sim_read_cf_indicator(struct ofono_call_forwarding *cf)
+{
+	if (__ofono_sim_service_available(cf->sim,
+			SIM_UST_SERVICE_CFIS,
+			SIM_SST_SERVICE_CFIS) =3D=3D TRUE) {
+		ofono_sim_read(cf->sim_context, SIM_EFCFIS_FILEID,
+				OFONO_SIM_FILE_STRUCTURE_FIXED,
+				sim_cfis_read_cb, cf);
+		ofono_sim_add_file_watch(cf->sim_context, SIM_EFCFIS_FILEID,
+						sim_cfis_changed, cf, NULL);
+	} else {
+		ofono_sim_read(cf->sim_context, SIM_EF_CPHS_CFF_FILEID,
+				OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
+				sim_cphs_cff_read_cb, cf);
+		ofono_sim_add_file_watch(cf->sim_context,
+						SIM_EF_CPHS_CFF_FILEID,
+						sim_cfis_changed, cf, NULL);
+	}
+}
+
 int ofono_call_forwarding_driver_register(const struct ofono_call_forwardi=
ng_driver *d)
 {
 	DBG("driver: %p, name: %s", d, d->name);
-- =

1.7.1.86.g0e460.dirty


--===============6137156425598828195==--

