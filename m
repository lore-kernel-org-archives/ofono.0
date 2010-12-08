Content-Type: multipart/mixed; boundary="===============6722561090147549771=="
MIME-Version: 1.0
From: Jessica Nilsson <jessica.j.nilsson@stericsson.com>
Subject: [PATCH 1/4] gisi: Changes to prepare for isimodem2.5
Date: Wed, 08 Dec 2010 09:34:15 +0100
Message-ID: <1291797255-20472-1-git-send-email-jessica.j.nilsson@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6722561090147549771==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This set of patches introduces the isimodem2.5.

WG2.5 (isimodem2.5) Supported features list:

General:
Online / Offline mode (RF on/off)

Voice call:
MO/MT call
Multiparty call (max 7 calls)
Transfer call
Swap calls
Hold calls
Hang up all
Hang up specific call
Disconnect reason (Network/local/remote)
Send DTMF tones

PS data:
Primary PDP context (IPv4 only)
APN: User name and password supported
Attach mode: Manual (Automatic works as well, but not activated)
Data flow control not activated (Not supported by Kernel)

SMS:
Send and receieve SMS
Concatenated messages supported (up to 255 messages)
Class 0
Delivery reports
Read / Write SMSC to SIM card
Bearer settings supported (CS or PS)

Supplementary Services:
Call Barring
     VoiceOutgoing
     VoiceIncoming
Call Settings
     CalledLineRestriction
     HideCallerId
     CallingLinePresentation
     CalledLinePresentation
     VoiceCallWaiting
     CallingLineRestriction
Call Forwarding
     Voice Not Reachable
     Voice Busy
     Voice No Reply
     Voice Unconditional
USSD
     MO USSD
     MT USSD NOT SUPPORTED
SSN

CS Network:
Network registration
Scanning available networks
Selecting automatically and manually the target network
Changing RAT between GSM/UMTS/ANY
Registration status: Cell ID, LAC, MNC, Current Technology (GSM, UMTS, =

EDGE, HSDPA, HSUPA, HSDPA&HSUPA)
Deregister
RSSI (%)

SIM:
Read IMSI
MSISDN (Subscriber numbers)
SDN (Service Dialing Numbers)
PIN/PIN2/PUK/PUK2 supported (reset/change/lock)
Read file info from SIM
Read FIle (Transparent, Linear & Cyclic) * Some functionalities flagged =

out as ofono core is not using these
Write File (Transparent, Linear & Cyclic) * Some functionalities flagged =

out as ofono core is not using these
MCC & MNC
CardIdentifier
PreferredLanguages

Export contacts(SIM phonebook):
SIM and USIM cards supported
Name
Number (extension record supported)
Additional number
Email
No limitiation in amount of records read from SIM

CBS:
CBS reception in GSM
Subscribe Topics in range or specific value

Phone Info:
Revision of the modem SW
IMEI

This specific patch contains updates in Makefile.am, configure.ac and gisi =
to prepare the addition of isimodem2.5
Added 2 new files to gisi pipe_wg25.c and pipe_wg25.h, isimodem2.5 pipe imp=
lementation due to pipe handler not on modem side.

Regards,
Jessica Nilsson


---
 Makefile.am      |    6 +
 configure.ac     |   37 ++++
 gisi/client.c    |  116 ++++++++++-
 gisi/client.h    |   17 ++
 gisi/iter.c      |   19 ++-
 gisi/netlink.c   |   17 ++-
 gisi/pep.c       |   28 +++-
 gisi/phonet.h    |    3 +
 gisi/pipe.c      |   21 ++-
 gisi/pipe_wg25.c |  563 ++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 gisi/pipe_wg25.h |   97 ++++++++++
 gisi/server.c    |    7 +-
 gisi/socket.c    |   22 ++-
 gisi/verify.c    |   14 ++
 14 files changed, 936 insertions(+), 31 deletions(-)
 create mode 100644 gisi/pipe_wg25.c
 create mode 100644 gisi/pipe_wg25.h

diff --git a/Makefile.am b/Makefile.am
index cdb3166..caf3306 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -288,6 +288,12 @@ builtin_modules +=3D caif
 builtin_sources +=3D plugins/caif.c
 endif
 =

+if ISIMODEM25
+builtin_sources +=3D $(gisi_sources) \
+		gisi/pipe_wg25.h \
+		gisi/pipe_wg25.c
+endif
+
 if MAINTAINER_MODE
 builtin_modules +=3D example_history
 builtin_sources +=3D examples/history.c
diff --git a/configure.ac b/configure.ac
index 5c18f68..4e83053 100644
--- a/configure.ac
+++ b/configure.ac
@@ -155,6 +155,43 @@ AC_SUBST(UDEV_CFLAGS)
 AC_SUBST(UDEV_LIBS)
 AM_CONDITIONAL(UDEV, test "${enable_udev}" =3D "yes")
 =

+AC_ARG_ENABLE(isimodem, AC_HELP_STRING([--disable-isimodem],
+				[disable PhoNet/ISI modem support]),
+					[enable_isimodem=3D${enableval}])
+
+AC_ARG_ENABLE(capng, AC_HELP_STRING([--enable-capng],
+		[enable capabilities support]), [enable_capng=3D${enableval}])
+if (test "${enable_capng}" =3D "yes"); then
+	PKG_CHECK_MODULES(CAPNG, libcap-ng, dummy=3Dyes,
+				AC_MSG_ERROR(Capabilities library is required))
+	AC_SUBST(CAPNG_CFLAGS)
+	AC_SUBST(CAPNG_LIBS)
+	AC_DEFINE(HAVE_CAPNG, 1, [Define to 1 if you have capabilities library.])
+fi
+
+AC_ARG_ENABLE(isimodem25, AC_HELP_STRING([--disable-isimodem25],
+	[disable PhoNET/ISI modem v2.5 support]),
+	 [enable_isimodem25=3D${enableval}], [enable_isimodem25=3D"yes"])
+
+AC_ARG_ENABLE(isimodem25, AC_HELP_STRING([--enable-isimodem25],
+			[enable isimodem v2.5 Phonet support]), [
+	if (test "${enableval}" =3D "yes"); then
+		CFLAGS=3D"$CFLAGS -DSTE_U8500_PHONET"
+	fi
+])
+
+AC_ARG_ENABLE(isimodem, AC_HELP_STRING([--enable-isimodem],
+				[enable PhoNet/ISI modem support]),
+					[enable_isimodem=3D${enableval}], [enable_isimodem=3D"no"])
+
+if (test "${enable_isimodem}" =3D "yes" && test "${enable_isimodem25}" !=
=3D "no"); then
+	AC_MSG_FAILURE("cannot enable both isimodem and isimodem v2.5 support", 1)
+fi
+
+AM_CONDITIONAL(ISIMODEM25, test "${enable_isimodem25}" !=3D "no")
+
+AM_CONDITIONAL(ISIMODEM, test "${enable_isimodem}" !=3D "no")
+
 AC_ARG_ENABLE(atmodem, AC_HELP_STRING([--disable-atmodem],
 				[disable ETSI AT modem support]),
 					[enable_atmodem=3D${enableval}])
diff --git a/gisi/client.c b/gisi/client.c
index 8c0cc72..182bb56 100644
--- a/gisi/client.c
+++ b/gisi/client.c
@@ -28,22 +28,33 @@
 #include <string.h>
 #include <stdlib.h>
 #include <search.h>
+#include <stdio.h>
+#include <errno.h>
+#include <glib.h>
+
 #include <sys/types.h>
 #include <sys/socket.h>
 #include <sys/uio.h>
