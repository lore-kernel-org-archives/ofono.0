Content-Type: multipart/mixed; boundary="===============2340216534802038528=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v4 3/4] emulator: Activate ACFC and PFC options onto GAtPPP
 object
Date: Wed, 29 Jun 2011 10:20:25 +0200
Message-ID: <1309335626-32202-4-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1309335626-32202-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2340216534802038528==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/emulator.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/src/emulator.c b/src/emulator.c
index 906404d..2e1300e 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -150,6 +150,9 @@ static void request_private_network_cb(
 	g_at_ppp_set_server_info(em->ppp, pns->peer_ip,
 					pns->primary_dns, pns->secondary_dns);
 =

+	g_at_ppp_set_acfc_enabled(em->ppp, TRUE);
+	g_at_ppp_set_pfc_enabled(em->ppp, TRUE);
+
 	g_at_ppp_set_credentials(em->ppp, "", "");
 	g_at_ppp_set_debug(em->ppp, emulator_debug, "PPP");
 =

-- =

1.7.1


--===============2340216534802038528==--

