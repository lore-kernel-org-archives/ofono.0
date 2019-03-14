Content-Type: multipart/mixed; boundary="===============4278201964564128154=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: [PATCH 1/5] ublox: gprs-context: take model parameter
Date: Thu, 14 Mar 2019 23:28:39 +0100
Message-ID: <20190314222843.9232-1-jonas@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4278201964564128154==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/ubloxmodem/gprs-context.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/ubloxmodem/gprs-context.c b/drivers/ubloxmodem/gprs-co=
ntext.c
index 1b4e17f5..bbf8627a 100644
--- a/drivers/ubloxmodem/gprs-context.c
+++ b/drivers/ubloxmodem/gprs-context.c
@@ -45,6 +45,7 @@ static const char *cgcontrdp_prefix[] =3D { "+CGCONTRDP:"=
, NULL };
 static const char *uipaddr_prefix[] =3D { "+UIPADDR:", NULL };
 =

 struct gprs_context_data {
+	const struct ublox_model *model;
 	GAtChat *chat;
 	unsigned int active_context;
 	ofono_gprs_context_cb_t cb;
@@ -462,7 +463,7 @@ static void cgev_notify(GAtResult *result, gpointer use=
r_data)
 }
 =

 static int ublox_gprs_context_probe(struct ofono_gprs_context *gc,
-					unsigned int vendor, void *data)
+					unsigned int model_id, void *data)
 {
 	GAtChat *chat =3D data;
 	struct gprs_context_data *gcd;
@@ -473,6 +474,10 @@ static int ublox_gprs_context_probe(struct ofono_gprs_=
context *gc,
 	if (gcd =3D=3D NULL)
 		return -ENOMEM;
 =

+	gcd->model =3D ublox_model_from_id(model_id);
+	if (!gcd->model)
+		return -EINVAL;
+
 	gcd->chat =3D g_at_chat_clone(chat);
 =

 	ofono_gprs_context_set_data(gc, gcd);
-- =

2.19.1


--===============4278201964564128154==--

