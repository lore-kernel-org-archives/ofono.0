Content-Type: multipart/mixed; boundary="===============6784769977173213188=="
MIME-Version: 1.0
From: Piotr Haber <gluedig@gmail.com>
Subject: [PATCH] telit: register SIM if it goes straight to ready
Date: Wed, 08 Feb 2017 10:25:37 +0100
Message-ID: <20170208092537.26073-1-gluedig@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6784769977173213188==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

SIM without PIN goes straight to state 3 (INSERTED and READY)
on some modem/firmware versions.
---
 plugins/telit.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/plugins/telit.c b/plugins/telit.c
index 19898f95..b194b65a 100644
--- a/plugins/telit.c
+++ b/plugins/telit.c
@@ -175,6 +175,11 @@ static void switch_sim_state_status(struct ofono_modem=
 *modem, int status)
 		}
 		break;
 	case 3:	/* SIM inserted, SMS and phonebook ready */
+		if (data->have_sim =3D=3D FALSE) {
+			ofono_sim_inserted_notify(data->sim, TRUE);
+			data->have_sim =3D TRUE;
+		}
+
 		if (data->sms_phonebook_added =3D=3D FALSE) {
 			ofono_phonebook_create(modem, 0, "atmodem", data->chat);
 			ofono_sms_create(modem, 0, "atmodem", data->chat);
-- =

2.11.0


--===============6784769977173213188==--

