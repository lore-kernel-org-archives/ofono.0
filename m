Content-Type: multipart/mixed; boundary="===============7772207717501866403=="
MIME-Version: 1.0
From: Christophe Ronco <c.ronco@kerlink.fr>
Subject: [PATCH 4/4] MC7430: fix QMI notification messages handling
Date: Wed, 28 Dec 2016 16:04:02 +0100
Message-ID: <20161228150402.15660-5-c.ronco@kerlink.fr>
In-Reply-To: <20161228150402.15660-1-c.ronco@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7772207717501866403==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

QMI notification messages handlers are never called on MC7430 without this =
fix.

drivers/qmimodem/qmi.c
 Do not test transaction id before calling notification handler.
 On MC7430, notification messages contain a not null transaction id
 (starts with 1, increased at each message for a particular client).
 On MC7304 transaction id in notification messages is always 0.
---
 drivers/qmimodem/qmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 3389bb1f..0080f250 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -758,7 +758,7 @@ static void handle_packet(struct qmi_device *device,
 =

 		tid =3D GUINT16_FROM_LE(service->transaction);
 =

-		if (service->type =3D=3D 0x04 && tid =3D=3D 0x0000) {
+		if (service->type =3D=3D 0x04) {
 			handle_indication(device, hdr->service, hdr->client,
 							message, length, data);
 			return;
-- =

2.11.0


--===============7772207717501866403==--

