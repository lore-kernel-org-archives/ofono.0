Content-Type: multipart/mixed; boundary="===============2424538039721010456=="
MIME-Version: 1.0
From: Djalal Harouni <djalal@endocode.com>
Subject: [PATCH v3 5/7] ubloxmodem: register and initialize the netmon driver
Date: Wed, 30 Nov 2016 13:31:43 +0100
Message-ID: <1480509105-17934-6-git-send-email-djalal@endocode.com>
In-Reply-To: <1480509105-17934-1-git-send-email-djalal@endocode.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2424538039721010456==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/ublox.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/plugins/ublox.c b/plugins/ublox.c
index 6d77df8..2ced577 100644
--- a/plugins/ublox.c
+++ b/plugins/ublox.c
@@ -38,6 +38,7 @@
 #include <ofono/sim.h>
 #include <ofono/gprs.h>
 #include <ofono/gprs-context.h>
+#include <ofono/netmon.h>
 #include <ofono/lte.h>
 =

 #include <drivers/atmodem/atutil.h>
@@ -323,6 +324,8 @@ static void ublox_post_online(struct ofono_modem *modem)
 	struct ublox_data *data =3D ofono_modem_get_data(modem);
 =

 	ofono_netreg_create(modem, data->vendor_family, "atmodem", data->aux);
+
+	ofono_netmon_create(modem, data->vendor_family, "ubloxmodem", data->aux);
 }
 =

 static struct ofono_modem_driver ublox_driver =3D {
-- =

2.5.5


--===============2424538039721010456==--

