Content-Type: multipart/mixed; boundary="===============3136700853461304325=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH QMI LTE v2 03/13] gprs: release active contexts completely
Date: Fri, 14 Apr 2017 23:36:36 +0200
Message-ID: <20170414213646.32066-4-jonas@southpole.se>
In-Reply-To: <20170414213646.32066-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3136700853461304325==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The release_active_contexts method ask the driver to deactive all
the active contexts it knows about; however, after doing so, the
context state needs to be released, as well, so that the contexts
do not continue to appear to be active.
---
 src/gprs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/gprs.c b/src/gprs.c
index 6ed1c89..b6e11e8 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -1614,6 +1614,9 @@ static void release_active_contexts(struct ofono_gprs=
 *gprs)
 =

 		if (gc->driver->detach_shutdown !=3D NULL)
 			gc->driver->detach_shutdown(gc, ctx->context.cid);
+
+		pri_reset_context_settings(ctx);
+		release_context(ctx);
 	}
 }
 =

-- =

2.9.3


--===============3136700853461304325==--

