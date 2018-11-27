Content-Type: multipart/mixed; boundary="===============7748098731580907079=="
MIME-Version: 1.0
From: Nandini Rebello <nandini.rebello@intel.com>
Subject: [PATCH] xmm7xxx: Adding case for SIM PIN locked state
Date: Tue, 27 Nov 2018 15:08:31 +0530
Message-ID: <1543311511-24386-1-git-send-email-nandini.rebello@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7748098731580907079==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Handling the case when SIM PIN is enabled for xmm7xxx modem.
---
 plugins/xmm7xxx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/plugins/xmm7xxx.c b/plugins/xmm7xxx.c
index 1223008..195f96b 100644
--- a/plugins/xmm7xxx.c
+++ b/plugins/xmm7xxx.c
@@ -129,6 +129,12 @@ static void switch_sim_state_status(struct ofono_modem=
 *modem, int status)
 			data->sms_phonebook_added =3D FALSE;
 		}
 		break;
+	case 1: /* SIM inserted, PIN verification needed */
+		if (data->have_sim =3D=3D FALSE) {
+			ofono_sim_inserted_notify(data->sim, TRUE);
+			data->have_sim =3D TRUE;
+		}
+		break;
 	case 2:	/* SIM inserted, PIN verification not needed - READY */
 	case 3:	/* SIM inserted, PIN verified - READY */
 	case 7: /* SIM inserted, SMS and phonebook - READY */
-- =

2.7.4


--===============7748098731580907079==--

