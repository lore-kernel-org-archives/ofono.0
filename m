Content-Type: multipart/mixed; boundary="===============8621331264346222124=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: Fix getting the offset into sms fragment bitmap.
Date: Sat, 22 Aug 2009 04:37:04 +0200
Message-ID: <1250908624-10547-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8621331264346222124==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Otherwise only 64 fragments fit.
---
 src/smsutil.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/smsutil.c b/src/smsutil.c
index bae501e..fcff9aa 100644
--- a/src/smsutil.c
+++ b/src/smsutil.c
@@ -2132,7 +2132,7 @@ GSList *sms_assembly_add_fragment(struct sms_assembly=
 *assembly,
 					const struct sms_address *addr,
 					guint16 ref, guint8 max, guint8 seq)
 {
-	int offset =3D seq / 8;
+	int offset =3D seq / 32;
 	int bit =3D 1 << (seq % 32);
 	GSList *l;
 	GSList *prev;
-- =

1.6.1


--===============8621331264346222124==--

