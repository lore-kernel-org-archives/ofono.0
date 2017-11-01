Content-Type: multipart/mixed; boundary="===============6248787594714875465=="
MIME-Version: 1.0
From: James Prestwood <james.prestwood@linux.intel.com>
Subject: [PATCH 2/8] sim: header definitions for AID session APIs
Date: Wed, 01 Nov 2017 10:33:42 -0700
Message-ID: <1509557628-15121-2-git-send-email-james.prestwood@linux.intel.com>
In-Reply-To: <1509557628-15121-1-git-send-email-james.prestwood@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6248787594714875465==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

ISIM and newer AID's require opening a logical channel to read
their EF's. This requires new driver API's to discover AID's,
open/close a channel, and reading the EF's from an opened channel.

This functionality was moved from the simauth module.
---
 include/sim.h | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/include/sim.h b/include/sim.h
index 0c91ce2..aeceef6 100644
--- a/include/sim.h
+++ b/include/sim.h
@@ -121,6 +121,17 @@ typedef void (*ofono_sim_lock_unlock_cb_t)(const struc=
t ofono_error *error,
 typedef void (*ofono_query_facility_lock_cb_t)(const struct ofono_error *e=
rror,
 					ofono_bool_t status, void *data);
 =

+typedef void (*ofono_sim_list_apps_cb_t)(const struct ofono_error *error,
+					const unsigned char *dataobj,
+					int len, void *data);
+typedef void (*ofono_sim_open_channel_cb_t)(const struct ofono_error *erro=
r,
+					int session_id, void *data);
+
+typedef void (*ofono_sim_close_channel_cb_t)(const struct ofono_error *err=
or,
+					void *data);
+
+typedef void (*ofono_sim_get_session_cb_t)(int session, void *data);
+
 struct ofono_sim_driver {
 	const char *name;
 	int (*probe)(struct ofono_sim *sim, unsigned int vendor, void *data);
@@ -173,6 +184,16 @@ struct ofono_sim_driver {
 	void (*query_facility_lock)(struct ofono_sim *sim,
 			enum ofono_sim_password_type lock,
 			ofono_query_facility_lock_cb_t cb, void *data);
+	void (*list_apps)(struct ofono_sim *sim,
+			ofono_sim_list_apps_cb_t cb, void *data);
+	void (*open_channel)(struct ofono_sim *sim, const unsigned char *aid,
+			ofono_sim_open_channel_cb_t cb, void *data);
+	void (*close_channel)(struct ofono_sim *sim, int session_id,
+			ofono_sim_close_channel_cb_t cb, void *data);
+	void (*read_file_session)(struct ofono_sim *sim, int session,
+			int fileid, int start, int length,
+			const unsigned char *path, unsigned int path_len,
+			ofono_sim_read_cb_t cb, void *data);
 };
 =

 int ofono_sim_driver_register(const struct ofono_sim_driver *d);
@@ -248,6 +269,13 @@ unsigned int ofono_sim_add_file_watch(struct ofono_sim=
_context *context,
 void ofono_sim_remove_file_watch(struct ofono_sim_context *context,
 					unsigned int id);
 =

+struct sim_app_record **ofono_sim_get_aid_list(struct ofono_sim *sim);
+
+int ofono_sim_get_session(struct ofono_sim *sim, unsigned char *aid,
+		ofono_sim_get_session_cb_t cb, void *data);
+
+int ofono_sim_release_session(struct ofono_sim *sim, int session_id);
+
 #ifdef __cplusplus
 }
 #endif
-- =

2.7.4


--===============6248787594714875465==--

