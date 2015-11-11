Content-Type: multipart/mixed; boundary="===============2666272089687110765=="
MIME-Version: 1.0
From: Alfonso Sanchez-Beato <alfonso.sanchez-beato@canonical.com>
Subject: [PATCH 3/3] mbpi: Add support for IA APN type
Date: Wed, 11 Nov 2015 15:38:39 +0100
Message-ID: <1447252719-9284-3-git-send-email-alfonso.sanchez-beato@canonical.com>
In-Reply-To: <1447252719-9284-1-git-send-email-alfonso.sanchez-beato@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2666272089687110765==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/mbpi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/plugins/mbpi.c b/plugins/mbpi.c
index ae92c76..ac50e3c 100644
--- a/plugins/mbpi.c
+++ b/plugins/mbpi.c
@@ -72,6 +72,7 @@ const char *mbpi_ap_type(enum ofono_gprs_context_type typ=
e)
 		_(OFONO_GPRS_CONTEXT_TYPE_MMS);
 		_(OFONO_GPRS_CONTEXT_TYPE_WAP);
 		_(OFONO_GPRS_CONTEXT_TYPE_IMS);
+		_(OFONO_GPRS_CONTEXT_TYPE_IA);
 	}
 =

 	return "OFONO_GPRS_CONTEXT_TYPE_<UNKNOWN>";
-- =

2.5.0


--===============2666272089687110765==--

