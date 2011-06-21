Content-Type: multipart/mixed; boundary="===============5627402206539004053=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH v2 2/2] voicecall: add ATD> support for HFP emulator
Date: Tue, 21 Jun 2011 18:48:34 +0200
Message-ID: <1308674914-13037-3-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1308674914-13037-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5627402206539004053==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/voicecall.c |   30 +++++++++++++++++++++++++++---
 1 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/src/voicecall.c b/src/voicecall.c
index 1f0d3b8..2eb32a6 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -3084,6 +3084,7 @@ static void emulator_atd_cb(struct ofono_emulator *em,
 			struct ofono_emulator_request *req, void *userdata)
 {
 	struct ofono_voicecall *vc =3D userdata;
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(vc->atom);
 	const char *str;
 	size_t len;
 	char number[OFONO_MAX_PHONE_NUMBER_LENGTH + 1];
@@ -3102,10 +3103,33 @@ static void emulator_atd_cb(struct ofono_emulator *=
em,
 				str[len - 1] !=3D ';')
 			goto fail;
 =

-		strncpy(number, str, len - 1);
-		number[len - 1] =3D '\0';
+		if (len =3D=3D 3 && str[0] =3D=3D '>' && str[1] =3D=3D '1') {
+			struct ofono_atom *mw_atom;
+			struct ofono_message_waiting *mw;
+			const struct ofono_phone_number *ph;
+			const char *num;
 =

-		emulator_dial(em, vc, number);
+			mw_atom =3D __ofono_modem_find_atom(modem,
+					OFONO_ATOM_TYPE_MESSAGE_WAITING);
+
+			if (mw_atom =3D=3D NULL)
+				goto fail;
+
+			mw =3D __ofono_atom_get_data(mw_atom);
+			ph =3D __ofono_message_waiting_get_mbdn(mw, 0);
+
+			if (ph =3D=3D NULL)
+				goto fail;
+
+			num =3D phone_number_to_string(ph);
+
+			emulator_dial(em, vc, num);
+		} else {
+			strncpy(number, str, len - 1);
+			number[len - 1] =3D '\0';
+
+			emulator_dial(em, vc, number);
+		}
 		break;
 =

 	default:
-- =

1.7.1


--===============5627402206539004053==--

