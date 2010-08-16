Content-Type: multipart/mixed; boundary="===============5664245105398428324=="
MIME-Version: 1.0
From: Sjur =?unknown-8bit?q?Br=C3=A6ndeland?= <sjurbren@gmail.com>
Subject: [PATCH v3 2/7] plugins/ste: SIM - STE registers as MBM to utilize mbm
 quirks.
Date: Mon, 16 Aug 2010 22:35:44 +0200
Message-ID: <1281990950-21705-2-git-send-email-sjurbren@gmail.com>
In-Reply-To: <1281990950-21705-1-git-send-email-sjurbren@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5664245105398428324==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Sjur Br=C3=A6ndeland <sjur.brandeland@stericsson.com>

---
Marcel Holtmann wrote:
...
>do we really wanna create another vendor quirk here. If both modems
>behave identical then just pass OFONO_VENDOR_MBM in the SIM atom
>registration and be done with it.

Re-use the MBM quirk rather than adding STE quirks in atmodem/sim.c

---
 plugins/ste.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/plugins/ste.c b/plugins/ste.c
index 9cb49d3..9d9afd6 100644
--- a/plugins/ste.c
+++ b/plugins/ste.c
@@ -214,7 +214,7 @@ static void ste_pre_sim(struct ofono_modem *modem)
 =

 	ofono_devinfo_create(modem, 0, "atmodem", data->chat);
 	sim =3D ofono_sim_create(modem, 0, "atmodem", data->chat);
-	ofono_voicecall_create(modem, 0, "stemodem", data->chat);
+	ofono_voicecall_create(modem, OFONO_VENDOR_MBM, "stemodem", data->chat);
 =

 	if (sim)
 		ofono_sim_inserted_notify(sim, TRUE);
-- =

1.6.3.3


--===============5664245105398428324==--

