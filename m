Content-Type: multipart/mixed; boundary="===============2422097043327836862=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v2 2/2] gatserver: Add NULL check to avoid crash
Date: Tue, 26 Jun 2012 10:12:59 +0200
Message-ID: <1340698379-22509-2-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1340698379-22509-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2422097043327836862==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Dundee is not waiting to receive the NO CARRIER notification
to close the IO channel with oFono so that oFono is trying to
send a NO CARRIER although GAtServer is removed.
---
 gatchat/gatserver.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/gatchat/gatserver.c b/gatchat/gatserver.c
index 7c87c7a..e3cbb8f 100644
--- a/gatchat/gatserver.c
+++ b/gatchat/gatserver.c
@@ -222,6 +222,9 @@ static inline void send_final_numeric(GAtServer *server=
, GAtServerResult result)
 =

 void g_at_server_send_final(GAtServer *server, GAtServerResult result)
 {
+	if (server =3D=3D NULL)
+		return;
+
 	if (server->final_sent !=3D FALSE)
 		return;
 =

-- =

1.7.5.4


--===============2422097043327836862==--

