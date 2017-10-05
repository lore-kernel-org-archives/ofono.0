Content-Type: multipart/mixed; boundary="===============4491935519026052635=="
MIME-Version: 1.0
From: Ankit Navik <ankit.p.navik@intel.com>
Subject: [PATCH 5/6] xmm7modem: Add support for ims
Date: Thu, 05 Oct 2017 22:45:03 +0530
Message-ID: <1507223703-13827-3-git-send-email-ankit.p.navik@intel.com>
In-Reply-To: <1507223703-13827-1-git-send-email-ankit.p.navik@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4491935519026052635==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/xmm7xxx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/plugins/xmm7xxx.c b/plugins/xmm7xxx.c
index 24b7d31..5cb843b 100644
--- a/plugins/xmm7xxx.c
+++ b/plugins/xmm7xxx.c
@@ -341,6 +341,8 @@ static void xmm7xxx_post_online(struct ofono_modem *mod=
em)
 =

 	if (gprs && gc)
 		ofono_gprs_add_context(gprs, gc);
+
+	ofono_ims_create(modem, "xmm7modem", data->chat);
 }
 =

 static int xmm7xxx_probe(struct ofono_modem *modem)
-- =

1.9.1


--===============4491935519026052635==--

