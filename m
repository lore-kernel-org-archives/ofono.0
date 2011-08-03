Content-Type: multipart/mixed; boundary="===============4058861603585018400=="
MIME-Version: 1.0
From: Bertrand Aygon <bertrand.aygon@intel.com>
Subject: [PATCH] huawei: cleanup sim polling when the modem is removed.
Date: Wed, 03 Aug 2011 10:23:14 +0200
Message-ID: <1312359794-2455-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4058861603585018400==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/huawei.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/plugins/huawei.c b/plugins/huawei.c
index 1380369..eaf8b07 100644
--- a/plugins/huawei.c
+++ b/plugins/huawei.c
@@ -107,6 +107,9 @@ static void huawei_remove(struct ofono_modem *modem)
 	/* Cleanup after hot-unplug */
 	g_at_chat_unref(data->pcui);
 =

+	if (data->sysinfo_poll_source)
+		g_source_remove(data->sysinfo_poll_source);
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

--===============4058861603585018400==--

