Content-Type: multipart/mixed; boundary="===============2021475746788829384=="
MIME-Version: 1.0
From: Antara Borwankar <antara.borwankar@intel.com>
Subject: [PATCH 2/2] netmon: Enabled netmon atom for xmm7modem plugin
Date: Tue, 09 Oct 2018 17:12:10 +0530
Message-ID: <1539085330-4517-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2021475746788829384==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Antara <antara.borwankar@intel.com>

enabling netmon atom to report current serving cell measurements
for xmm7modem
---
 Makefile.am       | 3 ++-
 plugins/xmm7xxx.c | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/Makefile.am b/Makefile.am
index 10ace55..6667524 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -404,7 +404,8 @@ builtin_sources +=3D drivers/atmodem/atutil.h \
 			drivers/xmm7modem/xmm7modem.h \
 			drivers/xmm7modem/xmm7modem.c \
 			drivers/xmm7modem/radio-settings.c \
-			drivers/xmm7modem/ims.c
+			drivers/xmm7modem/ims.c \
+			drivers/xmm7modem/netmon.c
 =

 if PHONESIM
 builtin_modules +=3D phonesim
diff --git a/plugins/xmm7xxx.c b/plugins/xmm7xxx.c
index 066e2e7..243738e 100644
--- a/plugins/xmm7xxx.c
+++ b/plugins/xmm7xxx.c
@@ -356,6 +356,7 @@ static void xmm7xxx_post_online(struct ofono_modem *mod=
em)
 		ofono_gprs_add_context(gprs, gc);
 =

 	ofono_ims_create(modem, "xmm7modem", data->chat);
+	ofono_netmon_create(modem, 0, "xmm7modem", data->chat);
 }
 =

 static int xmm7xxx_probe(struct ofono_modem *modem)
-- =

1.9.1


--===============2021475746788829384==--

