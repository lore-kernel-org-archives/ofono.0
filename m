Content-Type: multipart/mixed; boundary="===============6276103454385251815=="
MIME-Version: 1.0
From: Antara Borwankar <antara.borwankar@intel.com>
Subject: [PATCH 2/2] xmm7modem: enabling simtoolkit for xmm7modem
Date: Wed, 15 May 2019 16:40:46 +0530
Message-ID: <1557918646-18026-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6276103454385251815==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

added code to create stk atom in xmm7modem plugin
---
 plugins/xmm7xxx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/plugins/xmm7xxx.c b/plugins/xmm7xxx.c
index 23a7d4e..da6622b 100644
--- a/plugins/xmm7xxx.c
+++ b/plugins/xmm7xxx.c
@@ -1225,6 +1225,7 @@ static void xmm7xxx_pre_sim(struct ofono_modem *modem)
 	ofono_devinfo_create(modem, OFONO_VENDOR_IFX, "atmodem", data->chat);
 	data->sim =3D ofono_sim_create(modem, OFONO_VENDOR_XMM, "atmodem",
 					data->chat);
+	ofono_stk_create(modem, OFONO_VENDOR_XMM, "atmodem", data->chat);
 }
 =

 static void set_online_cb(gboolean ok, GAtResult *result, gpointer user_da=
ta)
-- =

1.9.1


--===============6276103454385251815==--

