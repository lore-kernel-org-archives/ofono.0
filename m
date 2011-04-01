Content-Type: multipart/mixed; boundary="===============3310502060080224657=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH v3 03/26] gatio: add g_at_io_drain_ring_buffer() definition
Date: Fri, 01 Apr 2011 10:56:05 +0200
Message-ID: <1301648188-7208-4-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1301648188-7208-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3310502060080224657==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gatio.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/gatchat/gatio.c b/gatchat/gatio.c
index 2778260..f679cd0 100644
--- a/gatchat/gatio.c
+++ b/gatchat/gatio.c
@@ -387,3 +387,8 @@ void g_at_io_set_write_done(GAtIO *io, GAtDisconnectFun=
c func,
 	io->write_done_func =3D func;
 	io->write_done_data =3D user_data;
 }
+
+void g_at_io_drain_ring_buffer(GAtIO *io, guint len)
+{
+	ring_buffer_drain(io->buf, len);
+}
-- =

1.7.1


--===============3310502060080224657==--

