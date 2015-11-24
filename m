Content-Type: multipart/mixed; boundary="===============1748314469200243018=="
MIME-Version: 1.0
From: Tony Espy <espy@canonical.com>
Subject: [PATCH 1/2] unit: add write support to rilmodem-test-server
Date: Tue, 24 Nov 2015 14:38:51 -0500
Message-ID: <1448393932-16043-2-git-send-email-espy@canonical.com>
In-Reply-To: <1448393932-16043-1-git-send-email-espy@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1748314469200243018==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This change adds write support to the rilmodem-test-server
in order to support testing receipt of unsolicted RIL
responses.
---
 unit/rilmodem-test-server.c | 113 ++++++++++++++++++++++++++++------------=
----
 unit/rilmodem-test-server.h |  11 ++++-
 2 files changed, 80 insertions(+), 44 deletions(-)

diff --git a/unit/rilmodem-test-server.c b/unit/rilmodem-test-server.c
index 52a3c74..17e5090 100644
--- a/unit/rilmodem-test-server.c
+++ b/unit/rilmodem-test-server.c
@@ -37,10 +37,13 @@
 =

 #define MAX_REQUEST_SIZE 4096
 =

-static int server_sk;
-static ConnectFunc connect_func;
-static GIOChannel *server_io;
-static const struct rilmodem_test_data *rtd;
+struct server_data {
+	int server_sk;
+	ConnectFunc connect_func;
+	GIOChannel *server_io;
+	const struct rilmodem_test_data *rtd;
+	void *user_data;
+};
 =

 /* Warning: length is stored in network order */
 struct rsp_hdr {
@@ -52,6 +55,7 @@ struct rsp_hdr {
 =

 static gboolean read_server(gpointer data)
 {
+	struct server_data *sd =3D data;
 	GIOStatus status;
 	gsize offset, rbytes, wbytes;
 	gchar *buf, *bufp;
@@ -60,14 +64,13 @@ static gboolean read_server(gpointer data)
 =

 	buf =3D g_malloc0(MAX_REQUEST_SIZE);
 =

-	status =3D g_io_channel_read_chars(server_io, buf, MAX_REQUEST_SIZE,
+	status =3D g_io_channel_read_chars(sd->server_io, buf, MAX_REQUEST_SIZE,
 								&rbytes, NULL);
 	g_assert(status =3D=3D G_IO_STATUS_NORMAL);
-
-	g_assert(rbytes =3D=3D rtd->req_size);
+	g_assert(rbytes =3D=3D sd->rtd->req_size);
 =

 	/* validate len, and request_id */
-	g_assert(!memcmp(buf, rtd->req_data, (sizeof(uint32_t) * 2)));
+	g_assert(!memcmp(buf, sd->rtd->req_data, (sizeof(uint32_t) * 2)));
 =

 	/*
 	 * header: size (uint32), reqid (uin32), serial (uint32)
@@ -84,28 +87,28 @@ static gboolean read_server(gpointer data)
 =

 	/* validate the rest of the parcel... */
 	offset =3D (sizeof(uint32_t) * 3);
-	g_assert(!memcmp(bufp, rtd->req_data + offset,
-						rtd->req_size - offset));
+	g_assert(!memcmp(bufp, sd->rtd->req_data + offset,
+						sd->rtd->req_size - offset));
 =

 	/* Length does not include the length field. Network order. */
-	rsp.length =3D htonl(sizeof(rsp) - sizeof(rsp.length) + rtd->rsp_size);
+	rsp.length =3D htonl(sizeof(rsp) - sizeof(rsp.length) +
+							sd->rtd->rsp_size);
 	rsp.unsolicited =3D 0;
 	rsp.serial =3D req_serial;
-	rsp.error =3D rtd->rsp_error;
+	rsp.error =3D sd->rtd->rsp_error;
 =

 	/* copy header */
 	memcpy(buf, &rsp, sizeof(rsp));
 =

-	if (rtd->rsp_size) {
+	if (sd->rtd->rsp_size) {
 		bufp =3D buf + sizeof(rsp);
 =

-		memcpy(bufp, rtd->rsp_data, rtd->rsp_size);
+		memcpy(bufp, sd->rtd->rsp_data, sd->rtd->rsp_size);
 	}
 =

-
-	status =3D g_io_channel_write_chars(server_io,
+	status =3D g_io_channel_write_chars(sd->server_io,
 					buf,
-					sizeof(rsp) + rtd->rsp_size,
+					sizeof(rsp) + sd->rtd->rsp_size,
 					&wbytes, NULL);
 =

 	/* FIXME: assert wbytes is correct */
@@ -113,7 +116,7 @@ static gboolean read_server(gpointer data)
 	g_assert(status =3D=3D G_IO_STATUS_NORMAL);
 =

 	g_free(buf);
-	g_io_channel_unref(server_io);
+	g_io_channel_unref(sd->server_io);
 =

 	return FALSE;
 }
@@ -121,6 +124,7 @@ static gboolean read_server(gpointer data)
 static gboolean on_socket_connected(GIOChannel *chan, GIOCondition cond,
 								gpointer data)
 {
+	struct server_data *sd =3D data;
 	struct sockaddr saddr;
 	unsigned int len =3D sizeof(saddr);
 	int fd;
@@ -128,48 +132,52 @@ static gboolean on_socket_connected(GIOChannel *chan,=
 GIOCondition cond,
 =

 	g_assert(cond =3D=3D G_IO_IN);
 =

-	fd =3D accept(server_sk, &saddr, &len);
+	fd =3D accept(sd->server_sk, &saddr, &len);
 	g_assert(fd !=3D -1);
 =

-	server_io =3D g_io_channel_unix_new(fd);
-	g_assert(server_io !=3D NULL);
+	sd->server_io =3D g_io_channel_unix_new(fd);
+	g_assert(sd->server_io !=3D NULL);
 =

-	if (connect_func)
-		connect_func(data);
-
-	status =3D g_io_channel_set_encoding(server_io, NULL, NULL);
+	status =3D g_io_channel_set_encoding(sd->server_io, NULL, NULL);
 	g_assert(status =3D=3D G_IO_STATUS_NORMAL);
 =

-	g_io_channel_set_buffered(server_io, FALSE);
-	g_io_channel_set_close_on_unref(server_io, TRUE);
+	g_io_channel_set_buffered(sd->server_io, FALSE);
+	g_io_channel_set_close_on_unref(sd->server_io, TRUE);
+
+	if (sd->connect_func)
+		sd->connect_func(sd->user_data);
 =

-	g_idle_add(read_server, data);
+	if (sd->rtd->unsol_test =3D=3D FALSE)
+		g_idle_add(read_server, sd);
 =

 	return FALSE;
 }
 =

-void rilmodem_test_server_close(void)
+void rilmodem_test_server_close(struct server_data *sd)
 {
-	g_assert(server_sk);
-	close(server_sk);
-	server_sk =3D 0;
+	g_assert(sd->server_sk);
+	close(sd->server_sk);
+	g_free(sd);
 }
 =

-void rilmodem_test_server_create(ConnectFunc connect,
+struct server_data *rilmodem_test_server_create(ConnectFunc connect,
 				const struct rilmodem_test_data *test_data,
 				void *data)
 {
 	GIOChannel *io;
 	struct sockaddr_un addr;
 	int retval;
+	struct server_data *sd;
 =

-	g_assert(server_sk =3D=3D 0);
 =

-	connect_func =3D connect;
-	rtd =3D test_data;
+	sd =3D g_new0(struct server_data, 1);
 =

-	server_sk =3D socket(AF_UNIX, SOCK_STREAM, 0);
-	g_assert(server_sk);
+	sd->connect_func =3D connect;
+	sd->user_data =3D data;
+	sd->rtd =3D test_data;
+
+	sd->server_sk =3D socket(AF_UNIX, SOCK_STREAM, 0);
+	g_assert(sd->server_sk);
 =

 	memset(&addr, 0, sizeof(addr));
 	addr.sun_family =3D AF_UNIX;
@@ -178,19 +186,40 @@ void rilmodem_test_server_create(ConnectFunc connect,
 	/* Unlink any existing socket for this session */
 	unlink(addr.sun_path);
 =

-	retval =3D bind(server_sk, (struct sockaddr *) &addr, sizeof(addr));
+	retval =3D bind(sd->server_sk, (struct sockaddr *) &addr, sizeof(addr));
 	g_assert(retval >=3D 0);
 =

-	retval =3D listen(server_sk, 0);
+	retval =3D listen(sd->server_sk, 0);
 	g_assert(retval >=3D 0);
 =

-	io =3D g_io_channel_unix_new(server_sk);
+	io =3D g_io_channel_unix_new(sd->server_sk);
 	g_assert(io !=3D NULL);
 =

 	g_io_channel_set_close_on_unref(io, TRUE);
 	g_io_add_watch_full(io,	G_PRIORITY_DEFAULT,
 				G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
-				on_socket_connected, data, NULL);
+				on_socket_connected, sd, NULL);
 =

 	g_io_channel_unref(io);
+
+	return sd;
+}
+
+void rilmodem_test_server_write(struct server_data *sd,
+						const unsigned char *buf,
+						const size_t buf_len)
+{
+	GIOStatus status;
+	gsize wbytes;
+
+	status =3D g_io_channel_write_chars(sd->server_io,
+					(const char *) buf,
+					buf_len,
+					&wbytes, NULL);
+
+	g_assert(status =3D=3D G_IO_STATUS_NORMAL);
+
+	status =3D g_io_channel_flush(sd->server_io, NULL);
+
+	g_assert(status =3D=3D G_IO_STATUS_NORMAL);
 }
diff --git a/unit/rilmodem-test-server.h b/unit/rilmodem-test-server.h
index ba8b43c..e6a2afc 100644
--- a/unit/rilmodem-test-server.h
+++ b/unit/rilmodem-test-server.h
@@ -21,6 +21,8 @@
 =

 #define RIL_SERVER_SOCK_PATH    "/tmp/unittestril"
 =

+struct server_data;
+
 struct rilmodem_test_data {
 	const unsigned char *req_data;
 =

@@ -29,12 +31,17 @@ struct rilmodem_test_data {
 	uint32_t rsp_error;
 	const unsigned char *rsp_data;
 	const size_t rsp_size;
+	gboolean unsol_test;
 };
 =

 typedef void (*ConnectFunc)(void *data);
 =

-void rilmodem_test_server_close(void);
+void rilmodem_test_server_close(struct server_data *sd);
 =

-void rilmodem_test_server_create(ConnectFunc connect,
+struct server_data *rilmodem_test_server_create(ConnectFunc connect,
 				const struct rilmodem_test_data *test_data,
 				void *data);
+
+void rilmodem_test_server_write(struct server_data *sd,
+						const unsigned char *buf,
+						const size_t buf_len);
-- =

2.1.4


--===============1748314469200243018==--

