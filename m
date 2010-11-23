Content-Type: multipart/mixed; boundary="===============6504677800376622040=="
MIME-Version: 1.0
From: jun.wei@intel.com
Subject: [RFC 3/3] plugin/ifx: Enable support of Neighbor Cell Info
Date: Tue, 23 Nov 2010 13:12:32 +0800
Message-ID: <1290489152-11940-1-git-send-email-jun.wei@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6504677800376622040==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Jun Wei <jun.wei@intel.com>

---
 plugins/ifx.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/plugins/ifx.c b/plugins/ifx.c
index 037273a..e61008c 100644
--- a/plugins/ifx.c
+++ b/plugins/ifx.c
@@ -58,6 +58,7 @@
 #include <ofono/audio-settings.h>
 #include <ofono/stk.h>
 #include <ofono/log.h>
+#include <ofono/cell-info.h>
 =

 #include <drivers/atmodem/atutil.h>
 #include <drivers/atmodem/vendor.h>
@@ -729,6 +730,7 @@ static void ifx_post_online(struct ofono_modem *modem)
 	ofono_call_meter_create(modem, 0, "atmodem", data->dlcs[AUX_DLC]);
 	ofono_call_barring_create(modem, 0, "atmodem", data->dlcs[AUX_DLC]);
 	ofono_call_volume_create(modem, 0, "atmodem", data->dlcs[AUX_DLC]);
+	ofono_cell_info_create(modem, 0, "ifxmodem", data->dlcs[AUX_DLC]);
 =

 	mw =3D ofono_message_waiting_create(modem);
 	if (mw)
-- =

1.7.2.3


--===============6504677800376622040==--

