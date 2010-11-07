Content-Type: multipart/mixed; boundary="===============2660991543708424893=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 2/3] sms: Handle "USIM Download" SMS type.
Date: Sun, 07 Nov 2010 18:42:19 +0100
Message-ID: <1289151740-9922-2-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1289151740-9922-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2660991543708424893==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/sms.c |   21 ++++++++++++++++-----
 1 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/src/sms.c b/src/sms.c
index 456dda9..eba4564 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -1415,6 +1415,8 @@ static inline gboolean handle_mwi(struct ofono_sms *s=
ms, struct sms *s)
 void ofono_sms_deliver_notify(struct ofono_sms *sms, unsigned char *pdu,
 				int len, int tpdu_len)
 {
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(sms->atom);
+	struct ofono_atom *stk_atom;
 	struct sms s;
 	enum sms_class cls;
 =

@@ -1479,13 +1481,22 @@ void ofono_sms_deliver_notify(struct ofono_sms *sms=
, unsigned char *pdu,
 		break;
 	case SMS_PID_TYPE_USIM_DOWNLOAD:
 	case SMS_PID_TYPE_ANSI136:
-		if (cls =3D=3D SMS_CLASS_2) {
-			ofono_error("(U)SIM Download messages not supported");
+		/* If not Class 2, handle in a "normal" way */
+		if (cls !=3D SMS_CLASS_2)
+			break;
+
+		stk_atom =3D __ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_STK);
+
+		if (!stk_atom)
 			return;
-		}
 =

-		/* Otherwise handle in a "normal" way */
-		break;
+		__ofono_sms_sim_download(__ofono_atom_get_data(stk_atom),
+						&s, NULL, sms);
+
+		/* Passing the USIM response back to network is not
+		 * currently support */
+		/* TODO: store in EFsms if not handled */
+		return;
 	default:
 		break;
 	}
-- =

1.7.1.86.g0e460.dirty


--===============2660991543708424893==--

