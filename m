Content-Type: multipart/mixed; boundary="===============0747995305399782208=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH 3/3] fix memory leak in ppp_auth
Date: Wed, 24 Mar 2010 10:13:25 -0700
Message-ID: <1269450805-3661-4-git-send-email-kristen@linux.intel.com>
In-Reply-To: <1269450805-3661-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0747995305399782208==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Free packet after calling ppp_transmit()
---
 gatchat/ppp_auth.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/gatchat/ppp_auth.c b/gatchat/ppp_auth.c
index 2270436..6c3913e 100644
--- a/gatchat/ppp_auth.c
+++ b/gatchat/ppp_auth.c
@@ -112,6 +112,7 @@ static void chap_process_challenge(struct auth_data *au=
th, guint8 *packet)
 =

 	/* transmit the packet */
 	ppp_transmit(auth->ppp, (guint8 *) ppp_packet, response_length);
+	g_free(ppp_packet);
 =

 challenge_out:
 	g_checksum_free(checksum);
-- =

1.6.6.1


--===============0747995305399782208==--

