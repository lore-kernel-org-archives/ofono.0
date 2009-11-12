Content-Type: multipart/mixed; boundary="===============0998533657653894625=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 1/3] Fix: Set data to NULL in hfpmodem drivers
Date: Fri, 13 Nov 2009 00:31:03 +0800
Message-ID: <1258043463.6363.1.camel@zzhan17-mobl.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0998533657653894625==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

The patch is to set data to NULL in hfpmodem drivers.
---
 drivers/hfpmodem/network-registration.c |    2 ++
 drivers/hfpmodem/voicecall.c            |    3 +++
 2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/hfpmodem/network-registration.c
b/drivers/hfpmodem/network-registration.c
index 13e8628..702b7a9 100644
--- a/drivers/hfpmodem/network-registration.c
+++ b/drivers/hfpmodem/network-registration.c
@@ -333,6 +333,8 @@ static void hfp_netreg_remove(struct ofono_netreg
*netreg)
 {
 	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
 =

+	ofono_netreg_set_data(netreg, NULL);
+
 	g_free(nd);
 }
 =

diff --git a/drivers/hfpmodem/voicecall.c b/drivers/hfpmodem/voicecall.c
index 8847985..9ba72e4 100644
--- a/drivers/hfpmodem/voicecall.c
+++ b/drivers/hfpmodem/voicecall.c
@@ -514,6 +514,9 @@ static void hfp_voicecall_remove(struct
ofono_voicecall *vc)
 =

 	g_slist_foreach(vd->calls, (GFunc) g_free, NULL);
 	g_slist_free(vd->calls);
+
+	ofono_voicecall_set_data(vc, NULL);
+
 	g_free(vd);
 }
 =

-- =

1.6.2.5




--===============0998533657653894625==--

