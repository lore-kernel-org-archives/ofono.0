Content-Type: multipart/mixed; boundary="===============2181368020753767691=="
MIME-Version: 1.0
From: Samrat Guha Niyogi <samrat.guha.niyogi@intel.com>
Subject: [PATCH] sim: include changes for query facility lock
Date: Wed, 27 Apr 2016 21:03:04 +0530
Message-ID: <1461771184-24640-1-git-send-email-samrat.guha.niyogi@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2181368020753767691==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/sim.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/sim.h b/include/sim.h
index ed850f9..9470d4d 100644
--- a/include/sim.h
+++ b/include/sim.h
@@ -121,6 +121,9 @@ typedef void (*ofono_sim_lock_unlock_cb_t)(const struct=
 ofono_error *error,
 typedef void (*ofono_sim_locked_cb_t)(const struct ofono_error *error,
 					int locked, void *data);
 =

+typedef void (*ofono_query_facility_lock_cb_t)(const struct ofono_error *e=
rror,
+					ofono_bool_t status, void *data);
+
 struct ofono_sim_driver {
 	const char *name;
 	int (*probe)(struct ofono_sim *sim, unsigned int vendor, void *data);
@@ -173,6 +176,9 @@ struct ofono_sim_driver {
 	void (*query_locked)(struct ofono_sim *sim,
 			enum ofono_sim_password_type type,
 			ofono_sim_locked_cb_t cb, void *data);
+	void (*query_facility_lock)(struct ofono_sim *sim,
+			enum ofono_sim_password_type lock,
+			ofono_query_facility_lock_cb_t cb, void *data);
 };
 =

 int ofono_sim_driver_register(const struct ofono_sim_driver *d);
-- =

1.9.1


--===============2181368020753767691==--

