Content-Type: multipart/mixed; boundary="===============1943226178890382925=="
MIME-Version: 1.0
From: Bertrand Aygon <bertrand.aygon@intel.com>
Subject: [PATCH] zte: cleanup sim polling when the modem is removed.
Date: Wed, 03 Aug 2011 10:24:48 +0200
Message-ID: <1312359888-2753-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1943226178890382925==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/zte.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/plugins/zte.c b/plugins/zte.c
index 9fa9940..d812e64 100644
--- a/plugins/zte.c
+++ b/plugins/zte.c
@@ -82,6 +82,9 @@ static void zte_remove(struct ofono_modem *modem)
 	/* Cleanup after hot-unplug */
 	g_at_chat_unref(data->aux);
 =

+	if (data->sim_state_query)
+		at_util_sim_state_query_free(data->sim_state_query);
+
 	g_free(data);
 }
 =

-- =

1.7.4.1

---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

--===============1943226178890382925==--

