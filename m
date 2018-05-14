Content-Type: multipart/mixed; boundary="===============5093694589884154056=="
MIME-Version: 1.0
From: Bob Ham <bob.ham@puri.sm>
Subject: [PATCH 2/2] sim7100: Specify vendor ID while creating voicecall driver
Date: Mon, 14 May 2018 14:42:29 +0100
Message-ID: <20180514134229.14050-3-bob.ham@puri.sm>
In-Reply-To: <20180514134229.14050-1-bob.ham@puri.sm>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5093694589884154056==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This enables the atmodem voicecall driver to handle SIMCom quirks like
not setting AT+COLP=3D1.
---
 plugins/sim7100.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/plugins/sim7100.c b/plugins/sim7100.c
index dcd7c9ad..7c7e46d1 100644
--- a/plugins/sim7100.c
+++ b/plugins/sim7100.c
@@ -214,7 +214,7 @@ static void sim7100_pre_sim(struct ofono_modem *modem)
 =

 	ofono_devinfo_create(modem, 0, "atmodem", data->at);
 	sim =3D ofono_sim_create(modem, 0, "atmodem", data->at);
-	ofono_voicecall_create(modem, 0, "atmodem", data->at);
+	ofono_voicecall_create(modem, OFONO_VENDOR_SIMCOM, "atmodem", data->at);
 =

 	if (sim)
 		ofono_sim_inserted_notify(sim, TRUE);
-- =

2.11.0


--===============5093694589884154056==--

