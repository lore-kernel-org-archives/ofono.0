Content-Type: multipart/mixed; boundary="===============6725272526940245705=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 1/4] Add command echo back if ATE=1
Date: Tue, 02 Mar 2010 18:21:36 +0800
Message-ID: <1267525299-5740-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6725272526940245705==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gatserver.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/gatchat/gatserver.c b/gatchat/gatserver.c
index f19d267..c72e798 100644
--- a/gatchat/gatserver.c
+++ b/gatchat/gatserver.c
@@ -382,6 +382,9 @@ static void new_bytes(GAtServer *p)
 		gsize rbytes =3D MIN(len - p->read_so_far, wrap - p->read_so_far);
 		result =3D server_feed(p, (char *)buf, &rbytes);
 =

+		if (p->v250.echo)
+			send_common(p, (char *)buf, rbytes);
+
 		buf +=3D rbytes;
 		p->read_so_far +=3D rbytes;
 =

-- =

1.6.6.1


--===============6725272526940245705==--

