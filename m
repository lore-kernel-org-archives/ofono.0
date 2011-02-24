Content-Type: multipart/mixed; boundary="===============4569696865925849083=="
MIME-Version: 1.0
From: Paavo Leinonen <paavo.leinonen@tieto.com>
Subject: [PATCH] common: '+' is not valid phone number anymore
Date: Thu, 24 Feb 2011 10:33:58 +0200
Message-ID: <1298536438-2646-1-git-send-email-paavo.leinonen@tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4569696865925849083==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Reject phone number if it contains only plus sign.
---
Hi,

Originally this issue was found while testing Call Forwarding. If =

user would set call fowarding to number '+', oFono actually erased =

existing CF settings. Fix was made to common.c as I don't think plus
should be considered as a valid phone number in any case.

BR,
Paavo

 src/common.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/src/common.c b/src/common.c
index 247fff0..520360c 100644
--- a/src/common.c
+++ b/src/common.c
@@ -246,6 +246,9 @@ gboolean valid_number_format(const char *number, int le=
ngth)
 	if (number[0] =3D=3D '+')
 		begin =3D 1;
 =

+	if (begin =3D=3D len)
+		return FALSE;
+
 	if ((len - begin) > length)
 		return FALSE;
 =

-- =

1.7.1


--===============4569696865925849083==--

