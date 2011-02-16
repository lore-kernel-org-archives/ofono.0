Content-Type: multipart/mixed; boundary="===============6020285851727417789=="
MIME-Version: 1.0
From: Jessica Nilsson <jessica.j.nilsson@stericsson.com>
Subject: [PATCH 1/1] src: out of bounds problem in smsutil
Date: Wed, 16 Feb 2011 13:04:58 +0100
Message-ID: <1297857898-21582-1-git-send-email-jessica.j.nilsson@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6020285851727417789==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---

This one was exposed when wgmodem2.5 CBS was run with valgrind.

Best Regards,
Jessica Nilsson

 src/smsutil.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/smsutil.c b/src/smsutil.c
index 5524932..b3a1ba1 100644
--- a/src/smsutil.c
+++ b/src/smsutil.c
@@ -4628,7 +4628,7 @@ char *cbs_topic_ranges_to_string(GSList *ranges)
 	}
 =

 	/* Space for ranges, commas and terminator null */
-	ret =3D g_new(char, len + nelem);
+	ret =3D g_new0(char, len + nelem + 1);
 =

 	len =3D 0;
 =

-- =

1.7.3.5


--===============6020285851727417789==--

