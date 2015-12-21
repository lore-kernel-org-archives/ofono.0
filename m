Content-Type: multipart/mixed; boundary="===============1463590995733389573=="
MIME-Version: 1.0
From: John Ernberg <john.ernberg@actia.se>
Subject: [PATCH] gprs: Make the ContextAdded return a variant.
Date: Mon, 21 Dec 2015 10:10:08 +0000
Message-ID: <1450692617-30003-1-git-send-email-john.ernberg@actia.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1463590995733389573==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: John Ernberg <john.ernberg@actia.se>

I am not sure if this is the desired way to resolve this issue. This will
break compatibility with Connman and possibly other systems using oFono
through D-Bus.

I do have a patch for Connman that I can send to them if this patch is
accepted, but not for any other potential systems.

It is also possible to change the introspection and the documentation,
the proposed patch is however more in line with the rest of oFono's
D-Bus API.

Discussion regarding this is encouraged before any possible acception
of this patch.

John Ernberg (1):
  gprs: Make the ContextAdded return a variant.

 src/gprs.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

-- =

1.9.1

--===============1463590995733389573==--

