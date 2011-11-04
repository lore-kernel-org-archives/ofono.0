Content-Type: multipart/mixed; boundary="===============2080395175081420987=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v3 4/4] cdmamodem: Notify when connection is lost
Date: Fri, 04 Nov 2011 16:28:07 +0100
Message-ID: <1320420487-16334-5-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1320420487-16334-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2080395175081420987==
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


--===============2080395175081420987==--

