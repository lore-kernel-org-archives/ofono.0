Content-Type: multipart/mixed; boundary="===============1915182608324117471=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH] dun_gw: Fix automatic GIOChannel closing when a bluetooth
 connection is attempted.
Date: Fri, 11 Mar 2011 14:39:59 +0100
Message-ID: <1299850799-4997-1-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1915182608324117471==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/dun_gw.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/plugins/dun_gw.c b/plugins/dun_gw.c
index 53edc74..3bc4836 100644
--- a/plugins/dun_gw.c
+++ b/plugins/dun_gw.c
@@ -101,7 +101,7 @@ static void dun_gw_connect_cb(GIOChannel *io, GError *e=
rr, gpointer user_data)
 	}
 =

 	fd =3D g_io_channel_unix_get_fd(io);
-	g_io_channel_set_close_on_unref(io, TRUE);
+	g_io_channel_set_close_on_unref(io, FALSE);
 =

 	ofono_emulator_register(em, fd);
 }
-- =

1.7.1


--===============1915182608324117471==--

