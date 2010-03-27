Content-Type: multipart/mixed; boundary="===============3004366721457194399=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH 2/5] ppp: comment fix
Date: Fri, 26 Mar 2010 18:34:27 -0700
Message-ID: <1269653670-31352-3-git-send-email-kristen@linux.intel.com>
In-Reply-To: <1269653670-31352-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3004366721457194399==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Put some additional clarification in comment for receiving Code-Reject
and Protocol-Reject packets.
---
 gatchat/ppp_cp.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/gatchat/ppp_cp.c b/gatchat/ppp_cp.c
index 39e872b..f83cfba 100644
--- a/gatchat/ppp_cp.c
+++ b/gatchat/ppp_cp.c
@@ -1401,6 +1401,10 @@ static guint8 pppcp_process_code_reject(struct pppcp=
_data *data,
 	 * determine if the code reject is catastrophic or not.
 	 * return RXJ_PLUS if this reject is acceptable, RXJ_MINUS if
 	 * it is catastrophic.
+	 *
+	 * for now we always return RXJ_MINUS.  Any code
+	 * reject will be catastrophic, since we only support the
+	 * bare minimum number of codes necessary to function.
 	 */
 	return RXJ_MINUS;
 }
@@ -1412,6 +1416,10 @@ static guint8 pppcp_process_protocol_reject(struct p=
ppcp_data *data,
 	 * determine if the protocol reject is catastrophic or not.
 	 * return RXJ_PLUS if this reject is acceptable, RXJ_MINUS if
 	 * it is catastrophic.
+	 *
+	 * for now we always return RXJ_MINUS.  Any protocol
+	 * reject will be catastrophic, since we only support the
+	 * bare minimum number of protocols necessary to function.
 	 */
 	return RXJ_MINUS;
 }
-- =

1.6.6.1


--===============3004366721457194399==--

