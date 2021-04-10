Content-Type: multipart/mixed; boundary="===============5892592246391341855=="
MIME-Version: 1.0
From: Chris Talbot <chris@talbothome.com>
Subject: [PATCH 1/9] Fix mmsd to work with T-mobile
Date: Sat, 10 Apr 2021 10:17:25 -0400
Message-ID: <b23ba0656ea0d58fdbd8c83072e017f63629f934.camel@talbothome.com>
In-Reply-To: <051ae8ae27f5288d64ec6ef2bd9f77c06b829b52.camel@talbothome.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5892592246391341855==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch is a squashed version of a series of patches here:

https://git.sr.ht/~anteater/mmsd

It also includes some fixes to a few hacks in the code. Rather than
submit two patches that need to go together, I just squashed it into
one commit.
---
 Makefile.am       |   3 +-
 gweb/gresolv.c    |  73 ++++++++++++++-
 gweb/gweb.c       |   1 +
 plugins/ofono.c   |  11 ++-
 src/mmsutil.c     | 233 ++++++++++++++++++++++++++++++++++++++--------
 src/mmsutil.h     |  17 ++++
 src/service.c     |  58 ++++++++++--
 test/send-message |  24 ++---
 8 files changed, 356 insertions(+), 64 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index ee2c715..99fdb76 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -88,7 +88,8 @@ unit_test_wsputil_SOURCES =3D unit/test-wsputil.c
src/wsputil.c src/wsputil.h
 unit_test_wsputil_LDADD =3D @GLIB_LIBS@
 =

 unit_test_mmsutil_SOURCES =3D unit/test-mmsutil.c src/mmsutil.c
src/mmsutil.h \
-						src/wsputil.c
src/wsputil.h
+						src/wsputil.c
src/wsputil.h \
+						src/log.c src/log.h
 unit_test_mmsutil_LDADD =3D @GLIB_LIBS@
 =

 TESTS =3D unit/test-wsputil unit/test-mmsutil
diff --git a/gweb/gresolv.c b/gweb/gresolv.c
index 79abc9b..bb1c32d 100644
--- a/gweb/gresolv.c
+++ b/gweb/gresolv.c
@@ -35,6 +35,7 @@
 #include <arpa/inet.h>
 #include <arpa/nameser.h>
 #include <net/if.h>
+#include <ifaddrs.h>
 =

 #include "gresolv.h"
 =

@@ -764,13 +765,15 @@ static int connect_udp_channel(struct
resolv_nameserver *nameserver)
 		return -EINVAL;
 =

 	sk =3D socket(rp->ai_family, rp->ai_socktype, rp->ai_protocol);
