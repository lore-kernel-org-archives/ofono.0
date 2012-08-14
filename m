Content-Type: multipart/mixed; boundary="===============8038317625285728128=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH ell 1/2] io: Fix not returning an error when watch_add() fails
Date: Mon, 13 Aug 2012 21:41:39 -0300
Message-ID: <1344904900-13807-1-git-send-email-vinicius.gomes@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8038317625285728128==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 ell/io.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/ell/io.c b/ell/io.c
index f4ce174..8a17b94 100644
--- a/ell/io.c
+++ b/ell/io.c
@@ -149,6 +149,7 @@ static void io_callback(int fd, uint32_t events, void *=
user_data)
 LIB_EXPORT struct l_io *l_io_new(int fd)
 {
 	struct l_io *io;
+	int err;
 =

 	if (unlikely(fd < 0))
 		return NULL;
@@ -159,7 +160,11 @@ LIB_EXPORT struct l_io *l_io_new(int fd)
 	io->events =3D 0;
 	io->close_on_destroy =3D false;
 =

-	watch_add(io->fd, io->events, io_callback, io, io_cleanup);
+	err =3D watch_add(io->fd, io->events, io_callback, io, io_cleanup);
+	if (err) {
+		l_free(io);
+		return NULL;
+	}
 =

 	return io;
 }
-- =

1.7.11.4


--===============8038317625285728128==--

