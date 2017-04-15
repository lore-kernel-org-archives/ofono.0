Content-Type: multipart/mixed; boundary="===============1064558203451148812=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH qmi lte v3 1/6] qmi: free cb_data on error
Date: Sat, 15 Apr 2017 17:34:41 +0200
Message-ID: <20170415153446.31803-3-jonas@southpole.se>
In-Reply-To: <20170415153446.31803-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1064558203451148812==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

...and move allocation of structure up to variable declarations to
match the pattern used elsewhere in the code.
---
 drivers/qmimodem/gprs-context.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/qmimodem/gprs-context.c b/drivers/qmimodem/gprs-contex=
t.c
index c9caf64..3743bb2 100644
--- a/drivers/qmimodem/gprs-context.c
+++ b/drivers/qmimodem/gprs-context.c
@@ -207,13 +207,12 @@ static void qmi_gprs_read_settings(struct ofono_gprs_=
context* gc,
 					void *user_data)
 {
 	struct gprs_context_data *data =3D ofono_gprs_context_get_data(gc);
-	struct cb_data *cbd;
+	struct cb_data *cbd =3D cb_data_new(cb, user_data);
 =

 	DBG("cid %u", cid);
 =

 	data->active_context =3D cid;
 =

-	cbd  =3D cb_data_new(cb, user_data);
 	cbd->user =3D gc;
 =

 	if (qmi_service_send(data->wds, QMI_WDS_START_NET, NULL,
@@ -223,6 +222,8 @@ static void qmi_gprs_read_settings(struct ofono_gprs_co=
ntext* gc,
 	data->active_context =3D 0;
 =

 	CALLBACK_WITH_FAILURE(cb, cbd->data);
+
+	g_free(cbd);
 }
 =

 static void qmi_activate_primary(struct ofono_gprs_context *gc,
-- =

2.9.3


--===============1064558203451148812==--