+	const int so_reuseaddr =3D 1;
+	setsockopt(sk, SOL_SOCKET, SO_REUSEADDR, &so_reuseaddr, sizeof
so_reuseaddr);
 	if (sk < 0) {
 		freeaddrinfo(rp);
 		return -EIO;
 	}
 =

 	/*
-	 * If nameserver points to localhost ip, their is no need to
+	 * If nameserver points to localhost ip, there is no need to
 	 * bind the socket on any interface.
 	 */
 	if (nameserver->resolv->index > 0 &&
@@ -780,12 +783,63 @@ static int connect_udp_channel(struct
resolv_nameserver *nameserver)
 		memset(interface, 0, IF_NAMESIZE);
 		if (if_indextoname(nameserver->resolv->index,
 						interface) !=3D NULL) {
-			if (setsockopt(sk, SOL_SOCKET,
SO_BINDTODEVICE,
-						interface,
IF_NAMESIZE) < 0) {
+			/* set up bind address */
+			struct sockaddr_storage bind_addr;
+			int addr_size =3D 0;
+			memset(&bind_addr, 0, sizeof(bind_addr));
+			bind_addr.ss_family =3D rp->ai_family;
+
+			struct ifaddrs *ifa, *ifa_tmp;
+			if (getifaddrs(&ifa) =3D=3D -1) {
+				perror("getifaddrs failed");
+				return -errno;
+			}
+			ifa_tmp =3D ifa;
+			while (ifa_tmp) {
+				if (!strcmp(ifa_tmp->ifa_name,
interface) && =

+						ifa_tmp->ifa_addr) {
+					if (ifa_tmp->ifa_addr-
>sa_family !=3D rp->ai_family) {
+						printf("fam %d !=3D
expected %d\n", ifa_tmp->ifa_addr->sa_family, rp->ai_family);
+						ifa_tmp =3D ifa_tmp-
>ifa_next;
+						continue;
+					}
+					if (ifa_tmp->ifa_addr-
>sa_family =3D=3D AF_INET) {
+						struct sockaddr_in
*bind_addr4 =3D (struct sockaddr_in *)&bind_addr;
+						bind_addr4-
>sin_addr.s_addr =3D ((struct sockaddr_in *)ifa_tmp->ifa_addr)-
>sin_addr.s_addr;
+						bind_addr4->sin_port =3D
53;
+						printf("addr =3D %s\n",
inet_ntoa(bind_addr4->sin_addr));
+						addr_size =3D
sizeof(*bind_addr4);
+					} else if (ifa_tmp->ifa_addr-
>sa_family =3D=3D AF_INET6) {
+						struct sockaddr_in6
*bind_addr6 =3D (struct sockaddr_in6 *)&bind_addr;
+						bind_addr6->sin6_addr
=3D ((struct sockaddr_in6 *)ifa_tmp->ifa_addr)->sin6_addr;
+						bind_addr6->sin6_port
=3D 53;
+						char buf[64];
+						inet_ntop(AF_INET6,
bind_addr6->sin6_addr.s6_addr, buf, 64);
+						printf("addr =3D %s\n",
buf);
+						addr_size =3D
sizeof(*bind_addr6);
+					} else {
+						printf("unknown
fam\n");
+					}
+					break;
+				}
+				ifa_tmp =3D ifa_tmp->ifa_next;
+			}
+
+/*			if (bind_addr. && bind_addr.sin_addr.s_addr =3D=3D
0) {
+				printf("interface not found\n");
+			}
+
+			if (bind_addr.sin6_addr.s_addr =3D=3D 0) {
+				printf("interface6 not found\n");
+			}*/
+
+			if (bind(sk, (struct sockaddr *)&bind_addr,
addr_size) < 0) {
+				perror("bind failed");
 				close(sk);
 				freeaddrinfo(rp);
 				return -EIO;
 			}
+			freeifaddrs(ifa);
 		}
 	}
 =

@@ -896,6 +950,7 @@ void g_resolv_set_debug(GResolv *resolv,
GResolvDebugFunc func,
 gboolean g_resolv_add_nameserver(GResolv *resolv, const char *address,
 					uint16_t port, unsigned long
flags)
 {
+	printf ("adding nameserver %s\n", address);
 	struct resolv_nameserver *nameserver;
 =

 	if (resolv =3D=3D NULL)
@@ -911,6 +966,7 @@ gboolean g_resolv_add_nameserver(GResolv *resolv,
const char *address,
 	nameserver->resolv =3D resolv;
 =

 	if (connect_udp_channel(nameserver) < 0) {
+		printf ("connect_udp_channel failed!\n");
 		free_nameserver(nameserver);
 		return FALSE;
 	}
@@ -977,6 +1033,9 @@ guint g_resolv_lookup_hostname(GResolv *resolv,
const char *hostname,
 =

 	if (resolv->nameserver_list =3D=3D NULL) {
 		int i;
+		printf("g_resolv_lookup_hostname: nameserver_list
NULL\n");
+
+		printf("g_resolv_lookup_hostname: nscount=3D%d\n",
resolv->res.nscount);
 =

 		for (i =3D 0; i < resolv->res.nscount; i++) {
 			char buf[100];
@@ -989,15 +1048,19 @@ guint g_resolv_lookup_hostname(GResolv *resolv,
const char *hostname,
 				sa_addr =3D &resolv-
>res._u._ext.nsaddrs[i]->sin6_addr;
 			}
 =

-			if (family !=3D AF_INET && family !=3D AF_INET6)
+			if (family !=3D AF_INET && family !=3D AF_INET6) {
+				printf("g_resolv_lookup_hostname:
skipping b/c family=3D%d\n", family);
 				continue;
+			}
 =

 			if (inet_ntop(family, sa_addr, buf,
sizeof(buf)))
 				g_resolv_add_nameserver(resolv, buf,
53, 0);
 		}
 =

-		if (resolv->nameserver_list =3D=3D NULL)
+		if (resolv->nameserver_list =3D=3D NULL) {
+			printf("g_resolv_lookup_hostname:
nameserver_list *still* NULL\n");
 			g_resolv_add_nameserver(resolv, "127.0.0.1",
53, 0);
+		}
 	}
 =

 	lookup =3D g_try_new0(struct resolv_lookup, 1);
diff --git a/gweb/gweb.c b/gweb/gweb.c
index 4c2f95c..f72e137 100644
--- a/gweb/gweb.c
+++ b/gweb/gweb.c
@@ -1008,6 +1008,7 @@ static inline int bind_socket(int sk, int index,
int family)
 	if (if_indextoname(index, interface) =3D=3D NULL)
 		return -1;
 =

+	printf("binding %s\n", interface);
 	err =3D setsockopt(sk, SOL_SOCKET, SO_BINDTODEVICE,
 					interface, IF_NAMESIZE);
 	if (err < 0)
diff --git a/plugins/ofono.c b/plugins/ofono.c
index e7324a7..24a147a 100644
--- a/plugins/ofono.c
+++ b/plugins/ofono.c
@@ -396,11 +396,14 @@ static void check_context_active(struct
modem_data *modem,
 		g_free(modem->context_proxy);
 		modem->context_proxy =3D NULL;
 =

+		DBG("context_active =3D false");
 		mms_service_bearer_notify(modem->service, FALSE, NULL,
NULL);
-	} else if (modem->context_proxy !=3D NULL)
+	} else if (modem->context_proxy !=3D NULL) {
+		DBG("nonnull proxy");
 		mms_service_bearer_notify(modem->service, TRUE,
 						modem-
>context_interface,
 						modem->context_proxy);
+	}
 }
 =

 static void check_context_settings(struct modem_data *modem,
@@ -452,6 +455,7 @@ static void check_context_settings(struct
modem_data *modem,
 	if (modem->context_active =3D=3D FALSE)
 		return;
 =

+	DBG("about to bearer_notify");
 	mms_service_bearer_notify(modem->service, TRUE,
 					modem->context_interface,
 					modem->context_proxy);
@@ -692,6 +696,7 @@ static void set_context_reply(DBusPendingCall
*call, void *user_data)
 	dbus_error_init(&err);
 =

 	if (dbus_set_error_from_message(&err, reply) =3D=3D TRUE) {
+		DBG("set_ctx reply failure (%s: %s), about to
bearer_notify", err.name, err.message);
 		dbus_error_free(&err);
 		mms_service_bearer_notify(modem->service, FALSE, NULL,
NULL);
 	}
@@ -739,15 +744,17 @@ static void bearer_handler(mms_bool_t active,
void *user_data)
 {
 	struct modem_data *modem =3D user_data;
 =

-	DBG("path %s active %d", modem->path, active);
+	DBG("path %s active %d context_active %d", modem->path,
active, modem->context_active);
 =

 	if (active =3D=3D TRUE && modem->context_active =3D=3D TRUE) {
+		DBG("active and context_active, bearer_notify");
 		mms_service_bearer_notify(modem->service, TRUE,
 						modem-
>context_interface,
 						modem->context_proxy);
 		return;
 	}
 =

+	DBG("checking for failure");
 	if (active =3D=3D FALSE && modem->context_active =3D=3D FALSE) {
 		mms_service_bearer_notify(modem->service, FALSE, NULL,
NULL);
 		return;
diff --git a/src/mmsutil.c b/src/mmsutil.c
index a9a12eb..5fcf358 100644
--- a/src/mmsutil.c
+++ b/src/mmsutil.c
@@ -32,6 +32,7 @@
 =

 #include "wsputil.h"
 #include "mmsutil.h"
+#include "mms.h"
 =

 #define MAX_ENC_VALUE_BYTES 6
 =

@@ -75,7 +76,11 @@ enum mms_header {
 	MMS_HEADER_SUBJECT =3D			0x16,
 	MMS_HEADER_TO =3D				0x17,
 	MMS_HEADER_TRANSACTION_ID =3D		0x18,
-	__MMS_HEADER_MAX =3D			0x19,
+	MMS_HEADER_RETRIEVE_STATUS =3D		0x19,
+	MMS_HEADER_RETRIEVE_TEXT =3D		0x20,
+	MMS_HEADER_READ_STATUS =3D		0x21,
+	MMS_HEADER_LAST_HANDLED =3D		0x21,
+	__MMS_HEADER_MAX =3D			0x22,
 	MMS_HEADER_INVALID =3D			0x80,
 };
 =

@@ -159,13 +164,18 @@ static gboolean extract_short(struct
wsp_header_iter *iter, void *user)
 static const char *decode_text(struct wsp_header_iter *iter)
 {
 	const unsigned char *p;
-	unsigned int l;
+	unsigned int l=3D32;
 =

-	if (wsp_header_iter_get_val_type(iter) !=3D WSP_VALUE_TYPE_TEXT)
+	if (wsp_header_iter_get_val_type(iter) !=3D WSP_VALUE_TYPE_TEXT)
{
+		p =3D wsp_header_iter_get_val(iter);
+		DBG("could not decode text of (dummy) length %u: %*s",
l-1, l-1, p+1);
 		return NULL;
+	}
 =

 	p =3D wsp_header_iter_get_val(iter);
 	l =3D wsp_header_iter_get_val_len(iter);
+	DBG("claimed len: %u", l);
+	DBG("val: %*s", l - 1, p);
 =

 	return wsp_decode_text(p, l, NULL);
 }
@@ -184,31 +194,14 @@ static gboolean extract_text(struct
wsp_header_iter *iter, void *user)
 	return TRUE;
 }
 =

-static gboolean extract_text_array_element(struct wsp_header_iter
*iter,
-						void *user)
-{
-	char **out =3D user;
-	const char *element;
-	char *tmp;
-
-	element =3D decode_text(iter);
-	if (element =3D=3D NULL)
-		return FALSE;
-
-	if (*out =3D=3D NULL) {
-		*out =3D g_strdup(element);
-		return TRUE;
-	}
-
-	tmp =3D g_strjoin(",", *out, element, NULL);
-	if (tmp =3D=3D NULL)
-		return FALSE;
-
-	g_free(*out);
-
-	*out =3D tmp;
-
-	return TRUE;
+static char* remove_address_type_suffix(const char* addr, size_t len)
{
+	return g_strdup(addr);
+/*	#define MMS_ADDR_SUFFIX_PUBLIC_LAND_MOBILE_NUMBER "/TYPE=3DPLMN"
+	if(g_str_has_suffix(addr,
MMS_ADDR_SUFFIX_PUBLIC_LAND_MOBILE_NUMBER)) {
+		return g_strndup(addr, len -
strlen(MMS_ADDR_SUFFIX_PUBLIC_LAND_MOBILE_NUMBER));
+	} else {
+		return g_strdup(addr);
+	}*/
 }
 =

 static char *decode_encoded_string_with_mib_enum(const unsigned char
*p,
@@ -242,6 +235,57 @@ static char
*decode_encoded_string_with_mib_enum(const unsigned char *p,
 			&bytes_read, &bytes_written, NULL);
 }
 =

+static gboolean extract_text_array_element(struct wsp_header_iter
*iter,
+						void *user)
+{
+	char **out =3D user;
+	const char *element =3D NULL;
+	char *tmp;
+	DBG("");
+
+	const unsigned char *p;
+	unsigned int l;
+
+	p =3D wsp_header_iter_get_val(iter);
+	l =3D wsp_header_iter_get_val_len(iter);
+
+	switch (wsp_header_iter_get_val_type(iter)) {
+	case WSP_VALUE_TYPE_TEXT:
+		/* Text-string */
+		element =3D wsp_decode_text(p, l, NULL);
+		break;
+	case WSP_VALUE_TYPE_LONG:
+		/* (Value-len) Char-set Text-string */
+		element =3D decode_encoded_string_with_mib_enum(p, l);
+		break;
+	case WSP_VALUE_TYPE_SHORT:
+		element =3D NULL;
+		break;
+	}
+
+	if (element =3D=3D NULL) {
+		DBG("failed, type=3D%d",
wsp_header_iter_get_val_type(iter));
+		return FALSE;
+	}
+
+	if (*out =3D=3D NULL) {
+		*out =3D g_strdup(element);
+		return TRUE;
+	}
+
+	tmp =3D g_strjoin(",", *out, element, NULL);
+	if (tmp =3D=3D NULL) {
+		DBG("join failed");
+		return FALSE;
+	}
+
+	g_free(*out);
+
+	*out =3D tmp;
+
+	return TRUE;
+}
+
 static gboolean extract_encoded_text(struct wsp_header_iter *iter,
void *user)
 {
 	char **out =3D user;
@@ -361,26 +405,62 @@ static gboolean extract_from(struct
wsp_header_iter *iter, void *user)
 	const unsigned char *p;
 	unsigned int l;
 	const char *text;
+	unsigned char char_set =3D 0;
 =

-	if (wsp_header_iter_get_val_type(iter) !=3D WSP_VALUE_TYPE_LONG)
+	if (wsp_header_iter_get_val_type(iter) !=3D WSP_VALUE_TYPE_LONG)
{
+		DBG("val_type not LONG");
 		return FALSE;
+	}
 =

 	p =3D wsp_header_iter_get_val(iter);
 	l =3D wsp_header_iter_get_val_len(iter);
 =

-	if (p[0] !=3D 128 && p[0] !=3D 129)
+	/* From-value =3D Value-length (Address-present-token=3D128
Encoded-string-value | Insert-address-token=3D129) */
+	/* Encoded-string-value =3D Text-string | Value-length Char-set
Text-string */
+	/* Value-length =3D Short-length | (Length-quote Length) */
+	/* Short-length =3D val 0-30 */
+	/* Length-quote =3D val 31 */
+	/* Length =3D Uintvar-integer */
+
+	if (p[0] !=3D 128 && p[0] !=3D 129) {
+		DBG("not 128 or 129");
 		return FALSE;
+	}
 =

 	if (p[0] =3D=3D 129) {
 		*out =3D NULL;
 		return TRUE;
 	}
+	p +=3D 1; l -=3D 1; /* token has been handled */
+
+	unsigned int val_len =3D l;
+	unsigned int str_len;
+	if (p[0] < 31) { /*short-length */
+		val_len =3D p[0];
+		char_set =3D p[1];
+		p +=3D 2;
+		val_len -=3D 1; /* count encoding against val_len */
+	} else if (p[0] =3D=3D 31) /* length quote then long length */ {
+		unsigned int consumed =3D 0;
+		gboolean ok =3D wsp_decode_uintvar(p, l, &val_len,
&consumed);
+		if (!ok)
+			return FALSE;
+		char_set =3D p[1];
+		p +=3D consumed;
+		val_len -=3D 1; /* count encoding against val_len */
+	}
+	str_len =3D val_len - 1; /* NUL@the end is not counted by
strlen() */
+	=

+	DBG("trying to decode text of length %u: %*s", str_len,
str_len, p);
+	text =3D wsp_decode_text(p, val_len, NULL);
+	DBG("text=3D\"%s\"", text);
 =

-	text =3D wsp_decode_text(p + 1, l - 1, NULL);
-	if (text =3D=3D NULL)
+	if (text =3D=3D NULL) {
+		DBG("could not decode text of length %u: %*s",
str_len, str_len, p);
 		return FALSE;
+	}
 =

-	*out =3D g_strdup(text);
+	*out =3D remove_address_type_suffix(text, str_len);
 =

 	return TRUE;
 }
@@ -473,6 +553,50 @@ static gboolean extract_priority(struct
wsp_header_iter *iter, void *user)
 	return TRUE;
 }
 =

+static gboolean extract_read_status(struct wsp_header_iter *iter, void
*user)
+{
+	enum mms_message_read_status *out =3D user;
+	const unsigned char *p;
+
+	if (wsp_header_iter_get_val_type(iter) !=3D
WSP_VALUE_TYPE_SHORT)
+		return FALSE;
+
+	p =3D wsp_header_iter_get_val(iter);
+
+	if (p[0] =3D=3D MMS_MESSAGE_READ_STATUS_READ ||
+		p[0] =3D=3D MMS_MESSAGE_READ_STATUS_DELETED_UNREAD) {
+		*out =3D p[0];
+		return TRUE;
+	}
+
+	return FALSE;
+}
+
+static gboolean extract_retr_status(struct wsp_header_iter *iter, void
*user)
+{
+	enum mms_message_retr_status *out =3D user;
+	const unsigned char *p;
+
+	if (wsp_header_iter_get_val_type(iter) !=3D
WSP_VALUE_TYPE_SHORT)
+		return FALSE;
+
+	p =3D wsp_header_iter_get_val(iter);
+
+	switch (p[0]) {
+	case MMS_MESSAGE_RETR_STATUS_OK:
+	case MMS_MESSAGE_RETR_STATUS_ERR_TRANS_FAILURE:
+	case MMS_MESSAGE_RETR_STATUS_ERR_TRANS_MESSAGE_NOT_FOUND:
+	case MMS_MESSAGE_RETR_STATUS_ERR_PERM_FAILURE:
+	case MMS_MESSAGE_RETR_STATUS_ERR_PERM_SERVICE_DENIED:
+	case MMS_MESSAGE_RETR_STATUS_ERR_PERM_MESSAGE_NOT_FOUND:
+	case MMS_MESSAGE_RETR_STATUS_ERR_PERM_CONTENT_UNSUPPORTED:
+		*out =3D p[0];
+		return TRUE;
+	}
+
+	return FALSE;
+}
+
 static gboolean extract_rsp_status(struct wsp_header_iter *iter, void
*user)
 {
 	unsigned char *out =3D user;
@@ -559,7 +683,7 @@ static header_handler handler_for_type(enum
mms_header header)
 	case MMS_HEADER_CONTENT_LOCATION:
 		return extract_text;
 	case MMS_HEADER_CONTENT_TYPE:
-		return extract_text;
+		return extract_text; /* extract_encoded_text? */
 	case MMS_HEADER_DATE:
 		return extract_date;
 	case MMS_HEADER_DELIVERY_REPORT:
@@ -590,6 +714,12 @@ static header_handler handler_for_type(enum
mms_header header)
 		return extract_rsp_status;
 	case MMS_HEADER_RESPONSE_TEXT:
 		return extract_encoded_text;
+	case MMS_HEADER_RETRIEVE_STATUS:
+		return extract_retr_status;
+	case MMS_HEADER_RETRIEVE_TEXT:
+		return extract_encoded_text;
+	case MMS_HEADER_READ_STATUS:
+		return extract_read_status;
 	case MMS_HEADER_SENDER_VISIBILITY:
 		return extract_sender_visibility;
 	case MMS_HEADER_STATUS:
@@ -650,8 +780,12 @@ static gboolean mms_parse_headers(struct
wsp_header_iter *iter,
 		h =3D p[0] & 0x7f;
 =

 		handler =3D handler_for_type(h);
-		if (handler =3D=3D NULL)
+		if (handler =3D=3D NULL) {
+			DBG("no handler for type %u", h);
 			return FALSE;
+		}
+
+		DBG("saw header of type %u", h);
 =

 		/* Unsupported header, skip */
 		if (entries[h].data =3D=3D NULL)
@@ -662,9 +796,15 @@ static gboolean mms_parse_headers(struct
wsp_header_iter *iter,
 				!(entries[h].flags &
HEADER_FLAG_ALLOW_MULTI))
 			continue;
 =

+		DBG("running handler for type %u", h);
+
 		/* Parse the header */
-		if (handler(iter, entries[h].data) =3D=3D FALSE)
+		if (handler(iter, entries[h].data) =3D=3D FALSE) {
+			DBG("handler %p for type %u returned false",
handler, h);
 			return FALSE;
+		}
+
+		DBG("handler for type %u was success", h);
 =

 		entries[h].pos =3D i;
 		entries[h].flags |=3D HEADER_FLAG_MARKED;
@@ -672,8 +812,10 @@ static gboolean mms_parse_headers(struct
wsp_header_iter *iter,
 =

 	for (i =3D 0; i < __MMS_HEADER_MAX + 1; i++) {
 		if ((entries[i].flags & HEADER_FLAG_MANDATORY) &&
-				!(entries[i].flags &
HEADER_FLAG_MARKED))
+				!(entries[i].flags &
HEADER_FLAG_MARKED)) {
+			DBG("header %u was mandatory but not marked",
i);
 			return FALSE;
+		}
 	}
 =

 	/*
@@ -704,8 +846,10 @@ static gboolean mms_parse_headers(struct
wsp_header_iter *iter,
 =

 		va_end(args);
 =

-		if (entries[i].pos !=3D expected_pos)
+		if (entries[i].pos !=3D expected_pos) {
+			DBG("header %u was in position %u but expected
in position %u", i, entries[i].pos, expected_pos);
 			return FALSE;
+		}
 	}
 =

 	return TRUE;
@@ -770,6 +914,7 @@ static gboolean extract_content_id(struct
wsp_header_iter *iter, void *user)
 		return FALSE;
 =

 	*out =3D g_strdup(text);
+	DBG("extracted content-id %s\n", *out);
 =

 	return TRUE;
 }
@@ -991,11 +1136,17 @@ gboolean mms_message_decode(const unsigned char
*pdu,
 	flags |=3D WSP_HEADER_ITER_FLAG_DETECT_MMS_MULTIPART;
 	wsp_header_iter_init(&iter, pdu, len, flags);
 =

+	DBG("about to check well known");
+
 	CHECK_WELL_KNOWN_HDR(MMS_HEADER_MESSAGE_TYPE);
 =

+	DBG("about to extract short");
+
 	if (extract_short(&iter, &octet) =3D=3D FALSE)
 		return FALSE;
 =

+	DBG("octet %u", octet);
+
 	if (octet < MMS_MESSAGE_TYPE_SEND_REQ ||
 			octet > MMS_MESSAGE_TYPE_DELIVERY_IND)
 		return FALSE;
@@ -1422,6 +1573,12 @@ static header_encoder encoder_for_type(enum
mms_header header)
 		return NULL;
 	case MMS_HEADER_RESPONSE_TEXT:
 		return NULL;
+	case MMS_HEADER_RETRIEVE_STATUS:
+		return NULL;
+	case MMS_HEADER_RETRIEVE_TEXT:
+		return NULL;
+	case MMS_HEADER_READ_STATUS:
+		return NULL;
 	case MMS_HEADER_SENDER_VISIBILITY:
 		return NULL;
 	case MMS_HEADER_STATUS:
diff --git a/src/mmsutil.h b/src/mmsutil.h
index e32c761..00ecc39 100644
--- a/src/mmsutil.h
+++ b/src/mmsutil.h
@@ -50,6 +50,23 @@ enum mms_message_rsp_status {
 	MMS_MESSAGE_RSP_STATUS_ERR_PERM_LACK_OF_PREPAID
=3D		235,
 };
 =

+enum mms_message_retr_status {
+	MMS_MESSAGE_RETR_STATUS_OK =3D				128,
+	MMS_MESSAGE_RETR_STATUS_ERR_TRANS_MIN
=3D			192,
+	MMS_MESSAGE_RETR_STATUS_ERR_TRANS_FAILURE =3D		192,
+	MMS_MESSAGE_RETR_STATUS_ERR_TRANS_MESSAGE_NOT_FOUND =3D	194,
+	MMS_MESSAGE_RETR_STATUS_ERR_PERM_MIN =3D			224,
+	MMS_MESSAGE_RETR_STATUS_ERR_PERM_FAILURE =3D		224,
+	MMS_MESSAGE_RETR_STATUS_ERR_PERM_SERVICE_DENIED =3D	225,
+	MMS_MESSAGE_RETR_STATUS_ERR_PERM_MESSAGE_NOT_FOUND =3D	226,
+	MMS_MESSAGE_RETR_STATUS_ERR_PERM_CONTENT_UNSUPPORTED =3D	227,
+};
+
+enum mms_message_read_status {
+	MMS_MESSAGE_READ_STATUS_READ =3D			128,
+	MMS_MESSAGE_READ_STATUS_DELETED_UNREAD =3D	129,
+};
+
 enum mms_message_notify_status {
 	MMS_MESSAGE_NOTIFY_STATUS_RETRIEVED =3D		129,
 	MMS_MESSAGE_NOTIFY_STATUS_REJECTED =3D		130,
diff --git a/src/service.c b/src/service.c
index b3ecc1e..c7ef255 100644
--- a/src/service.c
+++ b/src/service.c
@@ -609,7 +609,7 @@ static void emit_message_added(const struct
mms_service *service,
 =

 static void activate_bearer(struct mms_service *service)
 {
-	DBG("service %p", service);
+	DBG("service %p setup %d active %d", service, service-
>bearer_setup, service->bearer_active);
 =

 	if (service->bearer_setup =3D=3D TRUE)
 		return;
@@ -622,7 +622,7 @@ static void activate_bearer(struct mms_service
*service)
 	if (service->bearer_handler =3D=3D NULL)
 		return;
 =

-	DBG("service %p", service);
+	DBG("service %p waiting for %d seconds", service,
BEARER_SETUP_TIMEOUT);
 =

 	service->bearer_setup =3D TRUE;
 =

@@ -736,6 +736,8 @@ static DBusMessage *get_messages(DBusConnection
*conn,
 	GHashTableIter table_iter;
 	gpointer key, value;
 =

+	DBG("");
+
 	reply =3D dbus_message_new_method_return(dbus_msg);
 	if (reply =3D=3D NULL)
 		return NULL;
@@ -1632,6 +1634,7 @@ static void append_attachment_properties(struct
mms_attachment *part,
 	dbus_message_iter_open_container(part_array, DBUS_TYPE_STRUCT,
 							NULL, &entry);
 =

+	DBG("content-id: %s\n", part->content_id);
 	dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING,
 							&part-
>content_id);
 	dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING,
@@ -1793,7 +1796,7 @@ static void append_msg_recipients(DBusMessageIter
*dict,
 =

 	for (i =3D 0; tokens[i] !=3D NULL; i++) {
 		rcpt =3D mms_address_to_string(tokens[i]);
-
+		DBG("rcpt=3D%s", rcpt);
 		dbus_message_iter_append_basic(&array,
DBUS_TYPE_STRING, &rcpt);
 	}
 =

@@ -1814,25 +1817,31 @@ static void
append_rc_msg_properties(DBusMessageIter *dict,
 	const char *from_prefix;
 	char *from;
 =

+	DBG("status=3D%s", status);
 	mms_dbus_dict_append_basic(dict, "Status",
 					DBUS_TYPE_STRING, &status);
 =

+	DBG("date=3D%s", date);
 	mms_dbus_dict_append_basic(dict, "Date",
 					DBUS_TYPE_STRING,  &date);
 =

+	DBG("subject=3D%s", msg->rc.subject);
 	if (msg->rc.subject !=3D NULL)
 		mms_dbus_dict_append_basic(dict, "Subject",
 					DBUS_TYPE_STRING, &msg-
>rc.subject);
 =

+	DBG("from=3D%s", msg->rc.from);
 	from =3D g_strdup(msg->rc.from);
 =

 	if (from !=3D NULL) {
 		from_prefix =3D mms_address_to_string(from);
+		DBG("from_pfx=3D%s", from_prefix);
 		mms_dbus_dict_append_basic(dict, "Sender",
 					DBUS_TYPE_STRING,
&from_prefix);
 		g_free(from);
 	}
 =

+	DBG("to=3D%s", msg->rc.to);
 	if (msg->rc.to !=3D NULL)
 		append_msg_recipients(dict, msg);
 }
@@ -1862,6 +1871,8 @@ static void append_message(const char *path,
const struct mms_service *service,
 =

 	mms_dbus_dict_open(iter, &dict);
 =

+	DBG("type=3D%d", msg->type);
+
 	switch (msg->type) {
 	case MMS_MESSAGE_TYPE_SEND_REQ:
 		append_sr_msg_properties(&dict, msg);
@@ -1873,7 +1884,7 @@ static void append_message(const char *path,
const struct mms_service *service,
 	case MMS_MESSAGE_TYPE_NOTIFYRESP_IND:
 		break;
 	case MMS_MESSAGE_TYPE_RETRIEVE_CONF:
-		append_rc_msg_properties(&dict, msg);
+		append_rc_msg_properties(&dict, msg); /* causes dbus
disconnect! */
 		break;
 	case MMS_MESSAGE_TYPE_ACKNOWLEDGE_IND:
 		break;
@@ -1884,6 +1895,7 @@ static void append_message(const char *path,
const struct mms_service *service,
 	if (msg->attachments !=3D NULL) {
 		char *pdu_path =3D mms_store_get_path(service->identity,
 								msg-
>uuid);
+		DBG("appending pdu path %s", pdu_path);
 		append_msg_attachments(&dict, pdu_path, msg);
 		g_free(pdu_path);
 	}
@@ -2059,8 +2071,10 @@ static gboolean
result_request_notify_resp(struct mms_request *request)
 		return FALSE;
 	}
 =

-	if (request->msg =3D=3D NULL)
+	if (request->msg =3D=3D NULL) {
+		mms_error("POST m.notify.resp.ind provided no message
to register");
 		return FALSE;
+	}
 =

 	msg =3D mms_request_steal_message(request);
 =

@@ -2210,6 +2224,9 @@ static gboolean web_get_cb(GWebResult *result,
gpointer user_data)
 complete:
 	close(request->fd);
 =

+	DBG("request->result_cb=3D%p vs.
retrieve_conf=3D%p/send_conf=3D%p/notify_resp=3D%p",
+	  request->result_cb, result_request_retrieve_conf,
result_request_send_conf, result_request_notify_resp);
+
 	if (request->result_cb =3D=3D NULL || request->result_cb(request)
=3D=3D TRUE)
 		mms_request_destroy(request);
 	else {
@@ -2378,25 +2395,37 @@ void mms_service_push_notify(struct mms_service
*service,
 		return;
 	}
 =

+	DBG("about to push notify");
+
 	if (mms_push_notify(data, len, &nread) =3D=3D FALSE)
 		goto out;
 =

+	DBG("did push notify; about to store");
+
 	uuid =3D mms_store(service->identity, data + nread, len -
nread);
 	if (uuid =3D=3D NULL)
 		goto out;
 =

+	DBG("did store; about to decode");
+
 	if (mms_message_decode(data + nread, len - nread, msg) =3D=3D
FALSE)
 		goto error;
 =

+	DBG("did decode message");
+
 	if (msg->type =3D=3D MMS_MESSAGE_TYPE_DELIVERY_IND) {
 		msg->uuid =3D g_strdup(uuid);
 =

 		dump_delivery_ind(msg);
 =

+		DBG("about to store_meta_open");
+
 		meta =3D mms_store_meta_open(service->identity, uuid);
 		if (meta =3D=3D NULL)
 			goto error;
 =

+		DBG("did store_meta_open");
+
 		g_key_file_set_string(meta, "info", "state",
"notification");
 =

 		mms_store_meta_close(service->identity, uuid, meta,
TRUE);
@@ -2404,17 +2433,25 @@ void mms_service_push_notify(struct mms_service
*service,
 		return;
 	}
 =

+	DBG("is type NI?");
+
 	if (msg->type !=3D MMS_MESSAGE_TYPE_NOTIFICATION_IND)
 		goto error;
 =

+	DBG("type is NI");
+
 	msg->uuid =3D g_strdup(uuid);
 =

 	dump_notification_ind(msg);
 =

+	DBG("about to store_meta_open 2");
+
 	meta =3D mms_store_meta_open(service->identity, uuid);
 	if (meta =3D=3D NULL)
 		goto error;
 =

+	DBG("did store_meta_open 2");
+
 	g_key_file_set_boolean(meta, "info", "read", FALSE);
 =

 	g_key_file_set_string(meta, "info", "state", "notification");
@@ -2427,6 +2464,8 @@ void mms_service_push_notify(struct mms_service
*service,
 	if (request =3D=3D NULL)
 		goto out;
 =

+	DBG("did create_request");
+
 	g_queue_push_tail(service->request_queue, request);
 =

 	activate_bearer(service);
@@ -2442,12 +2481,16 @@ out:
 	mms_error("Failed to handle incoming notification");
 }
 =

+void debug_print(const char* s, void* data) {
+	printf("%s\n", s);
+}
+
 void mms_service_bearer_notify(struct mms_service *service, mms_bool_t
active,
 				const char *interface, const char
*proxy)
 {
 	int ifindex;
 =

-	DBG("service %p active %d", service, active);
+	DBG("service=3D%p active=3D%d iface=3D%s proxy=3D%s", service, active,
interface, proxy);
 =

 	if (service =3D=3D NULL)
 		return;
@@ -2463,6 +2506,7 @@ void mms_service_bearer_notify(struct mms_service
*service, mms_bool_t active,
 	if (active =3D=3D FALSE)
 		goto interface_down;
 =

+
 	DBG("interface %s proxy %s", interface, proxy);
 =

 	if (service->web !=3D NULL) {
@@ -2481,6 +2525,8 @@ void mms_service_bearer_notify(struct mms_service
*service, mms_bool_t active,
 	if (service->web =3D=3D NULL)
 		return;
 =

+	g_web_set_debug(service->web, (GWebDebugFunc)debug_print,
NULL);
+
 	/* Sometimes no proxy is reported as string instead of NULL */
 	if (g_strcmp0(proxy, "") !=3D 0)
 		g_web_set_proxy(service->web, proxy);
diff --git a/test/send-message b/test/send-message
index 558fdaa..8477e79 100755
--- a/test/send-message
+++ b/test/send-message
@@ -5,23 +5,23 @@ import dbus
 import csv
 =

 if (len(sys.argv) < 4):
-	print "Usage: %s"\
+	print("Usage: {}"\
 		" <recipient>,..."\
 		" <smil-file-path>"\
 		" <<content-id>,<content-type>,<file-path>>,..."\
-		% (sys.argv[0])
-	print "Sample(Related): %s"\
+		.format(sys.argv[0]))
+	print("Sample(Related): {}"\
 		" \"+33611111111,+33622222222\""\
 		" \"smil.txt\""\
 		" \"cid-1,text/plain,text.txt\""\
 		" \"cid-2,image/jpeg,image.jpg\""\
-		% (sys.argv[0])
-	print "Sample(Mixed): %s"\
+		.format(sys.argv[0]))
+	print("Sample(Mixed): {}"\
 		" \"+33611111111,+33622222222\""\
 		" \"\""\
 		" \"cid-1,text/plain,text.txt\""\
 		" \"cid-2,image/jpeg,image.jpg\""\
-		% (sys.argv[0])
+		.format(sys.argv[0]))
 	sys.exit(1)
 =

 bus =3D dbus.SessionBus()
@@ -38,23 +38,23 @@ service =3D
dbus.Interface(bus.get_object('org.ofono.mms', path),
 recipients =3D dbus.Array([],signature=3Ddbus.Signature('s'))
 reader =3D csv.reader([sys.argv[1]])
 for r in reader:
-	print "Recipient list: %s" % r
+	print("Recipient list: {}".format(r))
 	for i in r:
 		recipients.append(dbus.String(i))
 =

 =

 if sys.argv[2] =3D=3D "":
-	print "Send MMS as Mixed"
+	print("Send MMS as Mixed")
 	smil =3D ""
 else:
-	print "Send MMS as Related"
-	print "Smil path: %s" % (sys.argv[2])
+	print("Send MMS as Related")
+	print("Smil path: {}".format(sys.argv[2]))
 	file =3D open(sys.argv[2],"r")
 	smil =3D dbus.String(file.read())
 =

 attachments =3D dbus.Array([],signature=3Ddbus.Signature('(sss)'))
 for a in sys.argv[3:]:
-	print "Attachment: (%s)" % a
+	print("Attachment: ({})".format(a))
 	reader =3D csv.reader([a])
 	for r in reader:
 		attachments.append(dbus.Struct((dbus.String(r[0]),
@@ -64,4 +64,4 @@ for a in sys.argv[3:]:
 =

 path =3D service.SendMessage(recipients, smil, attachments)
 =

-print path
+print(path)
-- =

2.30.2


--===============5892592246391341855==--

