Content-Type: multipart/mixed; boundary="===============0165017544421787451=="
MIME-Version: 1.0
From: Vijay Nayani <vijay.nayani@elektrobit.com>
Subject: [RFC PATCH 13/20] include: add get technology api
Date: Mon, 11 Apr 2011 13:20:11 +0300
Message-ID: <1302517218-2147-14-git-send-email-vijay.nayani@elektrobit.com>
In-Reply-To: <1302517218-2147-1-git-send-email-vijay.nayani@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0165017544421787451==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Added for the driver to be aware of the registered
technology
---
 include/packet-service.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/packet-service.h b/include/packet-service.h
index bc5eceb..d8cfd21 100644
--- a/include/packet-service.h
+++ b/include/packet-service.h
@@ -88,6 +88,8 @@ void ofono_packet_service_set_cid_range(struct ofono_pack=
et_service *ps,
 void ofono_packet_service_add_context(struct ofono_packet_service *ps,
 					struct ofono_packet_context *pc);
 =

+int ofono_packet_service_get_technology(struct ofono_packet_service *ps);
+
 #ifdef __cplusplus
 }
 #endif
-- =

1.7.0.4


--===============0165017544421787451==--

