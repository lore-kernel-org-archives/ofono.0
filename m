Content-Type: multipart/mixed; boundary="===============4188951709577072804=="
MIME-Version: 1.0
From: Antara Borwankar <antara.borwankar@intel.com>
Subject: [PATCH 2/3] xmm7modem: Changes in plugin for DSSA functionality
Date: Tue, 02 Apr 2019 11:54:42 +0530
Message-ID: <1554186282-31567-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4188951709577072804==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Changed the sim driver vendor for xmm7modem from
OFONO_VENDOR_IFX to OFONO_VENDOR_XMM to handle DSSA functionality.
---
 plugins/xmm7xxx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/plugins/xmm7xxx.c b/plugins/xmm7xxx.c
index 90e52fb..23a7d4e 100644
--- a/plugins/xmm7xxx.c
+++ b/plugins/xmm7xxx.c
@@ -1223,7 +1223,7 @@ static void xmm7xxx_pre_sim(struct ofono_modem *modem)
 	DBG("%p", modem);
 =

 	ofono_devinfo_create(modem, OFONO_VENDOR_IFX, "atmodem", data->chat);
-	data->sim =3D ofono_sim_create(modem, OFONO_VENDOR_IFX, "atmodem",
+	data->sim =3D ofono_sim_create(modem, OFONO_VENDOR_XMM, "atmodem",
 					data->chat);
 }
 =

-- =

1.9.1


--===============4188951709577072804==--

