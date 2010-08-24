Content-Type: multipart/mixed; boundary="===============7195296256975970099=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH 2/2] mbm: use sim_ready_notify
Date: Tue, 24 Aug 2010 07:24:14 -0700
Message-ID: <1282659854-28097-2-git-send-email-kristen@linux.intel.com>
In-Reply-To: <1282659854-28097-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7195296256975970099==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/mbm.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/plugins/mbm.c b/plugins/mbm.c
index 8541aaf..5a82bf2 100644
--- a/plugins/mbm.c
+++ b/plugins/mbm.c
@@ -335,8 +335,11 @@ static void mbm_pre_sim(struct ofono_modem *modem)
 	sim =3D ofono_sim_create(modem, OFONO_VENDOR_MBM,
 					"atmodem", data->modem_port);
 =

-	if (data->have_sim && sim)
+	if (sim)
 		ofono_sim_inserted_notify(sim, TRUE);
+
+	if (data->have_sim)
+		ofono_sim_ready_notify(sim);
 }
 =

 static void mbm_post_sim(struct ofono_modem *modem)
-- =

1.7.2.1


--===============7195296256975970099==--

