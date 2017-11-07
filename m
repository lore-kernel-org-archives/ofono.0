Content-Type: multipart/mixed; boundary="===============6745096492281204891=="
MIME-Version: 1.0
From: James Prestwood <james.prestwood@linux.intel.com>
Subject: [PATCH 1/3] sim: logical access API
Date: Tue, 07 Nov 2017 08:42:48 -0800
Message-ID: <1510072970-19030-1-git-send-email-james.prestwood@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6745096492281204891==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Moved logical access API from simauth to sim atom. This removes
the need for a simauth driver completely, as the rest of the
functionality was moved in previous commits.
---
 include/sim.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/sim.h b/include/sim.h
index 23a9bc2..d37e4f1 100644
--- a/include/sim.h
+++ b/include/sim.h
@@ -129,6 +129,9 @@ typedef void (*ofono_sim_open_channel_cb_t)(const struc=
t ofono_error *error,
 typedef void (*ofono_sim_close_channel_cb_t)(const struct ofono_error *err=
or,
 					void *data);
 =

+typedef void (*ofono_sim_logical_access_cb_t)(const struct ofono_error *er=
ror,
+		const unsigned char *resp, unsigned int len, void *data);
+
 struct ofono_sim_driver {
 	const char *name;
 	int (*probe)(struct ofono_sim *sim, unsigned int vendor, void *data);
@@ -199,6 +202,9 @@ struct ofono_sim_driver {
 			int fileid, const unsigned char *path,
 			unsigned int path_len, ofono_sim_file_info_cb_t cb,
 			void *data);
+	void (*logical_access)(struct ofono_sim *sim, int session_id,
+			const unsigned char *pdu, unsigned int len,
+			ofono_sim_logical_access_cb_t cb, void *data);
 };
 =

 int ofono_sim_driver_register(const struct ofono_sim_driver *d);
@@ -278,6 +284,10 @@ unsigned int ofono_sim_add_file_watch(struct ofono_sim=
_context *context,
 void ofono_sim_remove_file_watch(struct ofono_sim_context *context,
 					unsigned int id);
 =

+int ofono_sim_logical_access(struct ofono_sim *sim, int session_id,
+		unsigned char *pdu, unsigned int len,
+		ofono_sim_logical_access_cb_t cb, void *data);
+
 #ifdef __cplusplus
 }
 #endif
-- =

2.7.4


--===============6745096492281204891==--