-#include <errno.h>
+#include <ofono/log.h>
 #include "phonet.h"
-#include <glib.h>
+
 =

 #include "socket.h"
 #include "client.h"
+#include "pipe_wg25.h"
 =

-#define PN_COMMGR			0x10
-#define PNS_SUBSCRIBED_RESOURCES_IND	0x10
+#define PN_COMMGR				0x10
+#define PNS_SUBSCRIBED_RESOURCES_EXTEND_IND	0x12
+#define PNS_SUBSCRIBED_MESSAGES_LIST		0x00
+#define PNS_SUBSCRIBED_RESOURCES_IND		0x10
 =

 static const struct sockaddr_pn commgr =3D {
 	.spn_family =3D AF_PHONET,
 	.spn_resource =3D PN_COMMGR,
+#ifdef STE_U8500_PHONET
+	.spn_dev =3D PN_MODEM,
+	.spn_obj =3D 0x00,
+#endif
 };
 =

 struct _GIsiRequest {
@@ -245,7 +256,7 @@ uint8_t g_isi_client_resource(GIsiClient *client)
  * @param opaque user data
  */
 void g_isi_client_set_debug(GIsiClient *client, GIsiDebugFunc func,
-				void *opaque)
+			    void *opaque)
 {
 	if (client =3D=3D NULL)
 		return;
@@ -254,6 +265,10 @@ void g_isi_client_set_debug(GIsiClient *client, GIsiDe=
bugFunc func,
 	client->debug_data =3D opaque;
 }
 =

+/**
+  * Request cleanup
+  * @param data
+  */
 static void g_isi_cleanup_req(void *data)
 {
 	GIsiRequest *req =3D data;
@@ -370,12 +385,19 @@ GIsiRequest *g_isi_sendto(GIsiClient *client,
 				GIsiResponseFunc cb, void *opaque,
 				GDestroyNotify notify)
 {
+#ifndef STE_U8500_PHONET
+
 	const struct iovec iov =3D {
 		.iov_base =3D (void *)buf,
 		.iov_len =3D len,
 	};
 =

 	return g_isi_vsendto(client, dst, &iov, 1, timeout, cb, opaque, notify);
+#else
+	return g_isi_send_phonet(client, buf, len, timeout, cb, opaque,
+				notify, FALSE);
+#endif
+
 }
 =

 =

@@ -450,7 +472,7 @@ GIsiRequest *g_isi_vsendto(GIsiClient *client,
 		.msg_controllen =3D 0,
 		.msg_flags =3D 0,
 	};
-	ssize_t ret;
+	ssize_t ret =3D 0;
 	size_t i, len;
 	unsigned int key;
 	uint8_t id;
@@ -494,7 +516,8 @@ GIsiRequest *g_isi_vsendto(GIsiClient *client,
 		 * initial miss. Although if the rate at which
 		 * requests are sent is so high that the transaction
 		 * ID wraps it's likely there is something wrong and
-		 * we might as well fail here. */
+		 * we might as well fail here.
+		 */
 		errno =3D EBUSY;
 		goto error;
 	}
@@ -534,6 +557,65 @@ error:
 	return NULL;
 }
 =

+#ifdef STE_U8500_PHONET
+/**
+ * Send an ISI request and register a callback to process the response(s) =
to
+ * the resulting transaction.
+ *
+ * @param cl ISI client (from g_isi_client_create())
+ * @param iov scatter-gather array to the request payload
+ * @param iovlen number of vectors in the scatter-gather array
+ * @param timeout timeout in seconds
+ * @param cb callback to process response(s)
+ * @param opaque data for the callback
+ * @param notify finalizer function for the @a opaque data (may be NULL)
+ *
+ * @return
+ * A pointer to a newly created GIsiRequest.
+ *
+ * @errors
+ * If an error occurs, @a errno is set accordingly and a NULL pointer is
+ * returned.
+ */
+GIsiRequest *g_isi_send_phonet(GIsiClient *client,
+			       const void *__restrict buf, size_t len,
+			       unsigned timeout,
+			       GIsiResponseFunc cb, void *opaque,
+			       GDestroyNotify notify,
+			       gboolean loopback)
+{
+	const struct iovec iov =3D {
+		.iov_base =3D (void *)buf,
+		.iov_len =3D len,
+	};
+
+	struct sockaddr_pn dst =3D {
+		.spn_family =3D AF_PHONET,
+		.spn_dev =3D 0x00,
+	};
+
+	if (!client) {
+		errno =3D EINVAL;
+		return NULL;
+	}
+
+	if (loopback) {
+		dst.spn_dev =3D 0x00;
+		dst.spn_resource =3D g_isi_get_pipe_handle_wg25(opaque);
+		dst.spn_obj =3D g_isi_get_pipe_handle_wg25(opaque);
+	} else if (client->resource =3D=3D PN_PIPE) {
+		dst.spn_obj =3D PN_OBJ_PEP_GPRS;
+		dst.spn_dev =3D PN_MODEM;
+	}
+
+	if (!loopback)
+		dst.spn_resource =3D client->resource;
+
+	return g_isi_vsendto(client, &dst, &iov, 1, timeout,
+				cb, opaque, notify);
+}
+
+#endif
 /**
  * Send an ISI request and register a callback to process the response(s) =
to
  * the resulting transaction.
@@ -625,9 +707,21 @@ int g_isi_commit_subscriptions(GIsiClient *client)
 {
 	GIOChannel *channel;
 	uint8_t msg[3+256] =3D {
+#ifdef STE_U8500_PHONET
+		0,
+		PNS_SUBSCRIBED_RESOURCES_EXTEND_IND,
+		client->inds.count, /*1, resource count */
+		0, /* filler */
+		0, /* filler */
+		0, /* filler */
+		0, /* filler */
+		client->resource,
+	};
+#else
 		0, PNS_SUBSCRIBED_RESOURCES_IND,
 		0,
 	};
+#endif
 =

 	if (client =3D=3D NULL)
 		return -EINVAL;
@@ -656,6 +750,7 @@ int g_isi_commit_subscriptions(GIsiClient *client)
 	/* Subscribe by sending an indication */
 	sendto(client->inds.fd, msg, 3+msg[2], MSG_NOSIGNAL, (void *)&commgr,
 		sizeof(commgr));
+
 	return 0;
 }
 =

@@ -692,9 +787,11 @@ int g_isi_add_subscription(GIsiClient *client, uint8_t=
 res, uint8_t type,
 		return -ENOMEM;
 	}
 =

-	/* FIXME: This overrides any existing subscription. We should
+	/*
+	 * FIXME: This overrides any existing subscription. We should
 	 * enable multiple subscriptions to a single indication in
-	 * order to allow efficient client sharing. */
+	 * order to allow efficient client sharing.
+	 */
 	if (*old !=3D ind) {
 		g_free(ind);
 		ind =3D *old;
@@ -857,6 +954,7 @@ static gboolean g_isi_callback(GIOChannel *channel, GIO=
Condition cond,
 			g_isi_dispatch_indication(client, res, obj, msg + 1,
 							len - 1);
 	}
+
 	return TRUE;
 }
 =

diff --git a/gisi/client.h b/gisi/client.h
index 16c459f..49f4468 100644
--- a/gisi/client.h
+++ b/gisi/client.h
@@ -37,6 +37,8 @@ typedef struct _GIsiClient GIsiClient;
 struct _GIsiRequest;
 typedef struct _GIsiRequest GIsiRequest;
 =

