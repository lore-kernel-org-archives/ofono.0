Content-Type: multipart/mixed; boundary="===============9154141294188697014=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH QMI LTE v2 01/13] qmi: duplicate callback data correctly
Date: Fri, 14 Apr 2017 23:36:34 +0200
Message-ID: <20170414213646.32066-2-jonas@southpole.se>
In-Reply-To: <20170414213646.32066-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9154141294188697014==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/qmimodem/gprs-context.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/qmimodem/gprs-context.c b/drivers/qmimodem/gprs-contex=
t.c
index a1ee217..247ee9e 100644
--- a/drivers/qmimodem/gprs-context.c
+++ b/drivers/qmimodem/gprs-context.c
@@ -198,7 +198,7 @@ static void start_net_cb(struct qmi_result *result, voi=
d *user_data)
 	data->pkt_handle =3D handle;
 =

 	/* Duplicate cbd, the old one will be freed when this method returns */
-	cbd =3D cb_data_new(cb, user_data);
+	cbd =3D cb_data_new(cb, cbd->data);
 	cbd->user =3D gc;
 =

 	if (qmi_service_send(data->wds, QMI_WDS_GET_SETTINGS, NULL,
-- =

2.9.3


--===============9154141294188697014==--

