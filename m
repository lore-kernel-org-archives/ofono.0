Content-Type: multipart/mixed; boundary="===============3149435096049625656=="
MIME-Version: 1.0
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
Subject: [PATCH] hfp_hf: Fix modifying hash table while iterating
Date: Wed, 18 Apr 2012 17:19:36 +0200
Message-ID: <1334762376-24124-1-git-send-email-mikel.astiz.oss@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3149435096049625656==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Calling ofono_remove_modem() while iterating the hash table is not safe
given that it can modify the table in hfp_remove().

A simple way to reproduce the problem is to pair some Bluetooth phones
and remove the Bluetooth adapter, triggering a GLib-CRITICAL assertion.

This approach proposes a two-step removal: first, the hash table is
iterated and all modems to be removed are marked as pending (thus
removed from the hash table and put in a temporary list), and afterwards
all pending modems are actually removed.
---
 plugins/hfp_hf.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/plugins/hfp_hf.c b/plugins/hfp_hf.c
index 48a734a..0028e21 100644
--- a/plugins/hfp_hf.c
+++ b/plugins/hfp_hf.c
@@ -60,6 +60,7 @@
 =

 static DBusConnection *connection;
 static GHashTable *modem_hash =3D NULL;
+static GSList *pending_removals =3D NULL;
 =

 struct hfp_data {
 	struct hfp_slc_info info;
@@ -265,11 +266,16 @@ static gboolean hfp_remove_modem(gpointer key, gpoint=
er value,
 	if (prefix && g_str_has_prefix(device, prefix) =3D=3D FALSE)
 		return FALSE;
 =

-	ofono_modem_remove(modem);
+	pending_removals =3D g_slist_append(pending_removals, modem);
 =

 	return TRUE;
 }
 =

+static void hfp_remove_pending_modem(gpointer data)
+{
+	ofono_modem_remove(data);
+}
+
 static void hfp_hf_remove(const char *prefix)
 {
 	DBG("%s", prefix);
@@ -279,6 +285,9 @@ static void hfp_hf_remove(const char *prefix)
 =

 	g_hash_table_foreach_remove(modem_hash, hfp_remove_modem,
 							(gpointer) prefix);
+
+	g_slist_free_full(pending_removals, hfp_remove_pending_modem);
+	pending_removals =3D NULL;
 }
 =

 static void hfp_hf_set_alias(const char *device, const char *alias)
-- =

1.7.7.6


--===============3149435096049625656==--

