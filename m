Content-Type: multipart/mixed; boundary="===============3779530922142594945=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH] test-stkutil: Fix always true condition.
Date: Wed, 30 Jun 2010 14:31:45 +0200
Message-ID: <1277901105-2161-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3779530922142594945==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-stkutil.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/unit/test-stkutil.c b/unit/test-stkutil.c
index 8b7e254..ba4d227 100644
--- a/unit/test-stkutil.c
+++ b/unit/test-stkutil.c
@@ -220,8 +220,8 @@ static void check_gsm_sms(const struct sms *command,
 		g_assert(cs->srr =3D=3D ts->srr);
 		g_assert(cs->mr =3D=3D ts->mr);
 =

-		g_assert(cs->daddr.number_type =3D=3D cs->daddr.number_type);
-		g_assert(cs->daddr.numbering_plan =3D=3D cs->daddr.numbering_plan);
+		g_assert(cs->daddr.number_type =3D=3D ts->daddr.number_type);
+		g_assert(cs->daddr.numbering_plan =3D=3D ts->daddr.numbering_plan);
 		g_assert(g_str_equal(cs->daddr.address, ts->daddr.address));
 =

 		g_assert(cs->pid =3D=3D ts->pid);
-- =

1.7.1.86.g0e460.dirty


--===============3779530922142594945==--

