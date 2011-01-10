Content-Type: multipart/mixed; boundary="===============3782980199898144333=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 2/5] Add SIM filesystem watch api.
Date: Mon, 10 Jan 2011 12:01:32 +0100
Message-ID: <1294657295-14041-2-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1294657295-14041-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3782980199898144333==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This allows code that reads files from the SIM card to also watch for
changes in these files signalled in a Refresh command by the SIM.
---
 include/sim.h |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/include/sim.h b/include/sim.h
index 7860e24..aab981c 100644
--- a/include/sim.h
+++ b/include/sim.h
@@ -114,6 +114,8 @@ typedef void (*ofono_sim_lock_unlock_cb_t)(const struct=
 ofono_error *error,
 typedef void (*ofono_sim_locked_cb_t)(const struct ofono_error *error,
 					int locked, void *data);
 =

+typedef void (*ofono_sim_file_notify_t)(int id, void *userdata);
+
 struct ofono_sim_driver {
 	const char *name;
 	int (*probe)(struct ofono_sim *sim, unsigned int vendor, void *data);
@@ -207,6 +209,14 @@ int ofono_sim_write(struct ofono_sim *sim, int id,
 int ofono_sim_read_bytes(struct ofono_sim *sim, int id,
 			unsigned short offset, unsigned short num_bytes,
 			ofono_sim_file_read_cb_t cb, void *data);
+
+int ofono_sim_add_file_watch(struct ofono_sim *sim, int id,
+			enum ofono_sim_state reset_state,
+			ofono_sim_file_notify_t notify, void *userdata);
+
+void ofono_sim_remove_file_watch(struct ofono_sim *sim, int id,
+			ofono_sim_file_notify_t notify, void *userdata);
+
 #ifdef __cplusplus
 }
 #endif
-- =

1.7.1.86.g0e460.dirty


--===============3782980199898144333==--

