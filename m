Content-Type: multipart/mixed; boundary="===============7560180536603641414=="
MIME-Version: 1.0
From: Kalle Valo <kalle.valo@canonical.com>
Subject: [PATCH 1/3] atmodem: add signal strength support for huawei
Date: Fri, 23 Apr 2010 16:40:13 +0300
Message-ID: <20100423134013.2107.51323.stgit@potku.valot.fi>
In-Reply-To: <20100423133926.2107.66535.stgit@potku.valot.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7560180536603641414==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Huawei doesn't support CIND indications, so use CSQ instead. But naturally
the response from modem is not according to standard:

ofonod[6401]: < \r\n^BOOT:38645652,0,0,0,87\r\n
ofonod[6401]: < \r\n^RSSI:23\r\n

Support for this format is not yet implemented.
---

 drivers/atmodem/network-registration.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/atmodem/network-registration.c b/drivers/atmodem/netwo=
rk-registration.c
index f7aafbe..1c2b583 100644
--- a/drivers/atmodem/network-registration.c
+++ b/drivers/atmodem/network-registration.c
@@ -849,6 +849,7 @@ static void at_creg_set_cb(gboolean ok, GAtResult *resu=
lt, gpointer user_data)
 =

 	switch (nd->vendor) {
 	case OFONO_VENDOR_PHONESIM:
+	case OFONO_VENDOR_HUAWEI:
 		g_at_chat_register(nd->chat, "+CSQ:",
 					csq_notify, FALSE, netreg, NULL);
 =



--===============7560180536603641414==--

