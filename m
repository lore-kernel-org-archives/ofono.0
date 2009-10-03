Content-Type: multipart/mixed; boundary="===============4792477201886390686=="
MIME-Version: 1.0
From: Andres Salomon <dilinger@collabora.co.uk>
Subject: [PATCH] Check if unpacking of an sms buffer succeeds
Date: Fri, 02 Oct 2009 20:01:07 -0400
Message-ID: <20091002200107.6bfa8afe@mycelium.queued.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4792477201886390686==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

And here's one from a coworker that was necessary in order for him to
make use of oFono..



From: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Date: Fri, 2 Oct 2009 23:32:37 +0000 (+0100)
Subject: Check if unpacking of an sms buffer succeeds
X-Git-Url: http://git.collabora.co.uk/?p=3Duser%2Fsjoerd%2Fofono.git;a=3Dco=
mmitdiff_plain;h=3De457a55999f0d52393e048ff68763fc3b2fd1f44

Check if unpacking of an sms buffer succeeds

There are cases in which sms unpack_7bit_own_buf can fail (for example when
receiving an empty sms), in that case bail out instead of crashing...
---

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



--===============4792477201886390686==--