+struct _GIsiIndication;
+
 typedef void (*GIsiVerifyFunc)(GIsiClient *client, gboolean alive,
 				uint16_t object, void *opaque);
 =

@@ -70,11 +72,16 @@ void g_isi_client_set_debug(GIsiClient *client, GIsiDeb=
ugFunc func,
 =

 void g_isi_client_destroy(GIsiClient *client);
 =

+#ifdef STE_U8500_PHONET
+void verify_link_up(gboolean link);
+#endif
+
 int g_isi_client_error(const GIsiClient *client);
 =

 GIsiRequest *g_isi_request_make(GIsiClient *client, const void *data,
 				size_t len, unsigned timeout,
 				GIsiResponseFunc func, void *opaque);
+
 struct iovec;
 GIsiRequest *g_isi_request_vmake(GIsiClient *client, const struct iovec *i=
ov,
 					size_t iovlen, unsigned timeout,
@@ -87,6 +94,16 @@ GIsiRequest *g_isi_sendto(GIsiClient *client,
 				GIsiResponseFunc func, void *opaque,
 				GDestroyNotify notify);
 =

+#ifdef STE_U8500_PHONET
+GIsiRequest *g_isi_send_phonet(GIsiClient *client,
+			       const void *__restrict buf, size_t len,
+			       unsigned timeout,
+			       GIsiResponseFunc cb, void *opaque,
+			       GDestroyNotify notify,
+			       gboolean loopback);
+
+#endif
+
 GIsiRequest *g_isi_send(GIsiClient *client, const void *data, size_t len,
 			unsigned timeout,
 			GIsiResponseFunc func, void *opaque,
diff --git a/gisi/iter.c b/gisi/iter.c
index 3eef8dd..b392291 100644
--- a/gisi/iter.c
+++ b/gisi/iter.c
@@ -89,15 +89,21 @@ gboolean g_isi_sb_iter_is_valid(const GIsiSubBlockIter =
*iter)
 =

 int g_isi_sb_iter_get_id(const GIsiSubBlockIter *iter)
 {
-	if (iter->longhdr)
-		return (iter->start[0] << 8) | (iter->start[1]);
+	if (iter->longhdr) {
+		int ret =3D (iter->start[0] << 8) | (iter->start[1]);
+		return ret;
+	}
+
 	return iter->start[0];
 }
 =

 size_t g_isi_sb_iter_get_len(const GIsiSubBlockIter *iter)
 {
-	if (iter->longhdr)
-		return (iter->start[2] << 8) | (iter->start[3]);
+	if (iter->longhdr) {
+		int ret =3D (iter->start[2] << 8) | (iter->start[3]);
+		return ret;
+	}
+
 	return iter->start[1];
 }
 =

@@ -105,7 +111,7 @@ gboolean g_isi_sb_iter_get_data(const GIsiSubBlockIter =
*restrict iter,
 				void **data, unsigned pos)
 {
 	if ((size_t)pos > g_isi_sb_iter_get_len(iter)
-		|| iter->start + pos > iter->end)
+			|| iter->start + pos > iter->end)
 		return FALSE;
 	*data =3D (void *)iter->start + pos;
 	return TRUE;
@@ -115,7 +121,7 @@ gboolean g_isi_sb_iter_get_byte(const GIsiSubBlockIter =
*restrict iter,
 				uint8_t *byte, unsigned pos)
 {
 	if ((size_t)pos > g_isi_sb_iter_get_len(iter)
-		|| iter->start + pos > iter->end)
+	    || iter->start + pos > iter->end)
 		return FALSE;
 	*byte =3D iter->start[pos];
 	return TRUE;
@@ -189,6 +195,7 @@ gboolean g_isi_sb_iter_get_latin_tag(const GIsiSubBlock=
Iter *restrict iter,
 		return FALSE;
 =

 	str =3D iter->start + pos;
+
 	if (str + len > iter->end)
 		return FALSE;
 =

diff --git a/gisi/netlink.c b/gisi/netlink.c
index 44a4a8d..f2f80c5 100644
--- a/gisi/netlink.c
+++ b/gisi/netlink.c
@@ -105,6 +105,9 @@ static void bring_up(unsigned ifindex)
 	struct ifreq req =3D { .ifr_ifindex =3D ifindex, };
 	int fd =3D socket(PF_LOCAL, SOCK_DGRAM, 0);
 =

+	if (fd < 0)
+		goto error;
+
 	if (ioctl(fd, SIOCGIFNAME, &req)
 		|| ioctl(fd, SIOCGIFFLAGS, &req))
 		goto error;
@@ -176,7 +179,8 @@ static void g_pn_nl_link(GPhonetNetlink *self, struct n=
lmsghdr *nlh)
 	if (ifi->ifi_type !=3D ARPHRD_PHONET)
 		return;
 =

-	if (self->interface !=3D 0 && self->interface !=3D (unsigned)ifi->ifi_ind=
ex)
+	if (self->interface !=3D 0 &&
+			self->interface !=3D (unsigned)ifi->ifi_index)
 		return;
 =

 	idx =3D make_modem(ifi->ifi_index);
@@ -218,10 +222,11 @@ static gboolean g_pn_nl_process(GIOChannel *channel, =
GIOCondition cond,
 	int fd =3D g_io_channel_unix_get_fd(channel);
 	GPhonetNetlink *self =3D data;
 =

-	if (cond & (G_IO_NVAL|G_IO_HUP))
+	if (cond & (G_IO_NVAL | G_IO_HUP))
 		return FALSE;
 =

 	ret =3D recvmsg(fd, &msg, 0);
+
 	if (ret =3D=3D -1)
 		return TRUE;
 =

@@ -282,7 +287,7 @@ static int g_pn_netlink_getlink(int fd)
 	struct sockaddr_nl addr =3D { .nl_family =3D AF_NETLINK, };
 =

 	return sendto(fd, &req, sizeof(req), 0,
-		      (struct sockaddr *)&addr, sizeof(addr));
+			(struct sockaddr *)&addr, sizeof(addr));
 }
 =

 GPhonetNetlink *g_pn_netlink_start(GIsiModem *idx,
@@ -296,17 +301,19 @@ GPhonetNetlink *g_pn_netlink_start(GIsiModem *idx,
 	unsigned interface =3D g_isi_modem_index(idx);
 =

 	fd =3D netlink_socket();
+
 	if (fd =3D=3D -1)
 		return NULL;
 =

 	self =3D calloc(1, sizeof(*self));
+
 	if (self =3D=3D NULL)
 		goto error;
 =

 	fcntl(fd, F_SETFL, O_NONBLOCK | fcntl(fd, F_GETFL));
 =

 	if (setsockopt(fd, SOL_NETLINK, NETLINK_ADD_MEMBERSHIP,
-		       &group, sizeof(group)))
+			&group, sizeof(group)))
 		goto error;
 =

 	if (interface)
@@ -315,8 +322,10 @@ GPhonetNetlink *g_pn_netlink_start(GIsiModem *idx,
 	g_pn_netlink_getlink(fd);
 =

 	chan =3D g_io_channel_unix_new(fd);
+
 	if (chan =3D=3D NULL)
 		goto error;
+
 	g_io_channel_set_close_on_unref(chan, TRUE);
 	g_io_channel_set_encoding(chan, NULL, NULL);
 	g_io_channel_set_buffered(chan, FALSE);
diff --git a/gisi/pep.c b/gisi/pep.c
index bea1902..78b753e 100644
--- a/gisi/pep.c
+++ b/gisi/pep.c
@@ -33,6 +33,7 @@
 #include "phonet.h"
 #include "socket.h"
 #include "pep.h"
+#include "pipe_wg25.h"
 =

 struct _GIsiPEP {
 	GIsiPEPCallback ready;
@@ -55,14 +56,17 @@ static gboolean g_isi_pep_callback(GIOChannel *channel,=
 GIOCondition cond,
 		return FALSE;
 =

 	fd =3D accept(fd, NULL, NULL);
+
 	if (fd =3D=3D -1)
 		return TRUE;
+
 	fcntl(fd, F_SETFD, FD_CLOEXEC);
 =

 	if (setsockopt(fd, SOL_PNPIPE, PNPIPE_ENCAP, &encap, sizeof(encap))) {
 		close(fd);
 		return TRUE;
 	}
+
 	pep->gprs_fd =3D fd;
 =

 	if (pep->ready)
@@ -79,6 +83,17 @@ GIsiPEP *g_isi_pep_create(GIsiModem *modem, GIsiPEPCallb=
ack cb, void *opaque)
 	int fd;
 	char buf[IF_NAMESIZE];
 =

+#ifdef STE_U8500_PHONET
+	struct sockaddr_pn addr =3D {
+		.spn_family =3D AF_PHONET,
+		.spn_resource =3D 0,
+		.spn_dev =3D 0,
+		.spn_obj =3D 0,
+	};
+	addr.spn_resource =3D g_isi_get_new_pipe_handle_wg25();
+	addr.spn_obj =3D g_isi_get_pipe_handle_wg25();
+#endif
+
 	fd =3D socket(PF_PHONET, SOCK_SEQPACKET, 0);
 	if (fd =3D=3D -1)
 		return NULL;
@@ -89,9 +104,15 @@ GIsiPEP *g_isi_pep_create(GIsiModem *modem, GIsiPEPCall=
back cb, void *opaque)
 	if (if_indextoname(ifi, buf) =3D=3D NULL)
 		goto error;
 =

-	if (setsockopt(fd, SOL_SOCKET, SO_BINDTODEVICE, buf, IF_NAMESIZE) !=3D 0)
+	if (setsockopt(fd,
+			SOL_SOCKET, SO_BINDTODEVICE, buf, IF_NAMESIZE) !=3D 0)
 		goto error;
 =

+#ifdef STE_U8500_PHONET
+	if (bind(fd, (void *)&addr, sizeof(addr)))
+		goto error;
+#endif
+
 	pep =3D g_try_malloc(sizeof(GIsiPEP));
 	if (pep =3D=3D NULL)
 		goto error;
@@ -101,7 +122,11 @@ GIsiPEP *g_isi_pep_create(GIsiModem *modem, GIsiPEPCal=
lback cb, void *opaque)
 	pep->gprs_fd =3D -1;
 	pep->handle =3D 0;
 =

+#ifdef STE_U8500_PHONET
+	if (listen(fd, 1))
+#else
 	if (listen(fd, 1) || ioctl(fd, SIOCPNGETOBJECT, &pep->handle))
+#endif
 		goto error;
 =

 	channel =3D g_io_channel_unix_new(fd);
@@ -132,6 +157,7 @@ void g_isi_pep_destroy(GIsiPEP *pep)
 		close(pep->gprs_fd);
 	else
 		g_source_remove(pep->source);
+
 	g_free(pep);
 }
 =

diff --git a/gisi/phonet.h b/gisi/phonet.h
index f736931..d67d86e 100644
--- a/gisi/phonet.h
+++ b/gisi/phonet.h
@@ -34,6 +34,9 @@
 #define PN_PROTO_PHONET		1
 #define PN_PROTO_PIPE		2
 =

+#define PN_MODEM		0x60
+#define PN_MODEM_MEDIA		0x26
+
 #define SOL_PNPIPE		275
 =

 #define PNPIPE_ENCAP		1
diff --git a/gisi/pipe.c b/gisi/pipe.c
index 3146548..e9a0648 100644
--- a/gisi/pipe.c
+++ b/gisi/pipe.c
@@ -29,7 +29,7 @@
 #include "client.h"
 #include "pipe.h"
 =

-#define PN_PIPE	0xd9
+#define PN_PIPE 0xd9
 =

 typedef struct {
 	uint8_t cmd;
@@ -73,7 +73,7 @@ typedef struct {
 	uint8_t error2;
 } isi_pipe_resp_t;
 =

-#define PN_PIPE_INVALID_HANDLE	0xff
+#define PN_PIPE_INVALID_HANDLE 0xff
 =

 enum {
 	PNS_PIPE_CREATE_REQ,
@@ -144,7 +144,8 @@ static int g_isi_pipe_error(uint8_t code)
 	};
 =

 	if (code =3D=3D PN_PIPE_NO_ERROR ||
-	    ((code < sizeof(codes) / sizeof(codes[0])) && codes[code]))
+			((code < sizeof(codes) / sizeof(codes[0])) &&
+			codes[code]))
 		return codes[code];
 	return -EBADMSG;
 }
@@ -155,9 +156,11 @@ static void g_isi_pipe_handle_error(GIsiPipe *pipe, ui=
nt8_t code)
 =

 	if (err =3D=3D 0)
 		return;
+
 	pipe->error =3D err;
 	if (pipe->error_handler)
 		pipe->error_handler(pipe);
+
 }
 =

 static gboolean g_isi_pipe_created(GIsiClient *client,
@@ -168,7 +171,7 @@ static gboolean g_isi_pipe_created(GIsiClient *client,
 	const isi_pipe_resp_t *resp =3D data;
 =

 	if (len < 5 ||
-	    resp->cmd !=3D PNS_PIPE_CREATE_RESP)
+		resp->cmd !=3D PNS_PIPE_CREATE_RESP)
 		return FALSE;
 =

 	if (resp->pipe_handle !=3D PN_PIPE_INVALID_HANDLE) {
@@ -179,6 +182,7 @@ static gboolean g_isi_pipe_created(GIsiClient *client,
 			pipe->handler(pipe);
 	} else
 		g_isi_pipe_handle_error(pipe, resp->error_code);
+
 	return TRUE;
 }
 =

@@ -222,7 +226,7 @@ GIsiPipe *g_isi_pipe_create(GIsiModem *modem, void (*cr=
eated)(GIsiPipe *),
 	pipe->handle =3D PN_PIPE_INVALID_HANDLE;
 =

 	if (pipe->client =3D=3D NULL ||
-	    g_isi_request_make(pipe->client, &msg, sizeof(msg), 3,
+		g_isi_request_make(pipe->client, &msg, sizeof(msg), 3,
 				g_isi_pipe_created, pipe) =3D=3D NULL)
 		goto error;
 =

@@ -242,8 +246,9 @@ g_isi_pipe_check_resp(const GIsiPipe *pipe, uint8_t cmd,
 	const isi_pipe_resp_t *resp =3D data;
 =

 	if ((len < 5) || (resp->cmd !=3D cmd) ||
-	    (resp->pipe_handle !=3D pipe->handle))
+			(resp->pipe_handle !=3D pipe->handle))
 		return NULL;
+
 	return resp;
 }
 =

@@ -255,6 +260,7 @@ static gboolean g_isi_pipe_enabled(GIsiClient *client,
 	const isi_pipe_resp_t *resp;
 =

 	resp =3D g_isi_pipe_check_resp(pipe, PNS_PIPE_ENABLE_RESP, data, len);
+
 	if (!resp)
 		return FALSE;
 =

@@ -262,6 +268,7 @@ static gboolean g_isi_pipe_enabled(GIsiClient *client,
 	pipe->enabling =3D FALSE;
 	if (!pipe->error)
 		pipe->enabled =3D TRUE;
+
 	return TRUE;
 }
 =

@@ -286,6 +293,7 @@ int g_isi_pipe_start(GIsiPipe *pipe)
 {
 	if (pipe->error)
 		return pipe->error;
+
 	if (pipe->enabling || pipe->enabled)
 		return 0;
 =

@@ -306,6 +314,7 @@ static gboolean g_isi_pipe_removed(GIsiClient *client,
 	const isi_pipe_resp_t *resp;
 =

 	resp =3D g_isi_pipe_check_resp(pipe, PNS_PIPE_REMOVE_RESP, data, len);
+
 	if (!resp)
 		return FALSE;
 =

diff --git a/gisi/pipe_wg25.c b/gisi/pipe_wg25.c
new file mode 100644
index 0000000..73f26b4
--- /dev/null
+++ b/gisi/pipe_wg25.c
@@ -0,0 +1,563 @@
+/*
+ * This file is part of oFono - Open Source Telephony
+ *
+ * Copyright (C) 2009 Nokia Corporation and/or its subsidiary(-ies).
+ * Copyright (C) ST-Ericsson SA 2010.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <stdint.h>
+#include <stdbool.h>
+#include <errno.h>
+#include <glib.h>
+#include <ofono/log.h>
+#include "client.h"
+#include "pipe_wg25.h"
+
+typedef struct {
+	uint8_t cmd;
+	uint8_t pipe_handle;
+	uint8_t state_after;
+	uint8_t other_pep_type;
+	uint8_t filler1;
+	uint8_t filler2;
+	uint8_t n_sb;
+	uint8_t data_sb;
+	uint8_t sb_len;
+	uint8_t alignment;
+	uint8_t filler;
+} isi_pep_connect_req_t;
+
+typedef struct {
+	uint8_t cmd;
+	uint8_t pipe_handle;
+	uint8_t n_sb;
+	uint8_t sb_neg_fc;
+	uint8_t sb_len;
+	uint8_t tx_fc;
+	uint8_t rx_fc;
+} isi_pipe_created_ind_t;
+
+typedef struct {
+	uint8_t cmd;
+	uint8_t pipe_handle;
+	uint8_t filler;
+} isi_pep_enable_req_t;
+
+typedef struct {
+	uint8_t cmd;
+	uint8_t pipe_handle;
+	uint8_t filler;
+} isi_pipe_enabled_ind_t;
+
+typedef struct {
+	uint8_t cmd;
+	uint8_t pipe_handle;
+	uint8_t filler;
+} isi_pep_disconnect_req_t;
+
+typedef struct {
+	uint8_t cmd;
+	uint8_t pipe_handle;
+	uint8_t error_code;
+} isi_pep_resp_t;
+
+struct _GIsiPipe_wg25 {
+	GIsiClient *client;
+	void (*handler)(GIsiPipe_wg25 *);
+	void (*error_handler)(GIsiPipe_wg25 *);
+	void *opaque;
+	int error;
+	uint8_t handle;
+	gboolean enabled;
+	gboolean enabling;
+};
+
+uint8_t last_used_pipe_handle;
+
+
+static int g_isi_pipe_error_wg25(uint8_t code)
+{
+	static const int codes[] =3D {
+		[PN_PIPE_NO_ERROR] =3D 0,
+		[PN_PIPE_ERR_INVALID_PARAM] =3D -EINVAL,
+		[PN_PIPE_ERR_INVALID_HANDLE] =3D -EBADF,
+		[PN_PIPE_ERR_INVALID_CTRL_ID] =3D -ENOTSUP,
+		[PN_PIPE_ERR_NOT_ALLOWED] =3D -EPERM,
+		[PN_PIPE_ERR_PEP_IN_USE] =3D -EBUSY,
+		[PN_PIPE_ERR_OVERLOAD] =3D -ENOBUFS,
+		[PN_PIPE_ERR_DEV_DISCONNECTED] =3D -ENETDOWN,
+		[PN_PIPE_ERR_TIMEOUT] =3D -ETIMEDOUT,
+		[PN_PIPE_ERR_ALL_PIPES_IN_USE] =3D -ENFILE,
+		[PN_PIPE_ERR_GENERAL] =3D -EAGAIN,
+		[PN_PIPE_ERR_ALIGN_NOT_SUPPORTED] =3D -ENOSYS,
+		[PN_PIPE_ERR_NOT_SUPPORTED] =3D -ENOSYS,
+	};
+
+	if (code =3D=3D PN_PIPE_NO_ERROR ||
+		((code < sizeof(codes) / sizeof(codes[0])) &&
+		codes[code]))
+		return codes[code];
+
+	return -EBADMSG;
+}
+
+static void g_isi_pipe_handle_error_wg25(GIsiPipe_wg25 *pipe, uint8_t code)
+{
+	int err =3D g_isi_pipe_error_wg25(code);
+
+	if (err =3D=3D 0)
+		return;
+
+	pipe->error =3D err;
+
+	if (pipe->error_handler)
+		pipe->error_handler(pipe);
+
+}
+
+uint8_t g_isi_get_new_pipe_handle_wg25()
+{
+	last_used_pipe_handle++;
+
+	if (last_used_pipe_handle =3D=3D PN_PIPE_INVALID_HANDLE)
+		last_used_pipe_handle =3D 1;
+
+	return last_used_pipe_handle;
+}
+
+uint8_t g_isi_get_pipe_handle_wg25()
+{
+	return last_used_pipe_handle;
+}
+
+void g_isi_pipe_init_wg25()
+{
+	last_used_pipe_handle =3D 0;
+}
+
+static gboolean g_isi_pipe_created_phase2(GIsiClient *client,
+					const void *restrict data, size_t len,
+					uint16_t object, void *opaque)
+{
+	GIsiPipe_wg25 *pipe =3D opaque;
+	const unsigned char *resp =3D data;
+
+	if (len < 7 || resp[0] !=3D PNS_PEP_CONNECT_RESP)
+		return FALSE;
+
+	if (!g_isi_pipe_error_wg25(resp[2]) &&
+		(resp[1] !=3D PN_PIPE_INVALID_HANDLE) &&
+		(resp[1] =3D=3D pipe->handle)) {
+		isi_pipe_created_ind_t msg =3D {
+			.cmd =3D PNS_PIPE_CREATED_IND,
+			.pipe_handle =3D pipe->handle,
+			.n_sb =3D 0x01,
+			.sb_neg_fc =3D PN_PIPE_SB_NEGOTIATED_FC,
+			.sb_len =3D 0x04,
+			.tx_fc =3D PN_LEGACY_FLOW_CONTROL,
+			.rx_fc =3D PN_LEGACY_FLOW_CONTROL,
+		};
+
+		if (g_isi_send_phonet(pipe->client,
+				      &msg, sizeof(msg), 0, NULL,
+				      pipe, NULL, TRUE) =3D=3D NULL) {
+			g_isi_pipe_handle_error_wg25(pipe,
+						     PN_PIPE_ERR_GENERAL);
+			return FALSE;
+		}
+
+		if (g_isi_request_make(pipe->client, &msg, sizeof(msg), 0,
+					NULL, pipe) =3D=3D NULL) {
+			g_isi_pipe_handle_error_wg25(pipe,
+						     PN_PIPE_ERR_GENERAL);
+			return FALSE;
+		}
+
+		if (pipe->enabling)
+			g_isi_pipe_start_wg25(pipe);
+
+		if (pipe->handler) {
+			pipe->handler(pipe);
+			pipe->handler =3D NULL;
+		}
+	} else
+		DBG("Error from PEP");
+
+	g_isi_pipe_handle_error_wg25(pipe, resp[2]);
+	return TRUE;
+}
+
+GIsiRequest *g_isi_send_pep_connect_req(GIsiPipe_wg25 *pipe,
+					uint8_t p_handle, int phase);
+
+static gboolean g_isi_pipe_created_phase1(GIsiClient *client,
+		const void *restrict data, size_t len,
+		uint16_t object, void *opaque)
+{
+	GIsiPipe_wg25 *pipe =3D opaque;
+	const unsigned char *resp =3D data;
+
+	if (len < 7 || resp[0] !=3D PNS_PEP_CONNECT_RESP)
+		return FALSE;
+
+	if (!g_isi_pipe_error_wg25(resp[2]) &&
+		(resp[1] !=3D PN_PIPE_INVALID_HANDLE) &&
+		(resp[2] =3D=3D PN_PIPE_NO_ERROR)) {
+
+		if (pipe->client =3D=3D NULL ||
+			g_isi_send_pep_connect_req(pipe,
+					       g_isi_pipe_get_handle_wg25(pipe),
+					       2) =3D=3D NULL) {
+			g_isi_pipe_handle_error_wg25(pipe,
+						     PN_PIPE_ERR_GENERAL);
+			return FALSE;
+		}
+	} else
+		DBG("Error from PEP");
+
+	g_isi_pipe_handle_error_wg25(pipe, resp[2]);
+	return TRUE;
+}
+
+GIsiRequest *g_isi_send_pep_connect_req(GIsiPipe_wg25 *pipe, uint8_t p_han=
dle,
+					int phase)
+{
+	isi_pep_connect_req_t msg =3D {
+		.cmd =3D PNS_PEP_CONNECT_REQ,
+		.pipe_handle =3D p_handle,
+		.state_after =3D PN_PIPE_DISABLE,
+		.other_pep_type =3D PN_PEP_TYPE_COMMON,
+		.filler1 =3D 0x00,
+		.filler2 =3D 0x00,
+		.n_sb =3D 0x00,
+	};
+
+	switch (phase) {
+	case 1:
+		return g_isi_send_phonet(pipe->client, &msg,
+					 sizeof(msg), 3,
+					 g_isi_pipe_created_phase1,
+					 pipe, NULL, TRUE);
+		break;
+	case 2:
+		return g_isi_request_make(pipe->client, &msg,
+						sizeof(msg), 3,
+						g_isi_pipe_created_phase2,
+						pipe);
+		break;
+	default:
+		return NULL;
+	}
+}
+
+/**
+ * Create a Phonet pipe in disabled state.
+ * @param modem ISI modem to create a pipe with
+ * @param created optional callback for created event
+ * @return a pipe object on success, NULL on error.
+ */
+GIsiPipe_wg25 *g_isi_pipe_create_wg25(GIsiModem *modem,
+					void (*created)(GIsiPipe_wg25 *))
+{
+	GIsiPipe_wg25 *pipe =3D g_try_malloc(sizeof(GIsiPipe_wg25));
+
+	if (pipe =3D=3D NULL)
+		return NULL;
+
+	pipe->client =3D g_isi_client_create(modem, PN_PIPE);
+	pipe->handler =3D created;
+	pipe->error_handler =3D NULL;
+	pipe->error =3D 0;
+	pipe->enabling =3D FALSE;
+	pipe->enabled =3D FALSE;
+	pipe->handle =3D g_isi_get_pipe_handle_wg25();
+
+	if (pipe->client =3D=3D NULL ||
+		g_isi_send_pep_connect_req(pipe,
+					       pipe->handle,
+					       1) =3D=3D NULL) {
+		goto error;
+	}
+
+	return pipe;
+error:
+
+	if (pipe->client)
+		g_isi_client_destroy(pipe->client);
+
+	g_free(pipe);
+	return NULL;
+}
+
+static const isi_pep_resp_t *g_isi_pipe_check_pep_resp(
+		const GIsiPipe_wg25 *pipe, uint8_t cmd,
+		const void *restrict data, size_t len)
+{
+	const isi_pep_resp_t *resp =3D data;
+
+	if ((len < 3) || (resp->cmd !=3D cmd) ||
+		(resp->pipe_handle !=3D pipe->handle)) {
+		DBG("NO RESP");
+		return NULL;
+	}
+
+	return resp;
+}
+
+static gboolean g_isi_pipe_enabled_phase2(GIsiClient *client,
+		const void *restrict data, size_t len,
+		uint16_t object, void *opaque)
+{
+	GIsiPipe_wg25 *pipe =3D opaque;
+	const isi_pep_resp_t *resp;
+
+	resp =3D g_isi_pipe_check_pep_resp(pipe, PNS_PEP_ENABLE_RESP,
+					 data, len);
+
+	if (!resp)
+		return FALSE;
+
+	if (!g_isi_pipe_error_wg25(resp->error_code) &&
+		(resp->pipe_handle !=3D PN_PIPE_INVALID_HANDLE) &&
+		(resp->pipe_handle =3D=3D pipe->handle)) {
+		isi_pipe_enabled_ind_t msg =3D {
+			.cmd =3D PNS_PIPE_ENABLED_IND,
+			.pipe_handle =3D pipe->handle,
+			.filler =3D 0x00,
+		};
+
+		if (g_isi_request_make(pipe->client, &msg, sizeof(msg), 0,
+				       NULL, pipe) =3D=3D NULL) {
+			g_isi_pipe_handle_error_wg25(pipe,
+						     PN_PIPE_ERR_GENERAL);
+			return FALSE;
+		}
+
+		if (g_isi_send_phonet(pipe->client,
+				      &msg, sizeof(msg), 0, NULL, pipe,
+				      NULL, TRUE) =3D=3D NULL) {
+			g_isi_pipe_handle_error_wg25(pipe,
+						     PN_PIPE_ERR_GENERAL);
+			return FALSE;
+		}
+	} else
+		DBG("Error from PEP");
+
+	g_isi_pipe_handle_error_wg25(pipe, resp->error_code);
+	pipe->enabling =3D FALSE;
+
+	if (!pipe->error)
+		pipe->enabled =3D TRUE;
+
+	return TRUE;
+}
+
+static gboolean g_isi_pipe_enabled_phase1(GIsiClient *client,
+		const void *restrict data, size_t len,
+		uint16_t object, void *opaque)
+{
+	GIsiPipe_wg25 *pipe =3D opaque;
+	const isi_pep_resp_t *resp;
+	isi_pep_enable_req_t msg =3D {
+		.cmd =3D PNS_PEP_ENABLE_REQ,
+		.pipe_handle =3D pipe->handle,
+		.filler =3D 0x00,
+	};
+
+	resp =3D g_isi_pipe_check_pep_resp(pipe, PNS_PEP_ENABLE_RESP,
+					 data, len);
+
+	if (!resp)
+		return FALSE;
+
+	if (!g_isi_pipe_error_wg25(resp->error_code) &&
+		(resp->pipe_handle !=3D PN_PIPE_INVALID_HANDLE) &&
+		(resp->pipe_handle =3D=3D pipe->handle)) {
+
+		if (g_isi_send_phonet(pipe->client, &msg, sizeof(msg),
+			       5, g_isi_pipe_enabled_phase2,
+			       pipe, NULL, TRUE) =3D=3D NULL)
+			return FALSE;
+	} else
+		DBG("Error from PEP");
+
+	g_isi_pipe_handle_error_wg25(pipe, resp->error_code);
+	return TRUE;
+}
+
+static GIsiRequest *g_isi_pipe_enable_wg25(GIsiPipe_wg25 *pipe)
+{
+	GIsiRequest *req;
+	isi_pep_enable_req_t msg =3D {
+		.cmd =3D PNS_PEP_ENABLE_REQ,
+		.pipe_handle =3D pipe->handle,
+		.filler =3D 0x00,
+	};
+
+	req =3D g_isi_request_make(pipe->client, &msg, sizeof(msg), 5,
+				 g_isi_pipe_enabled_phase1, pipe);
+
+	if (req =3D=3D NULL)
+		DBG("NO MESSAGE SENDING");
+	else
+		DBG("EXIT OK");
+
+	return req;
+}
+
+/**
+ * Enable a pipe, i.e. turn on data transfer between the two end points.
+ * @param pipe pipe as returned from g_isi_pipe_create()
+ * @return 0 on success or an error code
+ */
+int g_isi_pipe_start_wg25(GIsiPipe_wg25 *pipe)
+{
+	if (pipe->error)
+		return pipe->error;
+
+	if (pipe->enabling || pipe->enabled)
+		return 0;
+
+	if (pipe->handle !=3D PN_PIPE_INVALID_HANDLE)
+		g_isi_pipe_enable_wg25(pipe);
+	else
+		pipe->enabling =3D TRUE;
+
+	return 0;
+}
+
+static gboolean g_isi_pipe_removed_phase2(GIsiClient *client,
+		const void *restrict data, size_t len,
+		uint16_t object, void *opaque)
+{
+	GIsiPipe_wg25 *pipe =3D opaque;
+	const isi_pep_resp_t *resp;
+	resp =3D g_isi_pipe_check_pep_resp(pipe, PNS_PEP_DISCONNECT_RESP,
+					data, len);
+
+	if (!resp)
+		return FALSE;
+
+	pipe->handle =3D PN_PIPE_INVALID_HANDLE;
+	return TRUE;
+}
+
+static gboolean g_isi_pipe_removed_phase1(GIsiClient *client,
+		const void *restrict data, size_t len,
+		uint16_t object, void *opaque)
+{
+	GIsiPipe_wg25 *pipe =3D opaque;
+	const isi_pep_resp_t *resp;
+	isi_pep_disconnect_req_t msg =3D {
+		.cmd =3D PNS_PEP_DISCONNECT_REQ,
+		.pipe_handle =3D pipe->handle,
+		.filler =3D 0x00,
+	};
+	resp =3D g_isi_pipe_check_pep_resp(pipe, PNS_PEP_DISCONNECT_RESP,
+					 data, len);
+
+	if (!resp)
+		return FALSE;
+
+	if (g_isi_request_make(pipe->client, &msg, sizeof(msg), 5,
+			       g_isi_pipe_removed_phase2, pipe) =3D=3D NULL)
+		return FALSE;
+	return TRUE;
+}
+
+GIsiRequest *g_isi_pipe_remove_wg25(GIsiPipe_wg25 *pipe)
+{
+	GIsiRequest *req;
+	isi_pep_disconnect_req_t msg =3D {
+		.cmd =3D PNS_PEP_DISCONNECT_REQ,
+		.pipe_handle =3D pipe->handle,
+		.filler =3D 0x00,
+	};
+
+	if (pipe->error !=3D -EPIPE) {
+		req =3D g_isi_send_phonet(pipe->client, &msg,
+					sizeof(msg), 5,
+					g_isi_pipe_removed_phase1,
+					pipe, NULL, TRUE);
+	} else
+		req =3D NULL;
+
+	if (req =3D=3D NULL)
+		DBG("NO MESSAGE SENDING");
+	else {
+		pipe->error =3D -EPIPE;
+		DBG("EXIT OK");
+	}
+
+	return req;
+}
+
+/**
+ * Destroy a pipe. If it was connected, it is removed.
+ * @param pipe pipe as returned from g_isi_pipe_create()
+ */
+void g_isi_pipe_destroy_wg25(GIsiPipe_wg25 *pipe)
+{
+	if (!pipe->error)
+		g_isi_pipe_remove_wg25(pipe);
+	else {
+		g_isi_client_destroy(pipe->client);
+		g_free(pipe);
+	}
+
+}
+
+void g_isi_pipe_set_error_handler_wg25(GIsiPipe_wg25 *pipe,
+					void (*cb)(GIsiPipe_wg25 *))
+{
+	pipe->error_handler =3D cb;
+}
+
+int g_isi_pipe_get_error_wg25(const GIsiPipe_wg25 *pipe)
+{
+	return pipe->error;
+}
+
+void *g_isi_pipe_set_userdata_wg25(GIsiPipe_wg25 *pipe, void *opaque)
+{
+	void *old =3D pipe->opaque;
+
+	pipe->opaque =3D opaque;
+	return old;
+}
+
+void *g_isi_pipe_get_userdata_wg25(GIsiPipe_wg25 *pipe)
+{
+	return pipe->opaque;
+}
+
+/**
+ * Return a pipe handle.
+ * @param pipe a ready-made pipe with handler data present. Available
+ * after the pipe creation callback is called.
+ * @return uint8_t handle.
+ */
+uint8_t g_isi_pipe_get_handle_wg25(GIsiPipe_wg25 *pipe)
+{
+	DBG(" %d", pipe->handle);
+	return pipe->handle;
+}
diff --git a/gisi/pipe_wg25.h b/gisi/pipe_wg25.h
new file mode 100644
index 0000000..e788ab2
--- /dev/null
+++ b/gisi/pipe_wg25.h
@@ -0,0 +1,97 @@
+/*
+ * This file is part of oFono - Open Source Telephony
+ *
+ * Copyright (C) 2009 Nokia Corporation and/or its subsidiary(-ies).
+ * Copyright (C) ST-Ericsson SA 2010.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ *
+ */
+#ifndef __PIPE_WG25_H
+#define __PIPE_WG25_H
+
+#include "client.h"
+
+#define PN_PIPE					0xD9
+
+#define PN_PIPE_INVALID_HANDLE			0xFF
+
+#define PN_PIPE_NO_ERROR			0x00
+#define PN_PIPE_ERR_INVALID_PARAM		0x01
+#define PN_PIPE_ERR_INVALID_HANDLE		0x02
+#define PN_PIPE_ERR_INVALID_CTRL_ID		0x03
+#define PN_PIPE_ERR_NOT_ALLOWED			0x04
+#define PN_PIPE_ERR_PEP_IN_USE			0x05
+#define PN_PIPE_ERR_OVERLOAD			0x06
+#define PN_PIPE_ERR_DEV_DISCONNECTED		0x07
+#define PN_PIPE_ERR_TIMEOUT			0x08
+#define PN_PIPE_ERR_ALL_PIPES_IN_USE		0x09
+#define PN_PIPE_ERR_GENERAL			0x0A
+#define PN_PIPE_ERR_ALIGN_NOT_SUPPORTED		0x0B
+#define PN_PIPE_ERR_NOT_SUPPORTED		0x0C	/* Not supported. */
+
+#define PN_OBJ_PEP_GPRS				0x30
+
+/* Message ID's */
+#define PNS_PEP_CONNECT_REQ			0x40
+#define PNS_PEP_CONNECT_RESP			0x41
+#define PNS_PEP_DISCONNECT_REQ			0x42
+#define PNS_PEP_DISCONNECT_RESP			0x43
+#define PNS_PEP_ENABLE_REQ			0x46
+#define PNS_PEP_ENABLE_RESP			0x47
+#define PNS_PIPE_CREATED_IND			0x61
+#define PNS_PIPE_ENABLED_IND			0x64
+
+/* Subblock ID's */
+#define PN_PIPE_SB_NEGOTIATED_FC		0x03
+#define PN_PIPE_SB_ALIGNED_DATA			0x06
+
+/* State of Pipe */
+#define PN_PIPE_DISABLE				0x00
+#define PN_PIPE_ENABLE				0x01
+
+/* PEP type */
+#define PN_PEP_TYPE_COMMON			0x00
+
+/* Data alignment types */
+#define PN_NORMAL_DATA_MSG			0x00
+#define PN_ALIGNED_DATA_MSG			0x01
+
+/* Flow Control types */
+#define PN_NO_FLOW_CONTROL			0x00
+#define PN_LEGACY_FLOW_CONTROL			0x01
+#define PN_ONE_CREDIT_FLOW_CONTROL		0x02
+#define PN_MULTI_CREDIT_FLOW_CONTROL		0x03
+
+typedef struct _GIsiPipe_wg25 GIsiPipe_wg25;
+
+GIsiPipe_wg25 *g_isi_pipe_create_wg25(GIsiModem *,
+				void (*cb)(GIsiPipe_wg25 *));
+
+GIsiRequest *g_isi_pipe_remove_wg25(GIsiPipe_wg25 *pipe);
+
+void g_isi_pipe_destroy_wg25(GIsiPipe_wg25 *pipe);
+int g_isi_pipe_start_wg25(GIsiPipe_wg25 *pipe);
+
+void g_isi_pipe_set_error_handler_wg25(GIsiPipe_wg25 *pipe,
+				void (*cb)(GIsiPipe_wg25 *));
+int g_isi_pipe_get_error_wg25(const GIsiPipe_wg25 *pipe);
+void *g_isi_pipe_set_userdata_wg25(GIsiPipe_wg25 *pipe, void *data);
+void *g_isi_pipe_get_userdata_wg25(GIsiPipe_wg25 *pipe);
+uint8_t g_isi_pipe_get_handle_wg25(GIsiPipe_wg25 *pipe);
+uint8_t g_isi_get_new_pipe_handle_wg25();
+uint8_t g_isi_get_pipe_handle_wg25();
+void g_isi_pipe_init_wg25();
+#endif
diff --git a/gisi/server.c b/gisi/server.c
index 3d96e2d..2f7e8d7 100644
--- a/gisi/server.c
+++ b/gisi/server.c
@@ -237,6 +237,7 @@ int g_isi_vrespond(GIsiServer *self, const struct iovec=
 *iov, size_t iovlen,
 =

 	_iov[0].iov_base =3D &irq->trans_id;
 	_iov[0].iov_len =3D 1;
+
 	for (i =3D 0, len =3D 1; i < iovlen; i++) {
 		_iov[1 + i] =3D iov[i];
 		len +=3D iov[i].iov_len;
@@ -285,8 +286,8 @@ void g_isi_server_unhandle(GIsiServer *self, uint8_t ty=
pe)
 =

 =

 static void generic_error_response(GIsiServer *self,
-			uint8_t trans_id, uint8_t error, uint8_t message_id,
-			void *addr, socklen_t addrlen)
+					uint8_t trans_id, uint8_t error, uint8_t message_id,
+					void *addr, socklen_t addrlen)
 {
 	uint8_t common[] =3D { trans_id, 0xF0, error, message_id };
 =

@@ -334,7 +335,7 @@ static void process_message(GIsiServer *self, int len)
 static gboolean g_isi_server_callback(GIOChannel *channel, GIOCondition co=
nd,
 					gpointer opaque)
 {
-	if (cond & (G_IO_NVAL|G_IO_HUP)) {
+	if (cond & (G_IO_NVAL | G_IO_HUP)) {
 		g_warning("Unexpected event on Phonet channel %p", channel);
 		return FALSE;
 	}
diff --git a/gisi/socket.c b/gisi/socket.c
index 4eb8b77..2f4fe83 100644
--- a/gisi/socket.c
+++ b/gisi/socket.c
@@ -35,28 +35,43 @@
 #include <glib.h>
 =

 #include "socket.h"
-
+#ifdef STE_U8500_PHONET
+#include "pipe_wg25.h"
+#endif
 GIOChannel *phonet_new(GIsiModem *modem, uint8_t resource)
 {
 	GIOChannel *channel;
 	struct sockaddr_pn addr =3D {
 		.spn_family =3D AF_PHONET,
 		.spn_resource =3D resource,
+#ifdef STE_U8500_PHONET
+		.spn_obj =3D 0x00,
+		.spn_dev =3D 0x00,
+#endif
 	};
+
 	unsigned ifi =3D g_isi_modem_index(modem);
 	char buf[IF_NAMESIZE];
 =

 	int fd =3D socket(PF_PHONET, SOCK_DGRAM, 0);
+
+#ifdef STE_U8500_PHONET
+	if (resource =3D=3D PN_PIPE)
+		addr.spn_obj =3D PN_OBJ_PEP_GPRS;
+#endif
+
 	if (fd =3D=3D -1)
 		return NULL;
+
 	fcntl(fd, F_SETFD, FD_CLOEXEC);
 	/* Use blocking mode on purpose. */
 =

 	if (ifi =3D=3D 0)
 		g_warning("Unspecified GIsiModem!");
 	else if (if_indextoname(ifi, buf) =3D=3D NULL ||
-		setsockopt(fd, SOL_SOCKET, SO_BINDTODEVICE, buf, IF_NAMESIZE))
+			setsockopt(fd, SOL_SOCKET, SO_BINDTODEVICE, buf, IF_NAMESIZE))
 		goto error;
+
 	if (bind(fd, (void *)&addr, sizeof(addr)))
 		goto error;
 =

@@ -86,12 +101,15 @@ ssize_t phonet_read(GIOChannel *channel, void *restric=
t buf, size_t len,
 =

 	ret =3D recvfrom(g_io_channel_unix_get_fd(channel), buf, len,
 			MSG_DONTWAIT, (void *)&addr, &addrlen);
+
 	if (ret =3D=3D -1)
 		return -1;
 =

 	if (obj !=3D NULL)
 		*obj =3D (addr.spn_dev << 8) | addr.spn_obj;
+
 	if (res !=3D NULL)
 		*res =3D addr.spn_resource;
+
 	return ret;
 }
diff --git a/gisi/verify.c b/gisi/verify.c
index cb669f9..db5ae2b 100644
--- a/gisi/verify.c
+++ b/gisi/verify.c
@@ -43,6 +43,15 @@ struct verify_data {
 	uint8_t resource;
 };
 =

+#ifdef STE_U8500_PHONET
+static gboolean phonet_link =3D FALSE;
+
+void verify_link_up(gboolean link)
+{
+	phonet_link =3D link;
+}
+#endif
+
 static GIsiRequest *send_version_query(GIsiClient *client, GIsiResponseFun=
c cb,
 					void *opaque)
 {
@@ -74,6 +83,11 @@ static gboolean verify_cb(GIsiClient *client, const void=
 *restrict data,
 =

 	if (!msg) {
 =

+#ifdef STE_U8500_PHONET
+		if (!phonet_link)
+			return FALSE;
+#endif
+
 		if (++vd->count < VERSION_RETRIES) {
 =

 			g_warning("Retry COMM_ISI_VERSION_GET_REQ");
-- =

1.7.3.2


--===============6722561090147549771==--

