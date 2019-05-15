Content-Type: multipart/mixed; boundary="===============0471225977007907643=="
MIME-Version: 1.0
From: Antara Borwankar <antara.borwankar@intel.com>
Subject: [PATCH 1/2] xmm7modem: enabling simtoolkit in modem driver
Date: Wed, 15 May 2019 16:40:13 +0530
Message-ID: <1557918613-16921-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0471225977007907643==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

handled enabling of stk for xmm7modem vendor in atmodem
driver.
---
 drivers/atmodem/stk.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/atmodem/stk.c b/drivers/atmodem/stk.c
index f0dc5c0..43ae953 100644
--- a/drivers/atmodem/stk.c
+++ b/drivers/atmodem/stk.c
@@ -191,6 +191,19 @@ static gboolean at_stk_register(gpointer user)
 		g_at_chat_register(sd->chat, "*HCMD:", phonesim_hcmd_notify,
 						FALSE, stk, NULL);
 =

+	if (sd->vendor =3D=3D OFONO_VENDOR_XMM) {
+		/*	enabling stk	*/
+		g_at_chat_send(sd->chat, "AT+CFUN=3D6", none_prefix,
+						NULL, NULL, NULL);
+		/*	Here ofono has missed stk menu proactive command
+		 *	that comes after sim initialization only. Doing a
+		 *	sim reset will enable the stk driver to get the =

+		 *	missed +CUSATP notifications.
+		 */
+		g_at_chat_send(sd->chat, "AT+CFUN=3D27,1", none_prefix,
+						NULL, NULL, NULL);
+	}
+
 	ofono_stk_register(stk);
 =

 	return FALSE;
-- =

1.9.1


--===============0471225977007907643==--

