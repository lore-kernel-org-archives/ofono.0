Content-Type: multipart/mixed; boundary="===============1090381120288486968=="
MIME-Version: 1.0
From: Antara Borwankar <antara.borwankar@intel.com>
Subject: [PATCH] xmm7modem: fix for crash after receiving MT SMS after SIM swap
Date: Tue, 15 Oct 2019 10:20:55 +0530
Message-ID: <1571115055-13615-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1090381120288486968==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Earlier SMS atom was being created based on +XSIMSTATE command,
which is a proprietary command for intel modems.
But this logic fails in case of SIM hot swap when +XSIMSTATE
value received is not handled in notify function.
There can be other such scenarios as well. Therefore SMS atom
will now be created in post_online function which anyways gets
called after +XSIMSTATE SMS READY and PB READY is received.
---
 plugins/xmm7xxx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/plugins/xmm7xxx.c b/plugins/xmm7xxx.c
index a544798..876f614 100644
--- a/plugins/xmm7xxx.c
+++ b/plugins/xmm7xxx.c
@@ -1003,7 +1003,6 @@ static void switch_sim_state_status(struct ofono_mode=
m *modem, int status)
 =

 		if (data->sms_phonebook_added =3D=3D FALSE) {
 			ofono_phonebook_create(modem, 0, "atmodem", data->chat);
-			ofono_sms_create(modem, 0, "atmodem", data->chat);
 			data->sms_phonebook_added =3D TRUE;
 		}
 =

@@ -1281,6 +1280,7 @@ static void xmm7xxx_post_online(struct ofono_modem *m=
odem)
 =

 	ofono_ims_create(modem, "xmm7modem", data->chat);
 	ofono_netmon_create(modem, 0, "xmm7modem", data->chat);
+	ofono_sms_create(modem, 0, "atmodem", data->chat);
 }
 =

 static int xmm7xxx_probe(struct ofono_modem *modem)
-- =

1.9.1

--===============1090381120288486968==--

