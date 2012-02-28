Content-Type: multipart/mixed; boundary="===============0409890190489118484=="
MIME-Version: 1.0
From: jr_extern@vfnet.de
Subject: [PATCH 1/3] add some length verification to avoid reading not owned
 memory
Date: Tue, 28 Feb 2012 09:17:23 +0100
Message-ID: <1330417045-26518-1-git-send-email-jr_extern@vfnet.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0409890190489118484==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Jens Rehsack <jr_extern@vfnet.de>

---
 src/push.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/src/push.c b/src/push.c
index 6a54907..6107352 100644
--- a/src/push.c
+++ b/src/push.c
@@ -351,13 +351,16 @@ gboolean mms_push_notify(unsigned char *pdu, unsigned=
 int len,
 	/* Consume TID and Type */
 	nread =3D 2;
 =

-	if (wsp_decode_uintvar(pdu + nread, len,
+	if (wsp_decode_uintvar(pdu + nread, len - nread,
 					&headerslen, &consumed) =3D=3D FALSE)
 		return FALSE;
 =

 	/* Consume uintvar bytes */
 	nread +=3D consumed;
 =

+	/* Check if content type could be read */
+	if (headerslen > (len - nread))
+		return FALSE;
 	/* Try to decode content-type */
 	if (wsp_decode_content_type(pdu + nread, headerslen, &ct,
 			&consumed, &param_len) =3D=3D FALSE)
@@ -370,6 +373,9 @@ gboolean mms_push_notify(unsigned char *pdu, unsigned i=
nt len,
 	consumed +=3D param_len;
 	nread +=3D consumed;
 =

+	/* Check if application_id could be read */
+	if ((headerslen - consumed) > (len - nread))
+		return FALSE;
 	/* Parse header to decode application_id */
 	wsp_header_iter_init(&iter, pdu + nread, headerslen - consumed, 0);
 =

-- =

1.7.9.1


--===============0409890190489118484==--

