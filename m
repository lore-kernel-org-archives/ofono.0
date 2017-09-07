Content-Type: multipart/mixed; boundary="===============5949874469954719693=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH 3/5] qmi: provide AvailableTechnologies in radio-settings
Date: Thu, 07 Sep 2017 14:11:34 +0200
Message-ID: <20170907121136.13520-3-jonas@southpole.se>
In-Reply-To: <20170907121136.13520-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5949874469954719693==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This provides the list of available technologies in the radio-settings
atom.  Note that this list is hard-coded and includes LTE unconditionally
which is probably not correct for all QMI devices.
---
 drivers/qmimodem/radio-settings.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/qmimodem/radio-settings.c b/drivers/qmimodem/radio-set=
tings.c
index ed578f8..fecde82 100644
--- a/drivers/qmimodem/radio-settings.c
+++ b/drivers/qmimodem/radio-settings.c
@@ -155,6 +155,19 @@ static void qmi_set_rat_mode(struct ofono_radio_settin=
gs *rs,
 }
 =

 =

+static void qmi_query_available_rats(struct ofono_radio_settings *rs,
+			ofono_radio_settings_available_rats_query_cb_t cb,
+			void *data)
+{
+	unsigned int available_rats;
+
+	available_rats =3D OFONO_RADIO_ACCESS_MODE_GSM
+				| OFONO_RADIO_ACCESS_MODE_UMTS
+				| OFONO_RADIO_ACCESS_MODE_LTE;
+
+	CALLBACK_WITH_SUCCESS(cb, available_rats, data);
+}
+
 static void create_nas_cb(struct qmi_service *service, void *user_data)
 {
 	struct ofono_radio_settings *rs =3D user_data;
@@ -219,6 +232,7 @@ static struct ofono_radio_settings_driver driver =3D {
 	.remove		=3D qmi_radio_settings_remove,
 	.set_rat_mode	=3D qmi_set_rat_mode,
 	.query_rat_mode =3D qmi_query_rat_mode,
+	.query_available_rats =3D qmi_query_available_rats,
 };
 =

 void qmi_radio_settings_init(void)
-- =

2.9.3


--===============5949874469954719693==--

