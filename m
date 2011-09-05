Content-Type: multipart/mixed; boundary="===============3559643079629586783=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH 10/20] sap: add support to the disable the SAP client
Date: Mon, 05 Sep 2011 15:03:39 -0300
Message-ID: <1315245829-6887-11-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1315245829-6887-10-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3559643079629586783==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

---
 plugins/sap.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/plugins/sap.c b/plugins/sap.c
index 678addc..308d28f 100644
--- a/plugins/sap.c
+++ b/plugins/sap.c
@@ -316,6 +316,7 @@ done:
 static int sap_disable(struct ofono_modem *modem)
 {
 	struct sap_data *data =3D ofono_modem_get_data(modem);
+	struct bluetooth_sap_driver *sap_driver;
 	int status;
 	char str[] =3D "sap";
 	char *s =3D str;
@@ -328,6 +329,12 @@ static int sap_disable(struct ofono_modem *modem)
 				DBUS_TIMEOUT, DBUS_TYPE_STRING,
 				&s, DBUS_TYPE_INVALID);
 =

+	sap_driver =3D g_hash_table_lookup(sap_hw_hash, data->hw_modem);
+	if (!sap_driver)
+		return -EINVAL;
+
+	sap_driver->disable(data->hw_modem);
+
 	if (status < 0)
 		return -EINVAL;
 =

-- =

1.7.6.1


--===============3559643079629586783==--

