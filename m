Content-Type: multipart/mixed; boundary="===============5415906193028488778=="
MIME-Version: 1.0
From: Daniel Oliveira Nascimento <don@syst.com.br>
Subject: Re: [PATCH 1/1] Huawei E176: Mark primary and secondary device at
 ofono.rules TODO: Fix sim_add detection, add E1552 idProduct to ofono.rules
Date: Mon, 31 May 2010 14:00:22 -0300
Message-ID: <201005311400.22934.don@syst.com.br>
In-Reply-To: <87d3wc2etx.fsf@potku.valot.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5415906193028488778==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I was testing this driver with Huawei E220 modem. Here it appears in port 1 =

too. I just patched ofono with the following patch and it works. But I don'=
t =

have a modem that appears in port 2 to test. In ModemManager [1] seems that =

they try to detect the second device in functions supports_device and =

probe_second_timeout, and it seems to be the best approach here too.

[1] http://cgit.freedesktop.org/ModemManager/ModemManager/tree/plugins/mm-
plugin-huawei.c

---
 plugins/udev.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/plugins/udev.c b/plugins/udev.c
index bdac4fd..fd67583 100644
--- a/plugins/udev.c
+++ b/plugins/udev.c
@@ -244,7 +244,7 @@ static void add_huawei(struct ofono_modem *modem,
 =

 		primary =3D 1;
 		ofono_modem_set_integer(modem, "PrimaryRegistered", primary);
-	} else if (g_strcmp0(num, "02") =3D=3D 0) {
+	} else {
 		if (secondary !=3D 0)
 			return;
 =

-- =

1.6.4.2



Em Seg 31 Mai 2010, =C3=A0s 13:52:58, Kalle Valo escreveu:
> Marcel Holtmann <marcel@holtmann.org> writes:
> > Hi Kalle,
> =

> Hallo Marcel,
> =

> >> I personally would prefer a solution which would dynamically probe the
> >> ports and choose them based on results. I believe modemmanager does
> >> something like this, but I haven't looked in detail.
> > =

> > we should do something like auto-detect at some point, but there are
> > limits in it.
> =

> So what's the best option to go forward?
> =

> And related to this, can we rely on the port numbering order provided by
> udev? For example, on my Huawei E1552 port 0 is the main chat port and
> port 2 is the "event" port. Is it certain that port numbering will be
> the same across all distributions and kernels?

--===============5415906193028488778==--

