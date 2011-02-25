Content-Type: multipart/mixed; boundary="===============2048816496481160016=="
MIME-Version: 1.0
From: Antoine Reversat <a.reversat@gmail.com>
Subject: [PATCH 1/2] Clean up isi_call_any_address_sb_proc
Date: Fri, 25 Feb 2011 12:10:23 -0500
Message-ID: <1298653824-25127-1-git-send-email-a.reversat@gmail.com>
In-Reply-To: <AANLkTi=cm_SVQ6b9p89DBP37LUFhXpxnkz4ci997ET4k@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2048816496481160016==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/isimodem/voicecall.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/isimodem/voicecall.c b/drivers/isimodem/voicecall.c
index 0a32f27..0ad4dfb 100644
--- a/drivers/isimodem/voicecall.c
+++ b/drivers/isimodem/voicecall.c
@@ -210,10 +210,13 @@ static void isi_call_any_address_sb_proc(struct isi_v=
oicecall *ivc,
 	uint8_t len;
 	char *addr;
 =

-	if (!g_isi_sb_iter_get_byte(sb, &type, 2) ||
-			!g_isi_sb_iter_get_byte(sb, &pres, 3) ||
-			!g_isi_sb_iter_get_byte(sb, &len, 5) ||
-			!g_isi_sb_iter_get_alpha_tag(sb, &addr, 2 * len, 6))
+	if (!g_isi_sb_iter_get_byte(sb, &type, 2))
+		return;
+	if (!g_isi_sb_iter_get_byte(sb, &pres, 3))
+		return;
+	if (!g_isi_sb_iter_get_byte(sb, &len, 5))
+		return;
+	if (!g_isi_sb_iter_get_alpha_tag(sb, &addr, 2 * len, 6))
 		return;
 =

 	call->addr_type =3D type | 0x80;
-- =

1.7.1


--===============2048816496481160016==--

