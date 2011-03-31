Content-Type: multipart/mixed; boundary="===============7344642630135486444=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH] cf: Reregister CallForwarding atom on EF-CFIS refresh.
Date: Thu, 31 Mar 2011 15:01:23 +0200
Message-ID: <1301576483-2990-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7344642630135486444==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/call-forwarding.c |   47 +++++++++++++++------------------------------=
--
 1 files changed, 15 insertions(+), 32 deletions(-)

diff --git a/src/call-forwarding.c b/src/call-forwarding.c
index 84d3067..7ce6dd4 100644
--- a/src/call-forwarding.c
+++ b/src/call-forwarding.c
@@ -74,6 +74,7 @@ static void get_query_next_cf_cond(struct ofono_call_forw=
arding *cf);
 static void set_query_next_cf_cond(struct ofono_call_forwarding *cf);
 static void ss_set_query_next_cf_cond(struct ofono_call_forwarding *cf);
 static void cf_unregister_ss_controls(struct ofono_call_forwarding *cf);
+static void call_forwarding_unregister(struct ofono_atom *atom);
 =

 struct cf_ss_request {
 	int ss_type;
@@ -1368,41 +1369,21 @@ static void sim_cfis_changed(int id, void *userdata)
 {
 	struct ofono_call_forwarding *cf =3D userdata;
 =

-	if (cf->flags & CALL_FORWARDING_FLAG_CACHED)
-		goto done;
-
-	if (((cf->flags & CALL_FORWARDING_FLAG_CPHS_CFF) ||
-			cf->cfis_record_id > 0) && is_cfu_enabled(cf, NULL)) {
-		DBusConnection *conn =3D ofono_dbus_get_connection();
-		const char *path =3D __ofono_atom_get_path(cf->atom);
-		ofono_bool_t status =3D FALSE;
-
-		ofono_dbus_signal_property_changed(conn, path,
-					OFONO_CALL_FORWARDING_INTERFACE,
-					"ForwardingFlagOnSim",
-					DBUS_TYPE_BOOLEAN, &status);
-	}
-
-done:
-	cf->cfis_record_id =3D 0;
-	cf->flags &=3D ~CALL_FORWARDING_FLAG_CPHS_CFF;
+	if (!(cf->flags & CALL_FORWARDING_FLAG_CACHED))
+		return;
 =

 	/*
-	 * TODO: remove forwarding rules in
-	 * cf->cf_conditions[CALL_FORWARDING_TYPE_UNCONDITIONAL] that
-	 * originate from EFcfis before adding the new rules?
+	 * If the values are cached it's because at least one client
+	 * requested them and we need to notify them about this
+	 * change.  However the authoritative source of current
+	 * Call-Forwarding settings is the network operator and the
+	 * query can take a noticeable amount of time.  Instead of
+	 * sedning PropertyChanged, we reregister the Call Forwarding
+	 * atom.  The client will invoke GetProperties only if it
+	 * is still interested.
 	 */
-
-	if (__ofono_sim_service_available(cf->sim,
-			SIM_UST_SERVICE_CFIS,
-			SIM_SST_SERVICE_CFIS) =3D=3D TRUE)
-		ofono_sim_read(cf->sim_context, SIM_EFCFIS_FILEID,
-				OFONO_SIM_FILE_STRUCTURE_FIXED,
-				sim_cfis_read_cb, cf);
-	else
-		ofono_sim_read(cf->sim_context, SIM_EF_CPHS_CFF_FILEID,
-				OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
-				sim_cphs_cff_read_cb, cf);
+	call_forwarding_unregister(cf->atom);
+	ofono_call_forwarding_register(cf);
 }
 =

 static void sim_read_cf_indicator(struct ofono_call_forwarding *cf)
@@ -1465,6 +1446,8 @@ static void call_forwarding_unregister(struct ofono_a=
tom *atom)
 =

 	if (cf->ussd_watch)
 		__ofono_modem_remove_atom_watch(modem, cf->ussd_watch);
+
+	cf->flags =3D 0;
 }
 =

 static void call_forwarding_remove(struct ofono_atom *atom)
-- =

1.7.1.86.g0e460.dirty


--===============7344642630135486444==--

