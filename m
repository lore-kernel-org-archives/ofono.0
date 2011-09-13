Content-Type: multipart/mixed; boundary="===============5123749344218041039=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH -v2 05/24] telit: add #RSEN notify
Date: Tue, 13 Sep 2011 15:58:13 -0300
Message-ID: <1315940312-1238-5-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1315940312-1238-4-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5123749344218041039==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

RSEN URC tells if the SAP Client was enabled or not
---
 plugins/telit.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/plugins/telit.c b/plugins/telit.c
index cc10668..1f950aa 100644
--- a/plugins/telit.c
+++ b/plugins/telit.c
@@ -105,6 +105,22 @@ static GAtChat *open_device(struct ofono_modem *modem,
 	return chat;
 }
 =

+static void telit_rsen_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	int status;
+	GAtResultIter iter;
+
+	DBG("%p", modem);
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "#RSEN:"))
+		return;
+
+	g_at_result_iter_next_number(&iter, &status);
+}
+
 static void rsen_enable_cb(gboolean ok, GAtResult *result, gpointer user_d=
ata)
 {
 	struct ofono_modem *modem =3D user_data;
@@ -131,6 +147,9 @@ static int telit_sap_enable(struct ofono_modem *modem)
 	if (data->chat =3D=3D NULL)
 		return -EINVAL;
 =

+	g_at_chat_register(data->chat, "#RSEN:", telit_rsen_notify,
+				FALSE, modem, NULL);
+
 	g_at_chat_send(data->chat, "AT#NOPT=3D3", NULL, NULL, NULL, NULL);
 =

 	/* Set SAP functionality */
-- =

1.7.6.2


--===============5123749344218041039==--

