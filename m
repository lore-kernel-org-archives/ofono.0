Content-Type: multipart/mixed; boundary="===============0107177331529590966=="
MIME-Version: 1.0
From: Dragos Tatulea <dragos@endocode.com>
Subject: [PATCH 11/19] gprs-context.h: add function for setting APN
Date: Wed, 09 Mar 2016 16:44:52 +0100
Message-ID: <1457538300-7183-12-git-send-email-dragos@endocode.com>
In-Reply-To: <1457538300-7183-1-git-send-email-dragos@endocode.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0107177331529590966==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/gprs-context.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/gprs-context.h b/include/gprs-context.h
index 0090cc4..11d2132 100644
--- a/include/gprs-context.h
+++ b/include/gprs-context.h
@@ -107,6 +107,9 @@ enum ofono_gprs_context_type ofono_gprs_context_get_typ=
e(
 void ofono_gprs_context_set_interface(struct ofono_gprs_context *gc,
 					const char *interface);
 =

+void ofono_gprs_context_set_apn(struct ofono_gprs_context *gc,
+					const char *interface);
+
 void ofono_gprs_context_set_ipv4_address(struct ofono_gprs_context *gc,
 						const char *address,
 						ofono_bool_t static_ip);
-- =

2.5.0


--===============0107177331529590966==--

