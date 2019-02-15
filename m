Content-Type: multipart/mixed; boundary="===============3914139217725853168=="
MIME-Version: 1.0
From: philippedeswert@gmail.com
Subject: [PATCH 3/8] gprs.h: Add ofono_gprs_get_netreg function
Date: Fri, 15 Feb 2019 14:11:37 +0200
Message-ID: <20190215121142.28163-4-philippedeswert@gmail.com>
In-Reply-To: <20190215121142.28163-1-philippedeswert@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3914139217725853168==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Tommi Rekosuo <tommi.rekosuo@treon.fi>

Add function to get registration technology.
---
 include/gprs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/gprs.h b/include/gprs.h
index 988d6102..eaf9f2de 100644
--- a/include/gprs.h
+++ b/include/gprs.h
@@ -62,6 +62,7 @@ void ofono_gprs_resume_notify(struct ofono_gprs *gprs);
 void ofono_gprs_bearer_notify(struct ofono_gprs *gprs, int bearer);
 =

 struct ofono_modem *ofono_gprs_get_modem(struct ofono_gprs *gprs);
+struct ofono_netreg *ofono_gprs_get_netreg(struct ofono_gprs *gprs);
 =

 int ofono_gprs_driver_register(const struct ofono_gprs_driver *d);
 void ofono_gprs_driver_unregister(const struct ofono_gprs_driver *d);
-- =

2.20.1


--===============3914139217725853168==--

