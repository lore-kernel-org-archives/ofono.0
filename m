Content-Type: multipart/mixed; boundary="===============3464520978183121884=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 4/5] mbm: Use MBM vendor quirk of the sim driver.
Date: Thu, 17 Jun 2010 15:42:14 +0200
Message-ID: <1276782135-26871-9-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1276782135-26871-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3464520978183121884==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/mbm.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/plugins/mbm.c b/plugins/mbm.c
index 9d059ef..9193539 100644
--- a/plugins/mbm.c
+++ b/plugins/mbm.c
@@ -317,7 +317,8 @@ static void mbm_pre_sim(struct ofono_modem *modem)
 	DBG("%p", modem);
 =

 	ofono_devinfo_create(modem, 0, "atmodem", data->modem_port);
-	sim =3D ofono_sim_create(modem, 0, "atmodem", data->modem_port);
+	sim =3D ofono_sim_create(modem, OFONO_VENDOR_MBM, "atmodem",
+				data->modem_port);
 =

 	if (data->have_sim && sim)
 		ofono_sim_inserted_notify(sim, TRUE);
-- =

1.7.1.86.g0e460.dirty


--===============3464520978183121884==--

