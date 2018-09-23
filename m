Content-Type: multipart/mixed; boundary="===============6498570335961080089=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: [PATCH] atmodem/cbs: added Gemalto vendor
Date: Sun, 23 Sep 2018 07:26:14 +0200
Message-ID: <20180923052614.8186-1-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6498570335961080089==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/cbs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/atmodem/cbs.c b/drivers/atmodem/cbs.c
index 0a76ba25..1824b47d 100644
--- a/drivers/atmodem/cbs.c
+++ b/drivers/atmodem/cbs.c
@@ -166,6 +166,7 @@ static void at_cbs_set_topics(struct ofono_cbs *cbs, co=
nst char *topics,
 	switch (data->vendor) {
 	case OFONO_VENDOR_GOBI:
 	case OFONO_VENDOR_QUALCOMM_MSM:
+	case OFONO_VENDOR_GEMALTO:
 		g_at_chat_send(data->chat, "AT+CSCB=3D0", none_prefix,
 				NULL, NULL, NULL);
 		break;
-- =

2.17.1


--===============6498570335961080089==--

