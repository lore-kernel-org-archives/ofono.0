Content-Type: multipart/mixed; boundary="===============1353506687365742312=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Dalleau <frederic.dalleau@linux.intel.com>
Subject: [PATCH] gatchat: Fix reentrency issue with empty commands
Date: Thu, 07 Jul 2011 16:19:29 +0200
Message-ID: <1310048369-31394-2-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1310048369-31394-1-git-send-email-frederic.dalleau@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1353506687365742312==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Emulator response to empty command is sent twice
---
 gatchat/gatserver.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/gatchat/gatserver.c b/gatchat/gatserver.c
index 3a996cb..a29e489 100644
--- a/gatchat/gatserver.c
+++ b/gatchat/gatserver.c
@@ -1008,6 +1008,9 @@ static void new_bytes(struct ring_buffer *rbuf, gpoin=
ter user_data)
 	unsigned char *buf =3D ring_buffer_read_ptr(rbuf, p->read_so_far);
 	enum ParserResult result;
 =

+	if (p->in_read_handler)
+		return;
+
 	p->in_read_handler =3D TRUE;
 =

 	while (p->io && (p->read_so_far < len)) {
-- =

1.7.1


--===============1353506687365742312==--

