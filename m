Content-Type: multipart/mixed; boundary="===============6386612773636133842=="
MIME-Version: 1.0
From: Marit Henriksen <maritsofie.henriksen8@gmail.com>
Subject: [PATCH 1/2] src: Added enum for PDP context status.
Date: Fri, 14 Jan 2011 12:16:45 +0100
Message-ID: <1295003805-11139-1-git-send-email-maritsofie.henriksen8@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6386612773636133842==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Marit Henriksen <marit.henriksen@stericsson.com>

---
 src/common.h |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/src/common.h b/src/common.h
index 64f297e..234ef4a 100644
--- a/src/common.h
+++ b/src/common.h
@@ -129,6 +129,12 @@ enum pin_type {
 	PIN_TYPE_NET,
 };
 =

+/* 27.007 Section 10.1.10 */
+enum context_status {
+	CONTEXT_STATUS_DEACTIVATED =3D 0,
+	CONTEXT_STATUS_ACTIVATED =3D 1,
+};
+
 const char *telephony_error_to_str(const struct ofono_error *error);
 =

 gboolean valid_phone_number_format(const char *number);
-- =

1.7.1


--===============6386612773636133842==--

