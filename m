Content-Type: multipart/mixed; boundary="===============3414548860165414586=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v2 6/6] cdmamodem: Notify when connection is lost
Date: Wed, 02 Nov 2011 11:38:01 +0100
Message-ID: <1320230281-20743-7-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1320230281-20743-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3414548860165414586==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/cdmamodem/connman.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/cdmamodem/connman.c b/drivers/cdmamodem/connman.c
index 49f60ac..ec17e96 100644
--- a/drivers/cdmamodem/connman.c
+++ b/drivers/cdmamodem/connman.c
@@ -116,7 +116,7 @@ static void ppp_disconnect(GAtPPPDisconnectReason reaso=
n, gpointer user_data)
 		CALLBACK_WITH_SUCCESS(cd->down_cb, cd->cb_data);
 		break;
 	default:
-		/* TODO: Handle network initiated disconnection */
+		ofono_cdma_connman_deactivated(cm);
 		break;
 	}
 =

-- =

1.7.1


--===============3414548860165414586==--

