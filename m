Content-Type: multipart/mixed; boundary="===============1495373994108012747=="
MIME-Version: 1.0
From: Yang Gu <gyagp0@gmail.com>
Subject: [PATCH 3/8] teststk: Add check of len in byte array
Date: Wed, 26 May 2010 22:39:09 +0800
Message-ID: <1274884754-12977-3-git-send-email-yang.gu@intel.com>
In-Reply-To: <1274884754-12977-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1495373994108012747==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-stkutil.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/unit/test-stkutil.c b/unit/test-stkutil.c
index 173ab2d..e01cb17 100644
--- a/unit/test-stkutil.c
+++ b/unit/test-stkutil.c
@@ -82,6 +82,7 @@ static inline void check_common_byte_array(
 	}
 =

 	g_assert(command->len !=3D 0);
+	g_assert(command->len =3D=3D test->len);
 	g_assert(g_mem_equal(command->array, test->array, test->len));
 }
 =

-- =

1.7.0.4


--===============1495373994108012747==--

