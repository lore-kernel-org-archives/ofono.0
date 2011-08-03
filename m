Content-Type: multipart/mixed; boundary="===============9046885603807422071=="
MIME-Version: 1.0
From: Bertrand Aygon <bertrand.aygon@intel.com>
Subject: [PATCH] speedup: cleanup sim polling when the modem is removed.
Date: Wed, 03 Aug 2011 10:24:03 +0200
Message-ID: <1312359843-2595-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9046885603807422071==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/speedup.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/plugins/speedup.c b/plugins/speedup.c
index b617699..fbfe2e6 100644
--- a/plugins/speedup.c
+++ b/plugins/speedup.c
@@ -80,6 +80,9 @@ static void speedup_remove(struct ofono_modem *modem)
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

--===============9046885603807422071==--

