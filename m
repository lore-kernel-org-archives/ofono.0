Content-Type: multipart/mixed; boundary="===============5715729367105072701=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH -v5 2/2] sap: clean up sap modem destruction
Date: Wed, 28 Sep 2011 14:13:58 -0300
Message-ID: <1317230038-28124-2-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1317230038-28124-1-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5715729367105072701==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

---
 plugins/sap.c |   22 ++++++++++------------
 1 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/plugins/sap.c b/plugins/sap.c
index 4579d8f..1c0d9ce 100644
--- a/plugins/sap.c
+++ b/plugins/sap.c
@@ -70,16 +70,6 @@ int bluetooth_sap_client_register(struct bluetooth_sap_d=
river *sap,
 	return 0;
 }
 =

-static void sap_remove_modem(struct ofono_modem *modem)
-{
-	struct sap_data *data =3D ofono_modem_get_data(modem);
-
-	g_free(data);
-
-	ofono_modem_set_data(modem, NULL);
-
-	ofono_modem_remove(modem);
-}
 =

 void bluetooth_sap_client_unregister(struct ofono_modem *modem)
 {
@@ -93,7 +83,8 @@ void bluetooth_sap_client_unregister(struct ofono_modem *=
modem)
 =

 	while (g_hash_table_iter_next(&iter, &key, &value)) {
 		g_hash_table_iter_remove(&iter);
-		sap_remove_modem(value);
+
+		ofono_modem_remove(value);
 	}
 =

 	sap_hw_modem =3D NULL;
@@ -117,7 +108,13 @@ static int sap_probe(struct ofono_modem *modem)
 =

 static void sap_remove(struct ofono_modem *modem)
 {
+	struct sap_data *data =3D ofono_modem_get_data(modem);
+
 	DBG("%p", modem);
+
+	g_free(data);
+
+	ofono_modem_set_data(modem, NULL);
 }
 =

 static void sap_connect_reply(DBusPendingCall *call, gpointer user_data)
@@ -235,7 +232,8 @@ static void bluetooth_sap_remove(const char *prefix)
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


--===============5715729367105072701==--

