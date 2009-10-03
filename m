Content-Type: multipart/mixed; boundary="===============8836138720878334936=="
MIME-Version: 1.0
From: Andres Salomon <dilinger@collabora.co.uk>
Subject: Re: [PATCH] Check if unpacking of an sms buffer succeeds
Date: Fri, 02 Oct 2009 20:09:55 -0400
Message-ID: <20091002200955.5865f49d@mycelium.queued.net>
In-Reply-To: <20091002200107.6bfa8afe@mycelium.queued.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8836138720878334936==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Resending, as the previous patch was apparently mangled.


From 5a0e8a4d4947d8252df83f0d6c7226d944c83cf2 Mon Sep 17 00:00:00 2001
From: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Date: Fri, 2 Oct 2009 20:07:56 -0400
Subject: [PATCH] Check if unpacking of an sms buffer succeeds

There are cases in which sms unpack_7bit_own_buf can fail (for example when
receiving an empty sms), in that case bail out instead of crashing...
---
 src/smsutil.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/src/smsutil.c b/src/smsutil.c
index 106a39a..f389d29 100644
--- a/src/smsutil.c
+++ b/src/smsutil.c
@@ -2140,9 +2140,10 @@ char *sms_decode_text(GSList *sms_list)
 			guint8 single_shift =3D 0;
 			int max_chars =3D sms_text_capacity_gsm(udl, taken);
 =

-			unpack_7bit_own_buf(ud + taken, udl_in_bytes - taken,
+			if (unpack_7bit_own_buf(ud + taken, udl_in_bytes - taken,
 						taken, FALSE, max_chars,
-						&written, 0, buf);
+						&written, 0, buf) =3D=3D NULL)
+				break;
 =

 			/* Take care of improperly split fragments */
 			if (buf[written-1] =3D=3D 0x1b)
-- =

1.6.4.3




--===============8836138720878334936==--

