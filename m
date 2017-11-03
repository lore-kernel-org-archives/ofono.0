Content-Type: multipart/mixed; boundary="===============2787410825676070721=="
MIME-Version: 1.0
From: James Prestwood <james.prestwood@linux.intel.com>
Subject: [PATCHv2 1/4] sim: header definitions for AID session APIs
Date: Fri, 03 Nov 2017 15:34:41 -0700
Message-ID: <1509748484-8773-1-git-send-email-james.prestwood@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2787410825676070721==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

ISIM and newer AID's require opening a logical channel to read
their EF's. This requires new driver API's to discover AID's,
open/close a channel, and reading the EF's from an opened channel.

This functionality was moved from the simauth module.
---
 include/sim.h | 30 ++++++++++++++++++++++++++++++
 src/ofono.h   | 27 +++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/include/sim.h b/include/sim.h
index 0c91ce2..4c0d4b1 100644
--- a/include/sim.h
+++ b/include/sim.h
@@ -121,6 +121,18 @@ typedef void (*ofono_sim_lock_unlock_cb_t)(const struc=
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
+typedef void (*ofono_sim_session_event_cb_t)(ofono_bool_t active,
+		int session_id, void *data);
+
 struct ofono_sim_driver {
 	const char *name;
 	int (*probe)(struct ofono_sim *sim, unsigned int vendor, void *data);
@@ -173,6 +185,24 @@ struct ofono_sim_driver {
 	void (*query_facility_lock)(struct ofono_sim *sim,
 			enum ofono_sim_password_type lock,
 			ofono_query_facility_lock_cb_t cb, void *data);
+	void (*list_apps)(struct ofono_sim *sim,
+			ofono_sim_list_apps_cb_t cb, void *data);
+	void (*open_channel)(struct ofono_sim *sim, const unsigned char *aid,
+			ofono_sim_open_channel_cb_t cb, void *data);
+	void (*close_channel)(struct ofono_sim *sim, int session_id,
+			ofono_sim_close_channel_cb_t cb, void *data);
+	void (*session_read_binary)(struct ofono_sim *sim, int session,
+			int fileid, int start, int length,
+			const unsigned char *path, unsigned int path_len,
+			ofono_sim_read_cb_t cb, void *data);
+	void (*session_read_record)(struct ofono_sim *sim, int session_id,
+			int fileid, int record, int length,
+			const unsigned char *path, unsigned int path_len,
+			ofono_sim_read_cb_t cb, void *data);
+	void (*session_read_info)(struct ofono_sim *sim, int session_id,
+			int fileid, const unsigned char *path,
+			unsigned int path_len, ofono_sim_file_info_cb_t cb,
+			void *data);
 };
 =

 int ofono_sim_driver_register(const struct ofono_sim_driver *d);
diff --git a/src/ofono.h b/src/ofono.h
index bac4b48..ddfd045 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -370,6 +370,9 @@ unsigned short __ofono_sms_get_next_ref(struct ofono_sm=
s *sms);
 =

 #include <ofono/sim.h>
 =

+struct ofono_sim_aid_session;
+enum sim_app_type;
+
 ofono_bool_t __ofono_sim_ust_service_available(struct ofono_sim *sim,
 						int ust_service);
 ofono_bool_t __ofono_sim_service_available(struct ofono_sim *sim,
@@ -389,6 +392,30 @@ void __ofono_sim_refresh(struct ofono_sim *sim, GSList=
 *file_list,
 =

 void __ofono_sim_recheck_pin(struct ofono_sim *sim);
 =

+GSList *__ofono_sim_get_aid_list(struct ofono_sim *sim);
+
+unsigned int __ofono_sim_add_session_watch(
+		struct ofono_sim_aid_session *session,
+		ofono_sim_session_event_cb_t notify, void *data,
+		ofono_destroy_func destroy);
+
+void __ofono_sim_remove_session_watch(struct ofono_sim_aid_session *sessio=
n,
+		unsigned int id);
+
+struct ofono_sim_aid_session *__ofono_sim_get_session_by_aid(
+		struct ofono_sim *sim, unsigned char *aid);
+
+struct ofono_sim_aid_session *__ofono_sim_get_session_by_type(
+		struct ofono_sim *sim, enum sim_app_type type);
+
+int __ofono_sim_session_get_id(struct ofono_sim_aid_session *session);
+
+enum sim_app_type __ofono_sim_session_get_type(
+		struct ofono_sim_aid_session *session);
+
+unsigned char *__ofono_sim_session_get_aid(
+		struct ofono_sim_aid_session *session);
+
 #include <ofono/stk.h>
 =

 typedef void (*__ofono_sms_sim_download_cb_t)(ofono_bool_t ok,
-- =

2.7.4


--===============2787410825676070721==--

