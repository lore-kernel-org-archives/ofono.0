Content-Type: multipart/mixed; boundary="===============4608528225723050462=="
MIME-Version: 1.0
From: Santtu Lakkala <inz@inz.fi>
Subject: [PATCH] Add support for tty on character device.
Date: Mon, 15 Jun 2009 20:13:25 +0300
Message-ID: <4A368135.8070805@inz.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4608528225723050462==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Adds support for using ttys through a serial device directly.

Signed-off-by: Santtu Lakkala <inz@inz.fi>
---
 drivers/atmodem/session.c |   36 ++++++++++++++++++++++++++++--------
 1 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/drivers/atmodem/session.c b/drivers/atmodem/session.c
index 2301756..3a9e49b 100644
--- a/drivers/atmodem/session.c
+++ b/drivers/atmodem/session.c
@@ -77,7 +77,7 @@ static gboolean connect_cb(GIOChannel *io,
GIOCondition cond, gpointer user)
 		socklen_t len =3D sizeof(err);

 		if (getsockopt(sock, SOL_SOCKET, SO_ERROR, &err, &len) < 0)
-			err =3D errno;
+			err =3D errno =3D=3D ENOTSOCK ? 0 : errno;
 	} else if (cond & (G_IO_HUP | G_IO_ERR))
 		err =3D ECONNRESET;

@@ -101,29 +101,47 @@ static gboolean connect_timeout(gpointer user)
 	return FALSE;
 }

-#if 0
-static int tty_open(const char *tty, struct termios *ti)
+static GIOChannel *tty_connect(const char *tty)
 {
+	GIOChannel *io;
 	int sk;
+	struct termios newtio;

 	sk =3D open(tty, O_RDWR | O_NOCTTY);

 	if (sk < 0) {
 		ofono_error("Can't open TTY %s: %s(%d)",
 				tty, strerror(errno), errno);
-		return -1;
+		return NULL;
 	}

-	if (ti && tcsetattr(sk, TCSANOW, ti) < 0) {
+	newtio.c_cflag =3D B115200 | CRTSCTS | CLOCAL | CREAD;
+	newtio.c_iflag =3D IGNPAR;
+	newtio.c_oflag =3D 0;
+	newtio.c_lflag =3D 0;
+
+	newtio.c_cc[VTIME] =3D 1;
+	newtio.c_cc[VMIN] =3D 5;
+
+	tcflush(sk, TCIFLUSH);
+	if (tcsetattr(sk, TCSANOW, &newtio) < 0) {
 		ofono_error("Can't change serial settings: %s(%d)",
 				strerror(errno), errno);
 		close(sk);
-		return -1;
+		return NULL;
 	}

-	return sk;
+	io =3D g_io_channel_unix_new(sk);
+	g_io_channel_set_close_on_unref(io, TRUE);
+
+	if (g_io_channel_set_flags(io, G_IO_FLAG_NONBLOCK,
+					NULL) !=3D G_IO_STATUS_NORMAL) {
+		g_io_channel_unref(io);
+		return NULL;
+	}
+
+	return io;
 }
-#endif

 static GIOChannel *socket_common(int sk, struct sockaddr *addr,
 					socklen_t addrlen)
@@ -233,6 +251,8 @@ GIOChannel *modem_session_create(const char *target,
 		io =3D tcp_connect(target+4);
 	else if (!strncasecmp(target, "unix:", 5))
 		io =3D unix_connect(target+5);
+	else if (!strncasecmp(target, "dev:", 4))
+		io =3D tty_connect(target+4);

 	if (io =3D=3D NULL)
 		return NULL;
-- =

debian.1.6.1.2.1

--===============4608528225723050462==--

