Content-Type: multipart/mixed; boundary="===============5778707154040082757=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH 2/3] hfp: Don't call UnregisterAgent if a Release was received
Date: Fri, 05 Feb 2010 18:47:05 +0000
Message-ID: <1326571257-7566-2-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1326571257-7566-1-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5778707154040082757==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Prevent to call UnregisterAgent on an already unregistered agent.
---
 plugins/hfp.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/plugins/hfp.c b/plugins/hfp.c
index 3e41342..46217c5 100644
--- a/plugins/hfp.c
+++ b/plugins/hfp.c
@@ -411,6 +411,9 @@ static DBusMessage *hfp_agent_release(DBusConnection *c=
onn,
 					DBusMessage *msg, void *data)
 {
 	struct ofono_modem *modem =3D data;
+	const char *obj_path =3D ofono_modem_get_path(modem);
+
+	g_dbus_unregister_interface(connection, obj_path, HFP_AGENT_INTERFACE);
 =

 	ofono_modem_remove(modem);
 =

@@ -757,8 +760,11 @@ static int hfp_probe(struct ofono_modem *modem)
 static void hfp_remove(struct ofono_modem *modem)
 {
 	struct hfp_data *data =3D ofono_modem_get_data(modem);
+	const char *obj_path =3D ofono_modem_get_path(modem);
 =

-	hfp_unregister_ofono_handsfree(modem);
+	if (g_dbus_unregister_interface(connection, obj_path,
+					HFP_AGENT_INTERFACE))
+		hfp_unregister_ofono_handsfree(modem);
 =

 	g_hash_table_remove(uuid_hash, data->handsfree_path);
 =

-- =

1.6.4.4


--===============5778707154040082757==--

