Content-Type: multipart/mixed; boundary="===============8094303192449484974=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 4/4] test: update the cell broadcast property
Date: Fri, 25 Feb 2011 08:32:23 -0800
Message-ID: <1298651543-9752-5-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1298651543-9752-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8094303192449484974==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 test/monitor-ofono |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/test/monitor-ofono b/test/monitor-ofono
index 8570c34..b803aa2 100755
--- a/test/monitor-ofono
+++ b/test/monitor-ofono
@@ -161,7 +161,7 @@ if __name__ =3D=3D '__main__':
 						path_keyword=3D"path",
 						interface_keyword=3D"interface")
 =

-	for member in ["IncomingBroadcast", "EmergencyBroadcast",
+	for member in ["IncomingBroadcast", "WarningSystemBroadcast",
 			"IncomingMessage", "ImmediateMessage"]:
 		bus.add_signal_receiver(message,
 					bus_name=3D"org.ofono",
-- =

1.7.0.4


--===============8094303192449484974==--

