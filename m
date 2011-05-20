Content-Type: multipart/mixed; boundary="===============4188592987718066539=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH 3/7] simutil: remove set but not used var
Date: Fri, 20 May 2011 16:03:41 -0300
Message-ID: <1305918225-8438-3-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1305918225-8438-2-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4188592987718066539==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/simutil.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/src/simutil.c b/src/simutil.c
index 85681b7..554a89a 100644
--- a/src/simutil.c
+++ b/src/simutil.c
@@ -724,11 +724,10 @@ gboolean comprehension_tlv_builder_set_length(
 	unsigned char *tlv =3D builder->pdu + builder->pos;
 	unsigned int tag_size =3D CTLV_TAG_FIELD_SIZE(tlv[0]);
 	unsigned int len_size, new_len_size;
-	unsigned int ctlv_len, new_ctlv_len;
+	unsigned int new_ctlv_len;
 	unsigned int len;
 =

 	len_size =3D CTLV_LEN_FIELD_SIZE(tlv[tag_size]);
-	ctlv_len =3D tag_size + len_size + builder->len;
 	new_len_size =3D BTLV_LEN_FIELD_SIZE_NEEDED(new_len);
 	new_ctlv_len =3D tag_size + new_len_size + new_len;
 =

-- =

1.7.5.1


--===============4188592987718066539==--

