Content-Type: multipart/mixed; boundary="===============2747636961178276929=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH qmi lte v5 2/4] qmi: use shared services
Date: Sat, 29 Apr 2017 14:46:41 +0200
Message-ID: <20170429124643.21080-3-jonas@southpole.se>
In-Reply-To: <20170429124643.21080-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2747636961178276929==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Apparently it's not legal to create a QMI service multiple times for
a device.  I've been testing with a Quectel EC21 and here it works fine
to do so, but the general case would require "shared" services across
atoms.

This patch switches the users of the NAS and WDS services over to using
a "shared" service instead of each instatiating their own instance.
---
 drivers/qmimodem/gprs-context.c         | 4 ++--
 drivers/qmimodem/gprs.c                 | 2 +-
 drivers/qmimodem/network-registration.c | 2 +-
 drivers/qmimodem/radio-settings.c       | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/qmimodem/gprs-context.c b/drivers/qmimodem/gprs-contex=
t.c
index 80cba76..0c34be6 100644
--- a/drivers/qmimodem/gprs-context.c
+++ b/drivers/qmimodem/gprs-context.c
@@ -421,7 +421,7 @@ static void get_data_format_cb(struct qmi_result *resul=
t, void *user_data)
 	}
 =

 done:
-	qmi_service_create(data->dev, QMI_SERVICE_WDS, create_wds_cb, gc,
+	qmi_service_create_shared(data->dev, QMI_SERVICE_WDS, create_wds_cb, gc,
 									NULL);
 }
 =

@@ -444,7 +444,7 @@ static void create_wda_cb(struct qmi_service *service, =
void *user_data)
 		return;
 =

 error:
-	qmi_service_create(data->dev, QMI_SERVICE_WDS, create_wds_cb, gc,
+	qmi_service_create_shared(data->dev, QMI_SERVICE_WDS, create_wds_cb, gc,
 									NULL);
 }
 =

diff --git a/drivers/qmimodem/gprs.c b/drivers/qmimodem/gprs.c
index 05ad4bd..fb5e6ec 100644
--- a/drivers/qmimodem/gprs.c
+++ b/drivers/qmimodem/gprs.c
@@ -201,7 +201,7 @@ static int qmi_gprs_probe(struct ofono_gprs *gprs,
 =

 	ofono_gprs_set_data(gprs, data);
 =

-	qmi_service_create(device, QMI_SERVICE_NAS, create_nas_cb, gprs, NULL);
+	qmi_service_create_shared(device, QMI_SERVICE_NAS, create_nas_cb, gprs, N=
ULL);
 =

 	return 0;
 }
diff --git a/drivers/qmimodem/network-registration.c b/drivers/qmimodem/net=
work-registration.c
index e2a5082..52ad69a 100644
--- a/drivers/qmimodem/network-registration.c
+++ b/drivers/qmimodem/network-registration.c
@@ -542,7 +542,7 @@ static int qmi_netreg_probe(struct ofono_netreg *netreg,
 =

 	ofono_netreg_set_data(netreg, data);
 =

-	qmi_service_create(device, QMI_SERVICE_NAS,
+	qmi_service_create_shared(device, QMI_SERVICE_NAS,
 					create_nas_cb, netreg, NULL);
 =

 	return 0;
diff --git a/drivers/qmimodem/radio-settings.c b/drivers/qmimodem/radio-set=
tings.c
index d62a636..fb587b9 100644
--- a/drivers/qmimodem/radio-settings.c
+++ b/drivers/qmimodem/radio-settings.c
@@ -74,7 +74,7 @@ static int qmi_radio_settings_probe(struct ofono_radio_se=
ttings *rs,
 =

 	ofono_radio_settings_set_data(rs, data);
 =

-	qmi_service_create(device, QMI_SERVICE_NAS, create_nas_cb, rs, NULL);
+	qmi_service_create_shared(device, QMI_SERVICE_NAS, create_nas_cb, rs, NUL=
L);
 =

 	return 0;
 =

-- =

2.9.3


--===============2747636961178276929==--

