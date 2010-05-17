Content-Type: multipart/mixed; boundary="===============8096806885661433498=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH 2/2] ppp: check for NO CARRIER
Date: Mon, 17 May 2010 12:43:44 -0700
Message-ID: <1274125424-14490-3-git-send-email-kristen@linux.intel.com>
In-Reply-To: <1274125424-14490-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8096806885661433498==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

if hdlc detects NO CARRIER, treat it the same as an IO disconnect.
---
 gatchat/gatppp.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/gatchat/gatppp.c b/gatchat/gatppp.c
index 82d1eca..bc5c9bf 100644
--- a/gatchat/gatppp.c
+++ b/gatchat/gatppp.c
@@ -472,6 +472,7 @@ static GAtPPP *ppp_init_common(GAtHDLC *hdlc)
 	g_at_hdlc_set_receive(ppp->hdlc, ppp_receive, ppp);
 	g_at_io_set_disconnect_function(g_at_hdlc_get_io(ppp->hdlc),
 						io_disconnect, ppp);
+	g_at_hdlc_set_no_carrier(ppp->hdlc, io_disconnect, ppp);
 =

 	return ppp;
 }
-- =

1.6.6.1


--===============8096806885661433498==--

