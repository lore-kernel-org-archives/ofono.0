Content-Type: multipart/mixed; boundary="===============7805490837806117975=="
MIME-Version: 1.0
From: Lucas, GuillaumeX <guillaumex.lucas@intel.com>
Subject: [PATCH] stkutil: fix crash issue cause by null length of text string
Date: Tue, 07 Dec 2010 10:58:47 +0000
Message-ID: <9F3EABD6E3419B4C81F34EAABB4D40188136D95B11@irsmsx501.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7805490837806117975==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Guillaume Lucas <guillaumex.lucas@intel.com>

According to 3GPP TS 31.124 a null length for the text string
should be allowed. An empty string must be returned to the
user in this case.
---
 src/stkutil.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index a211462..cab22f4 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -562,7 +562,7 @@ static gboolean parse_dataobj_text(struct comprehension=
_tlv_iter *iter,
 {
 	char **text =3D user;
 	unsigned int len =3D comprehension_tlv_iter_get_length(iter);
-	const unsigned char *data =3D comprehension_tlv_iter_get_data(iter);
+	const unsigned char *data;
 	char *utf8;
 =

 	/* DCS followed by some text, cannot be 1 */
@@ -570,10 +570,12 @@ static gboolean parse_dataobj_text(struct comprehensi=
on_tlv_iter *iter,
 		return FALSE;
 =

 	if (len =3D=3D 0) {
-		*text =3D NULL;
+		*text =3D g_try_malloc0(1);
 		return TRUE;
 	}
 =

+	data =3D comprehension_tlv_iter_get_data(iter);
+
 	utf8 =3D decode_text(data[0], len - 1, data + 1);
 =

 	if (utf8 =3D=3D NULL)
-- =

1.7.0.4

---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


--===============7805490837806117975==--

