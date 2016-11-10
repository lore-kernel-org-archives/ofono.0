Content-Type: multipart/mixed; boundary="===============4484670643314240309=="
MIME-Version: 1.0
From: Kuba Pawlak <kubax.t.pawlak@intel.com>
Subject: [PATCH 1/2] gatchat: Fix parsing fields with odd number of quotation
 marks
Date: Thu, 10 Nov 2016 10:22:44 +0100
Message-ID: <1478769765-9839-1-git-send-email-kubax.t.pawlak@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4484670643314240309==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Events like +CLCC and +CCWA can have contact name attached to the
end of line. If this field contains odd number of quotation marks,
parser will eventually reject such message as malformatted.
---
 gatchat/gatsyntax.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/gatchat/gatsyntax.c b/gatchat/gatsyntax.c
index 800e35f..4d01ed7 100644
--- a/gatchat/gatsyntax.c
+++ b/gatchat/gatsyntax.c
@@ -309,6 +309,12 @@ static GAtSyntaxResult gsm_permissive_feed(GAtSyntax *=
syntax,
 		case GSM_PERMISSIVE_STATE_RESPONSE_STRING:
 			if (byte =3D=3D '"')
 				syntax->state =3D GSM_PERMISSIVE_STATE_RESPONSE;
+			else if (byte =3D=3D '\r') {
+				syntax->state =3D GSM_PERMISSIVE_STATE_IDLE;
+				i +=3D 1;
+				res =3D G_AT_SYNTAX_RESULT_LINE;
+				goto out;
+			}
 			break;
 =

 		case GSM_PERMISSIVE_STATE_GUESS_PDU:
-- =

2.5.5

Intel Deutschland GmbH
Registered Address: Am Campeon 10-12, 85579 Neubiberg, Germany
Tel: +49 89 99 8853-0, www.intel.de
Managing Directors: Christin Eisenschmid, Christian Lamprechter
Chairperson of the Supervisory Board: Nicole Lau
Registered Office: Munich
Commercial Register: Amtsgericht Muenchen HRB 186928


--===============4484670643314240309==--

