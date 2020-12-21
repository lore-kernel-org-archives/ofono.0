Content-Type: multipart/mixed; boundary="===============4434082848074088922=="
MIME-Version: 1.0
From: Sergey Matyukevich <geomatsi@gmail.com>
Subject: [PATCH 2/5] gemalto: gprs: cgev gprs context deactivation
Date: Mon, 21 Dec 2020 23:01:30 +0300
Message-ID: <20201221200133.522933-3-geomatsi@gmail.com>
In-Reply-To: <20201221200133.522933-1-geomatsi@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4434082848074088922==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Gemalto ELS81x modems use 'ME PDN DEACT' message to notify about gprs
context deactivation. Process this 'deactivate' event in CGEV handler.
---
 drivers/gemaltomodem/gprs-context.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gemaltomodem/gprs-context.c b/drivers/gemaltomodem/gpr=
s-context.c
index 73cf81a8..322a5f98 100644
--- a/drivers/gemaltomodem/gprs-context.c
+++ b/drivers/gemaltomodem/gprs-context.c
@@ -216,6 +216,8 @@ static void cgev_notify(GAtResult *result, gpointer use=
r_data)
 =

 	if (g_str_has_prefix(event, "NW PDN DEACT"))
 		sscanf(event, "%*s %*s %*s %u", &cid);
+	else if (g_str_has_prefix(event, "ME PDN DEACT"))
+		sscanf(event, "%*s %*s %*s %u", &cid);
 	else if (g_str_has_prefix(event, "NW DEACT"))
 		sscanf(event, "%*s %*s %u", &cid);
 	else
-- =

2.29.2

--===============4434082848074088922==--

