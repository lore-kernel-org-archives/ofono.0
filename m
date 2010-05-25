Content-Type: multipart/mixed; boundary="===============4557956383158442408=="
MIME-Version: 1.0
From: Pekka Pessi <Pekka.Pessi@nokia.com>
Subject: [PATCH 3/4] isimodem: fix memory leak
Date: Tue, 25 May 2010 23:37:06 +0300
Message-ID: <1274819827-27993-3-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1274819827-27993-2-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4557956383158442408==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/isimodem/isimodem.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/isimodem/isimodem.c b/drivers/isimodem/isimodem.c
index 4085a55..9a5e87e 100644
--- a/drivers/isimodem/isimodem.c
+++ b/drivers/isimodem/isimodem.c
@@ -289,6 +289,7 @@ static void isi_modem_remove(struct ofono_modem *modem)
 =

 	ofono_modem_set_data(modem, NULL);
 	g_isi_client_destroy(isi->client);
+	g_pn_netlink_stop(isi->link);
 	g_free(isi);
 }
 =

-- =

1.6.3.3


--===============4557956383158442408==--

