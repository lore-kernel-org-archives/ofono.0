Content-Type: multipart/mixed; boundary="===============6207461352395210049=="
MIME-Version: 1.0
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
Subject: [PATCH v2] hfp_hf: Fix modifying hash table while iterating
Date: Thu, 19 Apr 2012 08:58:58 +0200
Message-ID: <1334818738-14217-1-git-send-email-mikel.astiz.oss@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6207461352395210049==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Calling ofono_remove_modem() while iterating the hash table is not safe
given that it can modify the table in hfp_remove().

A simple way to reproduce the problem is to pair some Bluetooth phones
and remove the Bluetooth adapter, triggering a GLib-CRITICAL assertion.

This patch just removes the update of the hash table inside
hfp_remove(). This can be safe as long as all calls to
ofono_modem_remove() are accompanied by a hash table update. The only
example of this kind right now is hfp_agent_release().
---
 plugins/hfp_hf.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/plugins/hfp_hf.c b/plugins/hfp_hf.c
index 48a734a..c11525e 100644
--- a/plugins/hfp_hf.c
+++ b/plugins/hfp_hf.c
@@ -192,6 +192,7 @@ static DBusMessage *hfp_agent_release(DBusConnection *c=
onn,
 	g_dbus_unregister_interface(connection, obj_path, HFP_AGENT_INTERFACE);
 	hfp_data->agent_registered =3D FALSE;
 =

+	g_hash_table_remove(modem_hash, hfp_data->handsfree_path);
 	ofono_modem_remove(modem);
 =

 	return dbus_message_new_method_return(msg);
@@ -366,8 +367,6 @@ static void hfp_remove(struct ofono_modem *modem)
 					HFP_AGENT_INTERFACE))
 		hfp_unregister_ofono_handsfree(modem);
 =

-	g_hash_table_remove(modem_hash, data->handsfree_path);
-
 	g_free(data->handsfree_address);
 	g_free(data->handsfree_path);
 	g_free(data);
-- =

1.7.7.6


--===============6207461352395210049==--

