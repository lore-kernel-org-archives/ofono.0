Content-Type: multipart/mixed; boundary="===============5803245154989382711=="
MIME-Version: 1.0
From: Alexander Couzens <lynxis@fe80.eu>
Subject: [PATCH 5/7] udevng/gobi: assign GPS device to the modem object
Date: Mon, 01 May 2017 22:52:54 +0200
Message-ID: <20170501205256.4205-5-lynxis@fe80.eu>
In-Reply-To: <20170501205256.4205-1-lynxis@fe80.eu>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5803245154989382711==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/udevng.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index bd954f4b..9418bb5d 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -249,6 +249,11 @@ static gboolean setup_gobi(struct modem_info *modem)
 	else
 		DBG("optional mdm interface missing");
 =

+	if (gps)
+		ofono_modem_set_string(modem->modem, "GPS", gps);
+	else
+		DBG("optional gps interface missing");
+
 	return TRUE;
 }
 =

-- =

2.12.2


--===============5803245154989382711==--

