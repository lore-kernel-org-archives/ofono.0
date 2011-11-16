Content-Type: multipart/mixed; boundary="===============0300809250776880052=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v0 1/3] include: Add public API to create cdma_sim
Date: Wed, 16 Nov 2011 15:48:59 +0100
Message-ID: <1321454941-32022-2-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1321454941-32022-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0300809250776880052==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/sim.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/include/sim.h b/include/sim.h
index 6a5f067..4d99f06 100644
--- a/include/sim.h
+++ b/include/sim.h
@@ -174,6 +174,10 @@ struct ofono_sim *ofono_sim_create(struct ofono_modem =
*modem,
 					unsigned int vendor,
 					const char *driver, void *data);
 =

+struct ofono_sim *ofono_cdma_sim_create(struct ofono_modem *modem,
+					unsigned int vendor,
+					const char *driver, void *data);
+
 void ofono_sim_register(struct ofono_sim *sim);
 void ofono_sim_remove(struct ofono_sim *sim);
 =

-- =

1.7.1


--===============0300809250776880052==--

