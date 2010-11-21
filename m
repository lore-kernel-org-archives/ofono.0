Content-Type: multipart/mixed; boundary="===============8052434980103595546=="
MIME-Version: 1.0
From: Sjur =?unknown-8bit?q?Br=C3=A6ndeland?= <sjurbren@gmail.com>
Subject: [PATCH RESEND] stemodem: Change use of types
Date: Sun, 21 Nov 2010 21:55:15 +0100
Message-ID: <1290372915-7911-3-git-send-email-sjurbren@gmail.com>
In-Reply-To: <1289760663-10334-1-git-send-email-sjurbren@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8052434980103595546==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Sjur Br=C3=A6ndeland <sjur.brandeland@stericsson.com>

Use the type __u32 for sequence counting rather than guint32,
and "void *" instead of gpointer.
Reduce the size of RTNL message buffer from 4096 to 1024,
as this should be sufficient to hold the NEWLINK message.

---
Last patch was sent with base64 encoding :-(

 drivers/stemodem/caif_rtnl.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/stemodem/caif_rtnl.c b/drivers/stemodem/caif_rtnl.c
index 5d4073a..4c00446 100644
--- a/drivers/stemodem/caif_rtnl.c
+++ b/drivers/stemodem/caif_rtnl.c
@@ -41,7 +41,7 @@
 #define NLMSG_TAIL(nmsg) \
 	((struct rtattr *) (((void *) (nmsg)) + NLMSG_ALIGN((nmsg)->nlmsg_len)))
 =

-#define RTNL_MSG_SIZE 4096
+#define RTNL_MSG_SIZE 1024
 =

 struct rtnl_msg {
 	struct nlmsghdr n;
@@ -50,17 +50,17 @@ struct rtnl_msg {
 };
 =

 struct iplink_req {
-	guint32 rtnlmsg_seqnr;
-	gpointer user_data;
+	__u32 rtnlmsg_seqnr;
+	void *user_data;
 	caif_rtnl_create_cb_t callback;
 };
 =

 static GSList *pending_requests;
-static guint32 rtnl_seqnr;
+static __u32 rtnl_seqnr;
 static guint rtnl_watch;
 static GIOChannel *rtnl_channel;
 =

-static struct iplink_req *find_request(guint32 seq)
+static struct iplink_req *find_request(__u32 seq)
 {
 	GSList *list;
 =

@@ -169,7 +169,7 @@ static int add_attribute(struct nlmsghdr *n, unsigned i=
nt maxlen, int type,
 	return 0;
 }
 =

-static inline void prep_rtnl_req(struct rtnl_msg *msg, int reqtype, guint =
seqnr)
+static inline void prep_rtnl_req(struct rtnl_msg *msg, int reqtype, __u32 =
seqnr)
 {
 	msg->n.nlmsg_len =3D NLMSG_LENGTH(sizeof(struct ifinfomsg));
 	msg->n.nlmsg_flags =3D NLM_F_REQUEST|NLM_F_CREATE|NLM_F_EXCL;
@@ -179,7 +179,7 @@ static inline void prep_rtnl_req(struct rtnl_msg *msg, =
int reqtype, guint seqnr)
 }
 =

 static gboolean netlink_event(GIOChannel *chan,
-				GIOCondition cond, gpointer data)
+				GIOCondition cond, void *data)
 {
 	unsigned char buf[RTNL_MSG_SIZE];
 	int len, sk;
-- =

1.6.3.3


--===============8052434980103595546==--

