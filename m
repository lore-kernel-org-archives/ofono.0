Content-Type: multipart/mixed; boundary="===============0513886472389403292=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH 1/3] qmimodem: release WDS service on GPRS atom removal
Date: Wed, 07 Mar 2018 15:55:09 +0100
Message-ID: <20180307145511.21142-2-jonas@southpole.se>
In-Reply-To: <20180307145511.21142-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0513886472389403292==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/qmimodem/gprs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/qmimodem/gprs.c b/drivers/qmimodem/gprs.c
index b379b026..db07f310 100644
--- a/drivers/qmimodem/gprs.c
+++ b/drivers/qmimodem/gprs.c
@@ -398,6 +398,9 @@ static void qmi_gprs_remove(struct ofono_gprs *gprs)
 =

 	ofono_gprs_set_data(gprs, NULL);
 =

+	qmi_service_unregister_all(data->wds);
+	qmi_service_unref(data->wds);
+
 	qmi_service_unregister_all(data->nas);
 =

 	qmi_service_unref(data->nas);
-- =

2.14.1


--===============0513886472389403292==--

