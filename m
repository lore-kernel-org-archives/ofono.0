Content-Type: multipart/mixed; boundary="===============1208820348757880802=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 3/4] Update rename result to state
Date: Tue, 02 Mar 2010 18:21:38 +0800
Message-ID: <1267525299-5740-3-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1267525299-5740-2-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1208820348757880802==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

to avoid name conflict with GAtServerResult
---
 gatchat/gatserver.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/gatchat/gatserver.c b/gatchat/gatserver.c
index 253a80a..df3c8bf 100644
--- a/gatchat/gatserver.c
+++ b/gatchat/gatserver.c
@@ -376,11 +376,11 @@ static void new_bytes(GAtServer *p)
 	unsigned int len =3D ring_buffer_len(p->read_buf);
 	unsigned int wrap =3D ring_buffer_len_no_wrap(p->read_buf);
 	unsigned char *buf =3D ring_buffer_read_ptr(p->read_buf, p->read_so_far);
-	enum ParserState result;
+	enum ParserState state;
 =

 	while (p->channel && (p->read_so_far < len)) {
 		gsize rbytes =3D MIN(len - p->read_so_far, wrap - p->read_so_far);
-		result =3D server_feed(p, (char *)buf, &rbytes);
+		state =3D server_feed(p, (char *)buf, &rbytes);
 =

 		if (p->v250.echo)
 			send_common(p, (char *)buf, rbytes);
@@ -393,10 +393,10 @@ static void new_bytes(GAtServer *p)
 			wrap =3D len;
 		}
 =

-		if (result =3D=3D PARSER_RESULT_UNSURE)
+		if (state =3D=3D PARSER_RESULT_UNSURE)
 			continue;
 =

-		switch (result) {
+		switch (state) {
 		case PARSER_RESULT_EMPTY_COMMAND:
 			/*
 			 * According to section 5.2.4 and 5.6 of V250,
-- =

1.6.6.1


--===============1208820348757880802==--

