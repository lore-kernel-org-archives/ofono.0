Content-Type: multipart/mixed; boundary="===============1772467209016334482=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH -v4 20/21] sap: clean up sap modem destruction
Date: Tue, 27 Sep 2011 18:04:19 -0300
Message-ID: <1317157460-17012-20-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1317157460-17012-19-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1772467209016334482==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: "Gustavo F. Padovan" <gustavo@padovan.org>

---
 plugins/sap.c |   33 +++++++++++++++------------------
 1 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/plugins/sap.c b/plugins/sap.c
index ce5886d..b128517 100644
--- a/plugins/sap.c
+++ b/plugins/sap.c
@@ -100,22 +100,6 @@ static void sap_close_io(struct ofono_modem *modem)
 		g_source_remove(data->hw_watch);
 }
 =

-static void sap_remove_modem(struct ofono_modem *modem)
-{
-	struct sap_data *data =3D ofono_modem_get_data(modem);
-
-	sap_close_io(modem);
-
-	if (data->call !=3D NULL)
-		dbus_pending_call_cancel(data->call);
-
-	g_free(data);
-
-	ofono_modem_set_data(modem, NULL);
-
-	ofono_modem_remove(modem);
-}
-
 void bluetooth_sap_client_unregister(struct ofono_modem *modem)
 {
 	GHashTableIter iter;
@@ -128,7 +112,8 @@ void bluetooth_sap_client_unregister(struct ofono_modem=
 *modem)
 =

 	while (g_hash_table_iter_next(&iter, &key, &value)) {
 		g_hash_table_iter_remove(&iter);
-		sap_remove_modem(value);
+
+		ofono_modem_remove(modem);
 	}
 =

 	sap_hw_modem =3D NULL;
@@ -226,7 +211,18 @@ static int sap_probe(struct ofono_modem *modem)
 =

 static void sap_remove(struct ofono_modem *modem)
 {
+	struct sap_data *data =3D ofono_modem_get_data(modem);
+
 	DBG("%p", modem);
+
+	sap_close_io(modem);
+
+	if (data->call !=3D NULL)
+		dbus_pending_call_cancel(data->call);
+
+	g_free(data);
+
+	ofono_modem_set_data(modem, NULL);
 }
 =

 static void sap_failed_cb(struct ofono_modem *modem)
@@ -433,7 +429,8 @@ static void bluetooth_sap_remove(const char *prefix)
 			continue;
 =

 		g_hash_table_iter_remove(&iter);
-		sap_remove_modem(value);
+
+		ofono_modem_remove(value);
 	}
 }
 =

-- =

1.7.6.2


--===============1772467209016334482==--

