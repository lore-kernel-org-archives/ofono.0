Content-Type: multipart/mixed; boundary="===============5028316135004710521=="
MIME-Version: 1.0
From: James Prestwood <james.prestwood@linux.intel.com>
Subject: [PATCH 2/2] isimodem: voicecall: fix strncpy compiler error (GCC 9)
Date: Mon, 17 Jun 2019 14:38:05 -0400
Message-ID: <20190617183805.32599-2-james.prestwood@linux.intel.com>
In-Reply-To: <20190617183805.32599-1-james.prestwood@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5028316135004710521==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

GCC complains that the destination buffer equals the size to copy:

In function =E2=80=98strncpy=E2=80=99,
    inlined from =E2=80=98isi_call_any_address_sb_proc.isra.0=E2=80=99 at d=
rivers/isimodem/voicecall.c:230:2:
/usr/include/bits/string_fortified.h:106:10: error: =E2=80=98__builtin_strn=
cpy=E2=80=99 specified bound 20 equals destination size [-Werror=3Dstringop=
-truncation]
  106 |   return __builtin___strncpy_chk (__dest, __src, __len, __bos (__de=
st));
      |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~
---
 drivers/isimodem/voicecall.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/isimodem/voicecall.c b/drivers/isimodem/voicecall.c
index 9a63f100..3fb150f6 100644
--- a/drivers/isimodem/voicecall.c
+++ b/drivers/isimodem/voicecall.c
@@ -227,7 +227,7 @@ static void isi_call_any_address_sb_proc(struct isi_voi=
cecall *ivc,
 =

 	call->addr_type =3D type | 0x80;
 	call->presentation =3D pres;
-	strncpy(call->address, addr, sizeof(call->address));
+	strncpy(call->address, addr, sizeof(call->address) - 1);
 =

 	g_free(addr);
 }
-- =

2.21.0


--===============5028316135004710521==--

