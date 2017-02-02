Content-Type: multipart/mixed; boundary="===============5682186480792963991=="
MIME-Version: 1.0
From: Piotr Haber <gluedig@gmail.com>
Subject: [PATCH] telit: add support for UE866
Date: Thu, 02 Feb 2017 15:10:56 +0100
Message-ID: <20170202141056.8282-1-gluedig@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5682186480792963991==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/telit.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/plugins/telit.c b/plugins/telit.c
index 742e06c0..4ba8e483 100644
--- a/plugins/telit.c
+++ b/plugins/telit.c
@@ -67,6 +67,7 @@ enum modem_model {
 	UE910,
 	LE910,
 	UC864,
+	UE866,
 };
 =

 static struct {
@@ -90,6 +91,7 @@ static struct {
 	{ UC864,	NULL,	TRUE,	FALSE },
 	{ UC864,	"G",	TRUE,	TRUE },
 	{ UC864,	"WD",	FALSE,	FALSE },
+	{ UE866,	NULL,	FALSE,	FALSE },
 	{ }
 };
 =

@@ -307,6 +309,8 @@ static gboolean find_model_variant(struct ofono_modem *=
modem,
 		data->model =3D LE910;
 	else if (g_str_equal(model, "UC864"))
 		data->model =3D UC864;
+	else if (g_str_equal(model, "UE866"))
+		data->model =3D UE866;
 	else
 		return FALSE;
 =

-- =

2.11.0


--===============5682186480792963991==--

