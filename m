Content-Type: multipart/mixed; boundary="===============1657019982079966652=="
MIME-Version: 1.0
From: Jukka Saunamaki <jukka.saunamaki@nokia.com>
Subject: [PATCH 1/3] gprs-provision: add SPN to provisioning API header
Date: Tue, 08 Feb 2011 12:03:46 +0200
Message-ID: <1297159428-2409-2-git-send-email-jukka.saunamaki@nokia.com>
In-Reply-To: <1297159428-2409-1-git-send-email-jukka.saunamaki@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1657019982079966652==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/gprs-provision.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/gprs-provision.h b/include/gprs-provision.h
index bc021a8..e9eec61 100644
--- a/include/gprs-provision.h
+++ b/include/gprs-provision.h
@@ -42,7 +42,7 @@ struct ofono_gprs_provision_data {
 struct ofono_gprs_provision_driver {
 	const char *name;
 	int priority;
-	int (*get_settings)(const char *mcc, const char *mnc,
+	int (*get_settings)(const char *mcc, const char *mnc, const char *spn,
 				struct ofono_gprs_provision_data **settings,
 				int *count);
 };
-- =

1.7.1


--===============1657019982079966652==--

