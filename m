Content-Type: multipart/mixed; boundary="===============2459109540441833972=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH ell 2/2] io: Fix not considering that watch_modify() may fail
Date: Mon, 13 Aug 2012 21:41:40 -0300
Message-ID: <1344904900-13807-2-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1344904900-13807-1-git-send-email-vinicius.gomes@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2459109540441833972==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 ell/io.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/ell/io.c b/ell/io.c
index 8a17b94..bc0bf86 100644
--- a/ell/io.c
+++ b/ell/io.c
@@ -236,6 +236,7 @@ LIB_EXPORT bool l_io_set_read_handler(struct l_io *io, =
l_io_read_cb_t callback,
 				void *user_data, l_io_destroy_cb_t destroy)
 {
 	uint32_t events;
+	int err;
 =

 	if (unlikely(!io || io->fd < 0))
 		return false;
@@ -258,7 +259,9 @@ LIB_EXPORT bool l_io_set_read_handler(struct l_io *io, =
l_io_read_cb_t callback,
 	if (events =3D=3D io->events)
 		return true;
 =

-	watch_modify(io->fd, events);
+	err =3D watch_modify(io->fd, events);
+	if (err)
+		return false;
 =

 	io->events =3D events;
 =

@@ -280,6 +283,7 @@ LIB_EXPORT bool l_io_set_write_handler(struct l_io *io,=
 l_io_write_cb_t callback
 				void *user_data, l_io_destroy_cb_t destroy)
 {
 	uint32_t events;
+	int err;
 =

 	if (unlikely(!io || io->fd < 0))
 		return false;
@@ -306,7 +310,9 @@ LIB_EXPORT bool l_io_set_write_handler(struct l_io *io,=
 l_io_write_cb_t callback
 	if (events =3D=3D io->events)
 		return true;
 =

-	watch_modify(io->fd, events);
+	err =3D watch_modify(io->fd, events);
+	if (err)
+		return false;
 =

 	io->events =3D events;
 =

-- =

1.7.11.4


--===============2459109540441833972==--

