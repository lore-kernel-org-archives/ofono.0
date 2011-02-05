Content-Type: multipart/mixed; boundary="===============5741350789306653456=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 7/7] smsutil: M16 coding style fix
Date: Sat, 05 Feb 2011 06:29:11 -0800
Message-ID: <1296916151-21778-8-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1296916151-21778-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5741350789306653456==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/smsutil.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/smsutil.h b/src/smsutil.h
index fc81eb1..42d2e9e 100644
--- a/src/smsutil.h
+++ b/src/smsutil.h
@@ -423,13 +423,13 @@ struct txq_backup_entry {
 =

 static inline gboolean is_bit_set(unsigned char oct, int bit)
 {
-	int mask =3D 0x1 << bit;
+	int mask =3D 1 << bit;
 	return oct & mask ? TRUE : FALSE;
 }
 =

 static inline unsigned char bit_field(unsigned char oct, int start, int nu=
m)
 {
-	unsigned char mask =3D (0x1 << num) - 1;
+	unsigned char mask =3D (1 << num) - 1;
 =

 	return (oct >> start) & mask;
 }
-- =

1.7.0.4


--===============5741350789306653456==--

