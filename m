Content-Type: multipart/mixed; boundary="===============1613206675981693403=="
MIME-Version: 1.0
From: Wei, Jun <jun.wei@intel.com>
Subject: [PATCH v2 3/4] plugin/ifx: Enable support of Neighbor cell info
Date: Sun, 09 Jan 2011 22:06:05 +0800
Message-ID: <1A42CE6F5F474C41B63392A5F80372B231DCEE45@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <1294490460-26600-1-git-send-email-jun.wei@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1613206675981693403==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Wei, Jun =

Sent: Saturday, January 08, 2011 8:41 PM
To: ofono(a)ofono.org
Cc: Wei, Jun
Subject: [PATCH v2 3/4] plugin/ifx: Enable support of Neighbor cell info

From: Jun Wei <jun.wei@intel.com>

---
 plugins/ifx.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/plugins/ifx.c b/plugins/ifx.c
index c0a69c2..b121015 100644
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


--===============1613206675981693403==--

