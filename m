Content-Type: multipart/mixed; boundary="===============3362901015707385865=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCHv3 3/5] GPRS provisioning data plan support
Date: Fri, 05 Aug 2011 15:26:00 +0300
Message-ID: <1312547162-26420-4-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1312547162-26420-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3362901015707385865==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/gprs-provision.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/gprs-provision.h b/include/gprs-provision.h
index e9eec61..2273a09 100644
--- a/include/gprs-provision.h
+++ b/include/gprs-provision.h
@@ -30,6 +30,7 @@ extern "C" {
 =

 struct ofono_gprs_provision_data {
 	enum ofono_gprs_context_type type;
+	enum ofono_gprs_context_plan plan;
 	enum ofono_gprs_proto proto;
 	char *name;
 	char *apn;
-- =

1.7.1


--===============3362901015707385865==--

