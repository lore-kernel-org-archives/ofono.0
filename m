Content-Type: multipart/mixed; boundary="===============6013982712567935272=="
MIME-Version: 1.0
From: Sergey Matyukevich <geomatsi@gmail.com>
Subject: Re: [RFC PATCH 4/4] plugins: gemalto: fix incomplete at-chat shutdown
Date: Mon, 17 Aug 2020 23:22:21 +0300
Message-ID: <20200817202221.GA11982@curiosity>
In-Reply-To: <48bb7b40-94b1-55a1-22f4-015a382f35ac@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6013982712567935272==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Denis,

> > Function gemalto_modem_ready attempts to restart AT chat data->app
> > after  incomplete shutdown. As a result, new AT chat does not work
> > as expected loosing AT commands.
> > =

> > Signed-off-by: Sergey Matyukevich <geomatsi@gmail.com>
> > ---
> >   plugins/gemalto.c | 8 ++++++++
> >   1 file changed, 8 insertions(+)
> =

> Patch 2, 3 look good to me.
> =

> For this one, what is it trying to do actually?
> =


Thanks for review. I will re-send second revision of the patches 1-3
with minor changes according to review comments.

Concerning the 4th patch, I thought the problem was in the incomplete
cleanup on data->app re-open in gemalto_modem_ready function. However
this is not the case. Sometimes, in particular on cold start, modem
is not really ready even after it sends ^SYSSTART. As a result,
subsequent AT+CFUN=3D4 command never completes. I have been experimenting
with the same approach as in ublox plugin with much better results.
So I will complete my experiments and send new fix in a separate patch.

Regards,
Sergey
--===============6013982712567935272==--

