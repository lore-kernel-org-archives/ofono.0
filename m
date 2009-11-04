Content-Type: multipart/mixed; boundary="===============6628318619448579850=="
MIME-Version: 1.0
From: Martin Xu <martin.xu@intel.com>
Subject: [PATCH 1/1] Use AT+CFUN? to query powered state
Date: Wed, 04 Nov 2009 17:14:20 +0800
Message-ID: <1257326060-11920-1-git-send-email-martin.xu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6628318619448579850==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/mbm.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/plugins/mbm.c b/plugins/mbm.c
index fd4569c..602709d 100644
--- a/plugins/mbm.c
+++ b/plugins/mbm.c
@@ -187,6 +187,9 @@ static int mbm_enable(struct ofono_modem *modem)
 					NULL, NULL, NULL);
 	g_at_chat_send(data->chat, "AT*EMRDY?", none_prefix, NULL, NULL, NULL);
 =

+	g_at_chat_send(data->chat, "AT+CFUN?", cfun_prefix,
+					cfun_query, modem, NULL);
+
 	return -EINPROGRESS;
 }
 =

-- =

1.6.1.3


--===============6628318619448579850==--

