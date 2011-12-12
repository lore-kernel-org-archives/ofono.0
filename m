Content-Type: multipart/mixed; boundary="===============4694294406640246261=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH 1/2] cdmamodem: Support speedup dormant notification
Date: Mon, 12 Dec 2011 12:11:36 +0100
Message-ID: <1323688297-2538-2-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1323688297-2538-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4694294406640246261==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/cdmamodem/connman.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/cdmamodem/connman.c b/drivers/cdmamodem/connman.c
index 8c3265a..41708f7 100644
--- a/drivers/cdmamodem/connman.c
+++ b/drivers/cdmamodem/connman.c
@@ -264,6 +264,11 @@ static void at_c0_cb(gboolean ok, GAtResult *result, g=
pointer user_data)
 	}
 =

 	switch (cd->vendor) {
+	case OFONO_VENDOR_SPEEDUP:
+		/*
+		 * Fall through: SpeedUp modem uses same prefix as Huawei
+		 * modem for dormant notification.
+		 */
 	case OFONO_VENDOR_HUAWEI:
 		chat =3D g_at_chat_get_slave(cd->chat);
 		g_at_chat_register(chat, "^DSDORMANT", huawei_dsdormant_notify,
-- =

1.7.1


--===============4694294406640246261==--

