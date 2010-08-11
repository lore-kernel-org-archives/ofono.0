Content-Type: multipart/mixed; boundary="===============1705223865333901386=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 04/16] emulator: Add APIs to send GAtServer result
Date: Wed, 11 Aug 2010 10:26:29 +0800
Message-ID: <1281493601-14351-5-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1281493601-14351-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1705223865333901386==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Defines APIs to send final/intermediate/unsolicited result to DUN
client.
---
 include/emulator.h |    2 ++
 src/emulator.c     |   28 ++++++++++++++++++++++++++++
 src/ofono.h        |   11 +++++++++++
 3 files changed, 41 insertions(+), 0 deletions(-)

diff --git a/include/emulator.h b/include/emulator.h
index 29e87b9..2a45c65 100644
--- a/include/emulator.h
+++ b/include/emulator.h
@@ -36,6 +36,8 @@ enum ofono_emulator_status {
 	OFONO_EMULATOR_STATUS_DESTROY,
 };
 =

+enum _GAtServerResult;
+
 struct ofono_emulator *ofono_emulator_create(struct ofono_modem *modem,
 						enum ofono_atom_type type,
 						GIOChannel *io);
diff --git a/src/emulator.c b/src/emulator.c
index f9e82a0..9ecc06c 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -71,6 +71,34 @@ static void ofono_emulator_release_id(int id)
 	ofono_emulator_ids &=3D ~(0x1 << id);
 }
 =

+void ofono_emulator_send_final(struct ofono_emulator *e, GAtServerResult r=
esult)
+{
+	g_at_server_send_final(e->server, result);
+}
+
+void ofono_emulator_send_ext_final(struct ofono_emulator *e, const char *r=
esult)
+{
+	g_at_server_send_ext_final(e->server, result);
+}
+
+void ofono_emulator_send_intermediate(struct ofono_emulator *e,
+						const char *result)
+{
+	g_at_server_send_intermediate(e->server, result);
+}
+
+void ofono_emulator_send_unsolicited(struct ofono_emulator *e,
+						const char *result)
+{
+	g_at_server_send_unsolicited(e->server, result);
+}
+
+void ofono_emulator_send_info(struct ofono_emulator *e, const char *line,
+						gboolean last)
+{
+	g_at_server_send_info(e->server, line, last);
+}
+
 static void notify_status_watches(struct ofono_emulator *e, void *data)
 {
 	struct ofono_watchlist_item *item;
diff --git a/src/ofono.h b/src/ofono.h
index a7a9849..d5c600d 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -303,3 +303,14 @@ unsigned int __ofono_emulator_add_status_watch(struct =
ofono_emulator *e,
 =

 gboolean __ofono_emulator_remove_status_watch(struct ofono_emulator *e,
 						unsigned int id);
+
+void ofono_emulator_send_final(struct ofono_emulator *e,
+					enum _GAtServerResult result);
+void ofono_emulator_send_ext_final(struct ofono_emulator *e,
+					const char *result);
+void ofono_emulator_send_intermediate(struct ofono_emulator *e,
+					const char *result);
+void ofono_emulator_send_unsolicited(struct ofono_emulator *e,
+					const char *result);
+void ofono_emulator_send_info(struct ofono_emulator *e, const char *line,
+					gboolean last);
-- =

1.7.0.4


--===============1705223865333901386==--

