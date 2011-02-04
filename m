Content-Type: multipart/mixed; boundary="===============0124457956638461905=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 1/4] Add SIM filesystem watch api.
Date: Fri, 04 Feb 2011 02:20:31 +0100
Message-ID: <1296782434-11008-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0124457956638461905==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This allows code that reads files from the SIM card to also watch for
changes in these files signalled in a Refresh command by the SIM.
---
 include/sim.h |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/include/sim.h b/include/sim.h
index 137e825..deed81b 100644
--- a/include/sim.h
+++ b/include/sim.h
@@ -118,6 +118,8 @@ typedef void (*ofono_sim_lock_unlock_cb_t)(const struct=
 ofono_error *error,
 typedef void (*ofono_sim_locked_cb_t)(const struct ofono_error *error,
 					int locked, void *data);
 =

+typedef void (*ofono_sim_file_notify_t)(int id, void *userdata);
+
 struct ofono_sim_driver {
 	const char *name;
 	int (*probe)(struct ofono_sim *sim, unsigned int vendor, void *data);
@@ -218,6 +220,13 @@ int ofono_sim_write(struct ofono_sim_context *context,=
 int id,
 int ofono_sim_read_bytes(struct ofono_sim_context *context, int id,
 			unsigned short offset, unsigned short num_bytes,
 			ofono_sim_file_read_cb_t cb, void *data);
+
+int ofono_sim_add_file_watch(struct ofono_sim_context *context, int id,
+			ofono_sim_file_notify_t notify, void *userdata);
+
+void ofono_sim_remove_file_watch(struct ofono_sim_context *context, int id,
+			ofono_sim_file_notify_t notify, void *userdata);
+
 #ifdef __cplusplus
 }
 #endif
-- =

1.7.1.86.g0e460.dirty


--===============0124457956638461905==--

