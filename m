Content-Type: multipart/mixed; boundary="===============7652874659710901627=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH] set phonesim character set to GSM
Date: Wed, 15 Sep 2010 11:55:32 -0700
Message-ID: <1284576932-6502-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7652874659710901627==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/phonesim.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/plugins/phonesim.c b/plugins/phonesim.c
index d3caa20..7aa59ff 100644
--- a/plugins/phonesim.c
+++ b/plugins/phonesim.c
@@ -253,6 +253,8 @@ static int phonesim_enable(struct ofono_modem *modem)
 		data->chat =3D NULL;
 	}
 =

+	g_at_chat_send(data->chat, "AT+CSCS=3D\"GSM\"", none_prefix, NULL, NULL, =
NULL);
+
 	return 0;
 }
 =

-- =

1.7.0.4


--===============7652874659710901627==--

