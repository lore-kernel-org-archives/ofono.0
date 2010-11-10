Content-Type: multipart/mixed; boundary="===============4517492470744184060=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 1/3] sim: Add sim_service_available() for querying EFsst or
 EFust.
Date: Wed, 10 Nov 2010 04:27:50 +0100
Message-ID: <1289359672-19206-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4517492470744184060==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The function is not public api because the service constants are in
src/simutil.h.
---
 src/ofono.h |    5 +++++
 src/sim.c   |   15 +++++++++++++++
 2 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/src/ofono.h b/src/ofono.h
index e5b4acb..4d76d20 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -281,6 +281,11 @@ gboolean __ofono_sms_datagram_watch_remove(struct ofon=
o_sms *sms,
 unsigned short __ofono_sms_get_next_ref(struct ofono_sms *sms);
 =

 #include <ofono/sim.h>
+
+ofono_bool_t __ofono_sim_service_available(struct ofono_sim *sim,
+						int ust_service,
+						int sst_service);
+
 #include <ofono/stk.h>
 =

 typedef void (*__ofono_sms_sim_download_cb_t)(ofono_bool_t ok,
diff --git a/src/sim.c b/src/sim.c
index e5e304c..f362565 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -1928,6 +1928,21 @@ const unsigned char *ofono_sim_get_cphs_service_tabl=
e(struct ofono_sim *sim)
 	return sim->cphs_service_table;
 }
 =

+ofono_bool_t __ofono_sim_service_available(struct ofono_sim *sim,
+						int ust_service,
+						int sst_service)
+{
+	if (sim->efust)
+		return sim_ust_is_available(sim->efust, sim->efust_length,
+						ust_service);
+
+	if (sim->efsst)
+		return sim_sst_is_active(sim->efsst, sim->efsst_length,
+						sst_service);
+
+	return FALSE;
+}
+
 static void sim_inserted_update(struct ofono_sim *sim)
 {
 	DBusConnection *conn =3D ofono_dbus_get_connection();
-- =

1.7.1.86.g0e460.dirty


--===============4517492470744184060==--

