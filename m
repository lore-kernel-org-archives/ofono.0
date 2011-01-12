Content-Type: multipart/mixed; boundary="===============7167838434044543937=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Dalleau <frederic.dalleau@intel.com>
Subject: [PATCH 09/21] emulator: Add APIs to send GAtServer result
Date: Wed, 12 Jan 2011 18:15:52 +0100
Message-ID: <1294852564-1258-10-git-send-email-frederic.dalleau@intel.com>
In-Reply-To: <1294852564-1258-1-git-send-email-frederic.dalleau@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7167838434044543937==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Zhenhua Zhang <zhenhua.zhang@intel.com>

Defines APIs to send final/intermediate/unsolicited result to DUN
client.
 Please enter the commit message for your changes. Lines starting
---
 include/emulator.h |    2 ++
 src/emulator.c     |   28 ++++++++++++++++++++++++++++
 src/ofono.h        |   15 +++++++++++++++
 3 files changed, 45 insertions(+), 0 deletions(-)

diff --git a/include/emulator.h b/include/emulator.h
index 99ae218..0d5568c 100644
--- a/include/emulator.h
+++ b/include/emulator.h
@@ -36,6 +36,8 @@ enum ofono_emulator_status {
 	OFONO_EMULATOR_STATUS_DESTROY,
 };
 =

+enum _GAtServerResult;
+
 struct ofono_emulator_driver {
 	const char *name;
 	enum ofono_atom_type type;
diff --git a/src/emulator.c b/src/emulator.c
index c68dbf8..455af11 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -82,6 +82,34 @@ static void ofono_emulator_release_id(int id)
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
index 247152b..4c11e1f 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -434,3 +434,18 @@ unsigned int __ofono_emulator_add_status_watch(struct =
ofono_emulator *e,
 =

 gboolean __ofono_emulator_remove_status_watch(struct ofono_emulator *e,
 						unsigned int id);
+
+void ofono_emulator_send_final(struct ofono_emulator *e,
+					enum _GAtServerResult result);
+
+void ofono_emulator_send_ext_final(struct ofono_emulator *e,
+					const char *result);
+
+void ofono_emulator_send_intermediate(struct ofono_emulator *e,
+					const char *result);
+
+void ofono_emulator_send_unsolicited(struct ofono_emulator *e,
+					const char *result);
+
+void ofono_emulator_send_info(struct ofono_emulator *e, const char *line,
+					gboolean last);
-- =

1.7.1

---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

--===============7167838434044543937==--

