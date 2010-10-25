Content-Type: multipart/mixed; boundary="===============2029798865938325258=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Beno=C3=AEt?= Monin <benoit.monin@gmx.fr>
Subject: Re: [PATCH] hso: Set modem name based on udev network interface name
Date: Mon, 25 Oct 2010 11:13:28 +0200
Message-ID: <20101025091609.178830@gmx.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2029798865938325258==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> De : Denis Kenzior
> =

> Hi Beno=C3=AEt,
> =

> I prefer you do this in plugins/hso and not in udev.
> =

Is the patch below correct ? I moved the call to set_name
to hso_probe.

Beno=C3=AEt
--
Subject: [PATCH] hso: Set modem name based on udev network interface name

Useful if you have multiple identical modems and you need a way
to know which modem you're talking to.
---
 plugins/hso.c | =C2=A0 =C2=A06 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/plugins/hso.c b/plugins/hso.c
index 055c63b..a9fb1ba 100644
--- a/plugins/hso.c
+++ b/plugins/hso.c
@@ -59,6 +59,7 @@ struct hso_data {
 static int hso_probe(struct ofono_modem *modem)
 {
 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct hso_data *data;
+ =C2=A0 =C2=A0 =C2=A0 const char *interface;

 =C2=A0 =C2=A0 =C2=A0 =C2=A0DBG("%p", modem);

@@ -68,6 +69,11 @@ static int hso_probe(struct ofono_modem *modem)

 =C2=A0 =C2=A0 =C2=A0 =C2=A0ofono_modem_set_data(modem, data);

+ =C2=A0 =C2=A0 =C2=A0 /* Set name based on network interface name */
+ =C2=A0 =C2=A0 =C2=A0 interface =3D ofono_modem_get_string(modem, "Network=
Interface");
+ =C2=A0 =C2=A0 =C2=A0 if (interface)
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ofono_modem_set_name(mod=
em, interface);
+
 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
 }

--

--===============2029798865938325258==--

