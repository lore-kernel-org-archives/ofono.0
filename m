Content-Type: multipart/mixed; boundary="===============4987158797712901970=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH 2/3] qmimodem: release DMS service on radio-settings atom
 removal
Date: Wed, 07 Mar 2018 15:55:10 +0100
Message-ID: <20180307145511.21142-3-jonas@southpole.se>
In-Reply-To: <20180307145511.21142-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4987158797712901970==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/qmimodem/radio-settings.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/qmimodem/radio-settings.c b/drivers/qmimodem/radio-set=
tings.c
index aa8e0d5c..36ad25cf 100644
--- a/drivers/qmimodem/radio-settings.c
+++ b/drivers/qmimodem/radio-settings.c
@@ -277,6 +277,9 @@ static void qmi_radio_settings_remove(struct ofono_radi=
o_settings *rs)
 =

 	ofono_radio_settings_set_data(rs, NULL);
 =

+	qmi_service_unregister_all(data->dms);
+	qmi_service_unref(data->dms);
+
 	qmi_service_unregister_all(data->nas);
 =

 	qmi_service_unref(data->nas);
-- =

2.14.1


--===============4987158797712901970==--

