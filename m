Content-Type: multipart/mixed; boundary="===============6407552998619696183=="
MIME-Version: 1.0
From: Dragos Tatulea <dragos@endocode.com>
Subject: [PATCH 1/3] gprs.h: add api for reading access technology
Date: Sat, 12 Mar 2016 15:51:30 +0100
Message-ID: <1457794292-21184-2-git-send-email-dragos@endocode.com>
In-Reply-To: <1457794292-21184-1-git-send-email-dragos@endocode.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6407552998619696183==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/gprs.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/gprs.h b/include/gprs.h
index 8d2a260..ab2c5f8 100644
--- a/include/gprs.h
+++ b/include/gprs.h
@@ -75,6 +75,8 @@ void ofono_gprs_remove(struct ofono_gprs *gprs);
 void ofono_gprs_set_data(struct ofono_gprs *gprs, void *data);
 void *ofono_gprs_get_data(struct ofono_gprs *gprs);
 =

+int ofono_gprs_get_technology(struct ofono_gprs *gprs);
+
 void ofono_gprs_set_cid_range(struct ofono_gprs *gprs,
 				unsigned int min, unsigned int max);
 void ofono_gprs_add_context(struct ofono_gprs *gprs,
-- =

2.5.0


--===============6407552998619696183==--

