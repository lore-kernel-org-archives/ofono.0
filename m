Content-Type: multipart/mixed; boundary="===============2567586480843615647=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 08/15] emulator: Add APIs to send GAtServer result
Date: Wed, 07 Jul 2010 18:01:45 +0800
Message-ID: <1278496912-13777-9-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1278496912-13777-8-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2567586480843615647==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Defines APIs to send final/intermediate/unsolicited result to DUN
client.
---
 include/emulator.h |    2 ++
 src/emulator.c     |   28 ++++++++++++++++++++++++++++
 src/ofono.h        |   10 ++++++++++
 3 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/include/emulator.h b/include/emulator.h
index c76dbc7..8b10f8c 100644
--- a/include/emulator.h
+++ b/include/emulator.h
@@ -50,6 +50,8 @@ struct ofono_emulator_driver {
 	int (*disable)(struct ofono_emulator *e);
 };
 =

+enum _GAtServerResult;
+
 const char *ofono_emulator_get_path(struct ofono_emulator *e);
 =

 struct ofono_emulator *ofono_emulator_find(struct ofono_modem *modem,
diff --git a/src/emulator.c b/src/emulator.c
index 86a2eee..aa203f1 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -401,6 +401,34 @@ static gboolean ofono_emulator_dbus_register(struct of=
ono_modem *modem,
 	return TRUE;
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
 unsigned int __ofono_emulator_add_status_watch(struct ofono_emulator *e,
 				ofono_emulator_status_notify_cb_t notify,
 				void *data, ofono_destroy_func destroy)
diff --git a/src/ofono.h b/src/ofono.h
index dc560df..2a63386 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -296,3 +296,13 @@ unsigned int __ofono_emulator_add_status_watch(struct =
ofono_emulator *e,
 gboolean __ofono_emulator_remove_status_watch(struct ofono_emulator *e,
 						unsigned int id);
 =

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

1.6.3.3


--===============2567586480843615647==--

