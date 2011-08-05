Content-Type: multipart/mixed; boundary="===============4926851571906842670=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCHv3 2/5] GPRS context plan support
Date: Fri, 05 Aug 2011 15:25:59 +0300
Message-ID: <1312547162-26420-3-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1312547162-26420-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4926851571906842670==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/gprs-context.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/include/gprs-context.h b/include/gprs-context.h
index f82fcaa..8dfc106 100644
--- a/include/gprs-context.h
+++ b/include/gprs-context.h
@@ -48,6 +48,11 @@ enum ofono_gprs_context_type {
 	OFONO_GPRS_CONTEXT_TYPE_IMS,
 };
 =

+enum ofono_gprs_context_plan {
+	OFONO_GPRS_CONTEXT_PLAN_PREPAID,
+	OFONO_GPRS_CONTEXT_PLAN_POSTPAID,
+};
+
 struct ofono_gprs_primary_context {
 	unsigned int cid;
 	int direction;
-- =

1.7.1


--===============4926851571906842670==--

