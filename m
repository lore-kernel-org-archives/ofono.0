Content-Type: multipart/mixed; boundary="===============7434477124731408855=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: [PATCH 5/9] simutil: remove check for impossible condition
Date: Fri, 26 Oct 2018 12:13:15 +0200
Message-ID: <20181026101319.27709-6-jonas@norrbonn.se>
In-Reply-To: <20181026101319.27709-1-jonas@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7434477124731408855==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Jonas Bonn <jonas@southpole.se>

Addresses following warning:

src/simutil.c:1546:12: error: comparison of constant 8 with expression
of type
      'enum sim_cphs_service' is always false
      [-Werror,-Wtautological-constant-out-of-range-compare]
        if (index >=3D 2 * 4u)
---
 src/simutil.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/src/simutil.c b/src/simutil.c
index 9287df17..7f0e316e 100644
--- a/src/simutil.c
+++ b/src/simutil.c
@@ -1543,9 +1543,6 @@ gboolean sim_sst_is_active(unsigned char *efsst, unsi=
gned char len,
 =

 gboolean sim_cphs_is_active(unsigned char *cphs, enum sim_cphs_service ind=
ex)
 {
-	if (index >=3D 2 * 4u)
-		return FALSE;
-
 	return ((cphs[index / 4] >> ((index % 4) * 2)) & 3) =3D=3D 3;
 }
 =

-- =

2.17.1


--===============7434477124731408855==--

