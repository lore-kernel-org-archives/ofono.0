Content-Type: multipart/mixed; boundary="===============4954515316206932384=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 2/2] gatppp: Unset disconnect function when unref PPP
Date: Wed, 07 Jul 2010 09:46:32 +0800
Message-ID: <1278467192-12207-2-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1278467192-12207-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4954515316206932384==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Unset IO disconnect function when we try to destroy GAtPPP instance.
After freeing the instance, the IO disconnect function should not be
invoked.
---
 gatchat/gatppp.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/gatchat/gatppp.c b/gatchat/gatppp.c
index d9b1627..63508b5 100644
--- a/gatchat/gatppp.c
+++ b/gatchat/gatppp.c
@@ -454,6 +454,9 @@ void g_at_ppp_unref(GAtPPP *ppp)
 	if (is_zero =3D=3D FALSE)
 		return;
 =

+	g_at_io_set_disconnect_function(g_at_hdlc_get_io(ppp->hdlc),
+						NULL, NULL);
+
 	if (ppp->net)
 		ppp_net_free(ppp->net);
 =

-- =

1.6.3.3


--===============4954515316206932384==--

