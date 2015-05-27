Content-Type: multipart/mixed; boundary="===============5408738244048614297=="
MIME-Version: 1.0
From: Mike Williams <mike@mikebwilliams.com>
Subject: Re: bug reactivating primary context?
Date: Wed, 27 May 2015 12:58:04 -0400
Message-ID: <CANPyyuOxb-vV6cVNA-oeHt1atNPGHPg_SPBGW3o8CUOvrVaJcw@mail.gmail.com>
In-Reply-To: <55649D69.40904@dynamicdevices.co.uk>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5408738244048614297==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Alex,

On Tue, May 26, 2015 at 12:20 PM, Alex J Lennon
<ajlennon@dynamicdevices.co.uk> wrote:
> Would you mind sharing the auto connection patch for cellular as we have
> been wondering here why configuring autoconnection didn't seem to make
> any difference?


It's actually a patch for connman, which needs cellular services set
with favorite=3Dtrue as well as autoconnect=3Dtrue before it will
automatically connect them. connman correctly parses 'cellular' out of
DefaultAutoConnectTechnologies and sets the autocorrect property for
cellular services, so this patch just sets those services' favorite
property to the autoconnect property when they are created.

I'm a complete beginner to the connman/ofono source code though, so
use this patch at your own risk :).

Mike


From 39a7e2849cb2f53bcc461d5cbf2ccc236e498dc9 Mon Sep 17 00:00:00 2001
From: Mike Williams <mike@mikebwilliams.com>
Date: Mon, 18 May 2015 14:44:00 -0400
Subject: [PATCH] cellular: allow autoconnecting if configured

---
src/service.c | 4 +++-
1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/service.c b/src/service.c
index 7243ea2..b14623c 100644
--- a/src/service.c
+++ b/src/service.c
@@ -6698,9 +6698,11 @@ struct connman_service *
__connman_service_create_from_network(struct connman_ne
       case CONNMAN_SERVICE_TYPE_VPN:
       case CONNMAN_SERVICE_TYPE_GADGET:
       case CONNMAN_SERVICE_TYPE_WIFI:
-       case CONNMAN_SERVICE_TYPE_CELLULAR:
       case CONNMAN_SERVICE_TYPE_P2P:
               break;
+       case CONNMAN_SERVICE_TYPE_CELLULAR:
+               service->favorite =3D service->autoconnect;
+               break;
       case CONNMAN_SERVICE_TYPE_ETHERNET:
               service->favorite =3D true;
               break;
--
2.1.4

--===============5408738244048614297==--

