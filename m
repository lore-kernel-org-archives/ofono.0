Content-Type: multipart/mixed; boundary="===============6539005141795923637=="
MIME-Version: 1.0
From: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH v3 14/15] hfp_hf: BT address exposed through Serial property
Date: Thu, 20 Oct 2011 18:38:19 +0200
Message-ID: <1319128700-15841-15-git-send-email-mikel.astiz@bmw-carit.de>
In-Reply-To: <1319128700-15841-1-git-send-email-mikel.astiz@bmw-carit.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6539005141795923637==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/hfp_hf.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/plugins/hfp_hf.c b/plugins/hfp_hf.c
index ba06434..bceae55 100644
--- a/plugins/hfp_hf.c
+++ b/plugins/hfp_hf.c
@@ -38,12 +38,14 @@
 #include <ofono/plugin.h>
 #include <ofono/log.h>
 #include <ofono/modem.h>
+#include <ofono/devinfo.h>
 #include <ofono/netreg.h>
 #include <ofono/voicecall.h>
 #include <ofono/call-volume.h>
 #include <ofono/handsfree.h>
 =

 #include <drivers/hfpmodem/slc.h>
+#include <drivers/hfpmodem/hfpmodem.h>
 =

 #include "bluetooth.h"
 =

@@ -207,6 +209,7 @@ static int hfp_hf_probe(const char *device, const char =
*dev_addr,
 	struct ofono_modem *modem;
 	struct hfp_data *data;
 	char buf[256];
+	struct hfp_devinfo_params devinfo_params;
 =

 	/* We already have this device in our hash, ignore */
 	if (g_hash_table_lookup(modem_hash, device) !=3D NULL)
@@ -232,6 +235,10 @@ static int hfp_hf_probe(const char *device, const char=
 *dev_addr,
 =

 	ofono_modem_set_data(modem, data);
 	ofono_modem_set_name(modem, alias);
+
+	devinfo_params.device_address =3D dev_addr;
+	ofono_devinfo_create(modem, 0, "hfpmodem", &devinfo_params);
+
 	ofono_modem_register(modem);
 =

 	g_hash_table_insert(modem_hash, g_strdup(device), modem);
-- =

1.7.6.4


--===============6539005141795923637==--

