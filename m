Content-Type: multipart/mixed; boundary="===============8046554242053974892=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH 3/4] voicecall: Accept long phone number format for STK
Date: Wed, 05 Sep 2012 19:19:38 +0200
Message-ID: <1346865579-24794-4-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1346865579-24794-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8046554242053974892==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/voicecall.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/voicecall.c b/src/voicecall.c
index 12e5d4e..45dfac2 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -3675,7 +3675,7 @@ int __ofono_voicecall_dial(struct ofono_voicecall *vc,
 {
 	struct dial_request *req;
 =

-	if (!valid_phone_number_format(addr))
+	if (!valid_long_phone_number_format(addr))
 		return -EINVAL;
 =

 	if (vc->driver->dial =3D=3D NULL)
-- =

1.7.9.5


--===============8046554242053974892==--

