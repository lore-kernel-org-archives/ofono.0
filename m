Content-Type: multipart/mixed; boundary="===============1060134810584963025=="
MIME-Version: 1.0
From: Rajesh Kadhiravan Nagaiah <Rajesh.Nagaiah@elektrobit.com>
Subject: [PATCH 2/4] types: Add modem access technology enumeration
Date: Thu, 28 Oct 2010 01:14:52 -0700
Message-ID: <1288253694-25800-3-git-send-email-Rajesh.Nagaiah@elektrobit.com>
In-Reply-To: <1288253694-25800-1-git-send-email-Rajesh.Nagaiah@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1060134810584963025==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/types.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/include/types.h b/include/types.h
index ba2481f..72bc896 100644
--- a/include/types.h
+++ b/include/types.h
@@ -71,6 +71,11 @@ enum ofono_disconnect_reason {
 	OFONO_DISCONNECT_REASON_ERROR,
 };
 =

+enum ofono_modem_access_technology {
+	OFONO_MODEM_ACCESS_TECHNOLOGY_GSM,
+	OFONO_MODEM_ACCESS_TECHNOLOGY_CDMA,
+};
+
 struct ofono_error {
 	enum ofono_error_type type;
 	int error;
-- =

1.7.0.4


--===============1060134810584963025==--

