Content-Type: multipart/mixed; boundary="===============2342451521502220809=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 2/9] common: implement initializer for ofono_call
Date: Tue, 01 Feb 2011 15:12:43 -0200
Message-ID: <1296580370-2823-2-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1296580370-2823-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2342451521502220809==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/common.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/src/common.c b/src/common.c
index 8bf9dbb..f25f105 100644
--- a/src/common.c
+++ b/src/common.c
@@ -762,3 +762,10 @@ const char *ofono_uuid_to_str(const struct ofono_uuid =
*uuid)
 =

 	return encode_hex_own_buf(uuid->uuid, OFONO_SHA1_UUID_LEN, 0, buf);
 }
+
+void ofono_call_init(struct ofono_call *call)
+{
+	memset(call, 0, sizeof(struct ofono_call));
+	call->cnap_validity =3D CNAP_VALIDITY_NOT_AVAILABLE;
+	call->clip_validity =3D CLIP_VALIDITY_NOT_AVAILABLE;
+}
-- =

1.7.4


--===============2342451521502220809==--

