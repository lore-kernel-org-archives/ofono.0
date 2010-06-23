Content-Type: multipart/mixed; boundary="===============2767806456361446355=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 1/6] ppp: Fix incorrect packet length for little-endian
Date: Wed, 23 Jun 2010 17:46:37 +0800
Message-ID: <1277286402-22312-2-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1277286402-22312-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2767806456361446355==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

packet->length is in TCP/IP network byte order. It needs to call ntohs()
to convert to host byte order, which is little-endian.
---
 gatchat/ppp_ipcp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gatchat/ppp_ipcp.c b/gatchat/ppp_ipcp.c
index a1eacdf..0b3c381 100644
--- a/gatchat/ppp_ipcp.c
+++ b/gatchat/ppp_ipcp.c
@@ -281,7 +281,7 @@ static enum rcr_result ipcp_rcr(struct pppcp_data *pppc=
p,
 		return RCR_ACCEPT;
 =

 	/* Reject all options */
-	*new_len =3D packet->length - sizeof(*packet);
+	*new_len =3D ntohs(packet->length) - sizeof(*packet);
 	*new_options =3D g_memdup(packet->data, *new_len);
 =

 	return RCR_REJECT;
-- =

1.6.3.3


--===============2767806456361446355==--

