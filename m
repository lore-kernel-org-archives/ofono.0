Content-Type: multipart/mixed; boundary="===============6080404831815471694=="
MIME-Version: 1.0
From: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH v5] hfp_hf: BT address exposed through Serial property
Date: Wed, 02 Nov 2011 14:45:55 +0100
Message-ID: <1320241555-16727-1-git-send-email-mikel.astiz@bmw-carit.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6080404831815471694==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The devinfo atom is created in pre_sim (instead of probe).
---
 plugins/hfp_hf.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/plugins/hfp_hf.c b/plugins/hfp_hf.c
index ba06434..7a3567e 100644
--- a/plugins/hfp_hf.c
+++ b/plugins/hfp_hf.c
@@ -4,6 +4,7 @@
  *
  *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
  *  Copyright (C) 2010  ProFUSION embedded systems
+ *  Copyright (C) 2011  BMW Car IT GmbH. All rights reserved.
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2 as
@@ -38,6 +39,7 @@
 #include <ofono/plugin.h>
 #include <ofono/log.h>
 #include <ofono/modem.h>
+#include <ofono/devinfo.h>
 #include <ofono/netreg.h>
 #include <ofono/voicecall.h>
 #include <ofono/call-volume.h>
@@ -62,6 +64,7 @@ static GHashTable *modem_hash =3D NULL;
 struct hfp_data {
 	struct hfp_slc_info info;
 	char *handsfree_path;
+	char *handsfree_address;
 	DBusMessage *slc_msg;
 	gboolean agent_registered;
 	DBusPendingCall *call;
@@ -230,6 +233,10 @@ static int hfp_hf_probe(const char *device, const char=
 *dev_addr,
 	if (data->handsfree_path =3D=3D NULL)
 		goto free;
 =

+	data->handsfree_address =3D g_strdup(dev_addr);
+	if (data->handsfree_address =3D=3D NULL)
+		goto free;
+
 	ofono_modem_set_data(modem, data);
 	ofono_modem_set_name(modem, alias);
 	ofono_modem_register(modem);
@@ -239,6 +246,10 @@ static int hfp_hf_probe(const char *device, const char=
 *dev_addr,
 	return 0;
 =

 free:
+	if (data !=3D NULL) {
+		g_free(data->handsfree_path);
+	}
+
 	g_free(data);
 	ofono_modem_remove(modem);
 =

@@ -358,6 +369,7 @@ static void hfp_remove(struct ofono_modem *modem)
 =

 	g_hash_table_remove(modem_hash, data->handsfree_path);
 =

+	g_free(data->handsfree_address);
 	g_free(data->handsfree_path);
 	g_free(data);
 =

@@ -474,6 +486,7 @@ static void hfp_pre_sim(struct ofono_modem *modem)
 =

 	DBG("%p", modem);
 =

+	ofono_devinfo_create(modem, 0, "hfpmodem", data->handsfree_address);
 	ofono_voicecall_create(modem, 0, "hfpmodem", &data->info);
 	ofono_netreg_create(modem, 0, "hfpmodem", &data->info);
 	ofono_call_volume_create(modem, 0, "hfpmodem", &data->info);
-- =

1.7.6.4


--===============6080404831815471694==--

