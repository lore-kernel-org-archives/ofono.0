Content-Type: multipart/mixed; boundary="===============1231509362477898804=="
MIME-Version: 1.0
From: Christophe Ronco <c.ronco@kerlink.fr>
Subject: [PATCH 4/4] udevng: Sierra modems use SIM driver
Date: Tue, 10 Jan 2017 09:38:47 +0100
Message-ID: <20170110083847.28309-5-c.ronco@kerlink.fr>
In-Reply-To: <20170110083847.28309-1-c.ronco@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1231509362477898804==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/udevng.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index 933bf4fa..a2866b64 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -252,8 +252,6 @@ static gboolean setup_sierra(struct modem_info *modem)
 =

 	if (qmi !=3D NULL && net !=3D NULL) {
 		ofono_modem_set_driver(modem->modem, "gobi");
-		/* Fixup SIM interface for Sierra QMI devices */
-		ofono_modem_set_boolean(modem->modem, "ForceSimLegacy", TRUE);
 		goto done;
 	}
 =

-- =

2.11.0


--===============1231509362477898804==--

