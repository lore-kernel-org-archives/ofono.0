Content-Type: multipart/mixed; boundary="===============7970454920603591972=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 4/5] ofono_sim_context api header changes.
Date: Sat, 29 Jan 2011 01:29:20 +0100
Message-ID: <1296260961-15155-4-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1296260961-15155-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7970454920603591972==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch introduces sim FS contexts which are used to queue file
read and write operations.  When a context is freed all pending
operations in that context are cancelled preventing callbacks from
being called causing segfaults.  This patch breaks the build without
patch 5/5.

ofono_sim_read/_write function names are not changed because they
seem better names than ofono_sim_context_read/_write.
---
 include/sim.h |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/sim.h b/include/sim.h
index 5e3ba5b..137e825 100644
--- a/include/sim.h
+++ b/include/sim.h
@@ -29,6 +29,7 @@ extern "C" {
 #include <ofono/types.h>
 =

 struct ofono_sim;
+struct ofono_sim_context;
 =

 /* 51.011 Section 9.3 */
 enum ofono_sim_file_structure {
@@ -195,6 +196,9 @@ enum ofono_sim_state ofono_sim_get_state(struct ofono_s=
im *sim);
 =

 void ofono_sim_inserted_notify(struct ofono_sim *sim, ofono_bool_t inserte=
d);
 =

+struct ofono_sim_context *ofono_sim_context_create(struct ofono_sim *sim);
+void ofono_sim_context_free(struct ofono_sim_context *context);
+
 /* This will queue an operation to read all available records with id from=
 the
  * SIM.  Callback cb will be called every time a record has been read, or =
once
  * if an error has occurred.  For transparent files, the callback will only
@@ -202,16 +206,16 @@ void ofono_sim_inserted_notify(struct ofono_sim *sim,=
 ofono_bool_t inserted);
  *
  * Returns 0 if the request could be queued, -1 otherwise.
  */
-int ofono_sim_read(struct ofono_sim *sim, int id,
+int ofono_sim_read(struct ofono_sim_context *context, int id,
 			enum ofono_sim_file_structure expected,
 			ofono_sim_file_read_cb_t cb, void *data);
 =

-int ofono_sim_write(struct ofono_sim *sim, int id,
+int ofono_sim_write(struct ofono_sim_context *context, int id,
 			ofono_sim_file_write_cb_t cb,
 			enum ofono_sim_file_structure structure, int record,
 			const unsigned char *data, int length, void *userdata);
 =

-int ofono_sim_read_bytes(struct ofono_sim *sim, int id,
+int ofono_sim_read_bytes(struct ofono_sim_context *context, int id,
 			unsigned short offset, unsigned short num_bytes,
 			ofono_sim_file_read_cb_t cb, void *data);
 #ifdef __cplusplus
-- =

1.7.1.86.g0e460.dirty


--===============7970454920603591972==--

