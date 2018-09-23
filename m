Content-Type: multipart/mixed; boundary="===============3756855949763099356=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: [PATCH] location-reporting.h: driver properties handling
Date: Sun, 23 Sep 2018 08:19:20 +0200
Message-ID: <20180923061922.23288-1-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3756855949763099356==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The GNSS receiver configuration is highly proprietary.
Some are configured through the GNSS port itself, some through other
ports. The properties themselves vary among the manufacturers, with no
standard available. Besides, ofono doesn't handle any state for a GNSS
receiver.

Therefore, this extensions allows to get and set directly D-Bus
properties by the driver.
---
 include/location-reporting.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/location-reporting.h b/include/location-reporting.h
index 0717f710..d3f013d2 100644
--- a/include/location-reporting.h
+++ b/include/location-reporting.h
@@ -52,6 +52,9 @@ struct ofono_location_reporting_driver {
 			ofono_location_reporting_enable_cb_t cb, void *data);
 	void (*disable)(struct ofono_location_reporting *lr,
 			ofono_location_reporting_disable_cb_t cb, void *data);
+	void (*get_properties)(struct ofono_location_reporting *lr,
+								void *_dict);
+	void* (*set_property)(struct ofono_location_reporting *lr, void *_msg);
 };
 =

 int ofono_location_reporting_driver_register(
-- =

2.17.1


--===============3756855949763099356==--

