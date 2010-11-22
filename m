Content-Type: multipart/mixed; boundary="===============6961862323189247667=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH] stk: Handle null Text field.
Date: Mon, 22 Nov 2010 05:43:01 +0100
Message-ID: <1290400982-17615-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6961862323189247667==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add a NULL check in dbus_apply_text_attributes because in some places
(like DisplayText handler) we call it without checking and we just check
the return value once.
---
 src/stk.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index 18beee6..291d7d2 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -303,6 +303,9 @@ static char *dbus_apply_text_attributes(const char *tex=
t,
 	const uint8_t *j =3D attr->attributes;
 	const uint8_t *end =3D j + attr->len;
 =

+	if (!text)
+		return NULL;
+
 	if (attr->len & 3)
 		return NULL;
 =

-- =

1.7.1.86.g0e460.dirty


--===============6961862323189247667==--

