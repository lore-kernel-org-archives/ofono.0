Content-Type: multipart/mixed; boundary="===============4246325109287174141=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 1/9] include: define initializer for ofono_call
Date: Tue, 01 Feb 2011 15:12:42 -0200
Message-ID: <1296580370-2823-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4246325109287174141==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Some fields in struct ofono_call such as cnap_validity and clip_validity
are not correctly initialized as 0 since this means they are present. If
driver does not implement the necessary handlers, it might send to core
an ofono_call signalling that cnap and clip are available when they are
actually not.
---
 include/types.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/types.h b/include/types.h
index 0faff54..31f2682 100644
--- a/include/types.h
+++ b/include/types.h
@@ -116,6 +116,7 @@ struct ofono_uuid {
 };
 =

 const char *ofono_uuid_to_str(const struct ofono_uuid *uuid);
+void ofono_call_init(struct ofono_call *call);
 =

 #ifdef __cplusplus
 }
-- =

1.7.4


--===============4246325109287174141==--

