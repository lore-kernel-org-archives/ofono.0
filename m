Content-Type: multipart/mixed; boundary="===============7998882113731373344=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [RFC v1 08/15] hfp_hf: Fix updating alias
Date: Mon, 26 Nov 2012 10:27:02 -0300
Message-ID: <1353936429-9997-9-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1353936429-9997-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7998882113731373344==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch fixes the Bluetooth device alias for the HFP when the modem
is not registered yet. Modem is being created with the first alias
informed when in the Bluetooth profile probe callback.
---
 plugins/hfp_hf.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/plugins/hfp_hf.c b/plugins/hfp_hf.c
index b3ea13f..326f5d9 100644
--- a/plugins/hfp_hf.c
+++ b/plugins/hfp_hf.c
@@ -271,15 +271,20 @@ static void hfp_hf_remove(const char *prefix)
 static void hfp_hf_set_alias(const char *device, const char *alias)
 {
 	struct ofono_modem *modem;
+	struct hfp_data *hfp_data;
 =

 	if (device =3D=3D NULL || alias =3D=3D NULL)
 		return;
 =

-	modem =3D	g_hash_table_lookup(modem_hash, device);
-	if (modem =3D=3D NULL)
-		return;
+	hfp_data =3D g_hash_table_lookup(hfp_hash, device);
+	if (hfp_data) {
+		g_free(hfp_data->device_alias);
+		hfp_data->device_alias =3D g_strdup(alias);
+	}
 =

-	ofono_modem_set_name(modem, alias);
+	modem =3D	g_hash_table_lookup(modem_hash, device);
+	if (modem)
+		ofono_modem_set_name(modem, alias);
 }
 =

 static DBusMessage *profile_new_connection(DBusConnection *conn,
-- =

1.7.11.7


--===============7998882113731373344==--

