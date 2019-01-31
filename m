Content-Type: multipart/mixed; boundary="===============7190809517613686307=="
MIME-Version: 1.0
From: Antara Borwankar <antara.borwankar@intel.com>
Subject: [PATCH 1/2] xmm7modem: Change in xmm7mode plugin for multi PDP
 handling
Date: Thu, 31 Jan 2019 11:48:47 +0530
Message-ID: <1548915527-4815-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7190809517613686307==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Made changes in xmm7modem plugin to allow mutiple PDP context
activation and to assign correct network interface to the
activated PDP context.
---
 plugins/udevng.c  |  2 ++
 plugins/xmm7xxx.c | 12 ++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index ff6e1fc..353a7dd 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -1219,6 +1219,8 @@ static gboolean setup_xmm7xxx(struct modem_info *mode=
m)
 =

 	ofono_modem_set_string(modem->modem, "Modem", mdm);
 	ofono_modem_set_string(modem->modem, "NetworkInterface", net);
+	ofono_modem_set_string(modem->modem, "CtrlPath", "/USBCDC/0");
+	ofono_modem_set_string(modem->modem, "DataPath", "/USBHS/NCM/");
 =

 	return TRUE;
 }
diff --git a/plugins/xmm7xxx.c b/plugins/xmm7xxx.c
index 237c62c..8b775e0 100644
--- a/plugins/xmm7xxx.c
+++ b/plugins/xmm7xxx.c
@@ -1282,6 +1282,18 @@ static void xmm7xxx_post_online(struct ofono_modem *=
modem)
 	if (gprs && gc)
 		ofono_gprs_add_context(gprs, gc);
 =

+	gc =3D ofono_gprs_context_create(modem, OFONO_VENDOR_XMM, "ifxmodem",
+					data->chat);
+
+	if (gprs && gc)
+		ofono_gprs_add_context(gprs, gc);
+
+	gc =3D ofono_gprs_context_create(modem, OFONO_VENDOR_XMM, "ifxmodem",
+					data->chat);
+
+	if (gprs && gc)
+		ofono_gprs_add_context(gprs, gc);
+
 	ofono_ims_create(modem, "xmm7modem", data->chat);
 	ofono_netmon_create(modem, 0, "xmm7modem", data->chat);
 }
-- =

1.9.1


--===============7190809517613686307==--

