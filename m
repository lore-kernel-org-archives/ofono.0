Content-Type: multipart/mixed; boundary="===============4204653312350575773=="
MIME-Version: 1.0
From: Antara Borwankar <antara.borwankar@intel.com>
Subject: [PATCH] xmm7modem: enabling simtoolkit for xmm7modem
Date: Wed, 06 Mar 2019 17:24:33 +0530
Message-ID: <1551873273-32334-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4204653312350575773==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

added code to enable and initialize stk in xmm7modem plugin
---
 plugins/xmm7xxx.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/plugins/xmm7xxx.c b/plugins/xmm7xxx.c
index 90e52fb..83ed263 100644
--- a/plugins/xmm7xxx.c
+++ b/plugins/xmm7xxx.c
@@ -1223,6 +1223,16 @@ static void xmm7xxx_pre_sim(struct ofono_modem *mode=
m)
 	DBG("%p", modem);
 =

 	ofono_devinfo_create(modem, OFONO_VENDOR_IFX, "atmodem", data->chat);
+
+	ofono_stk_create(modem, 0, "atmodem", data->chat);
+
+	/*	enabling stk	*/
+	g_at_chat_send(data->chat,
+		"AT+CFUN=3D6", none_prefix, NULL, NULL, NULL);
+	/*	sim reset to get stk menu command	*/
+	g_at_chat_send(data->chat,
+		"AT+CFUN=3D27,1", none_prefix, NULL, NULL, NULL);
+
 	data->sim =3D ofono_sim_create(modem, OFONO_VENDOR_IFX, "atmodem",
 					data->chat);
 }
-- =

1.9.1


--===============4204653312350575773==--

