Content-Type: multipart/mixed; boundary="===============2429850339996834769=="
MIME-Version: 1.0
From: Lars Poeschel <poeschel@lemonage.de>
Subject: Re: [PATCH v3] quectel: EC21 needs aux channel to be the first mux
 channel
Date: Fri, 24 Jul 2020 13:02:09 +0200
Message-ID: <20200724110209.qwijmpzjv6nioeqt@lem-wkst-02.lemonage>
In-Reply-To: <094c8640-d1d8-7340-1de1-5b6aad31dff5@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2429850339996834769==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2020 at 10:22:46PM -0500, Denis Kenzior wrote:
> Hi Lars,
> =

> On 5/29/20 7:43 AM, poeschel(a)lemonage.de wrote:
> > From: Lars Poeschel <poeschel@lemonage.de>
> > =

> > The Quectel EC21 does only work correctly, if the mux channel used for
> > aux is the first mux channel. It does only put it's URC messages in the
> > first mux channel, so this has to be the aux channel in our case.
> > To be flexible on the mux order we introduce two arrays here, that then
> > contain the initialization data in their needed order.
> > Initialization data is then applied by for-looping over this array.
> > ---
> >   plugins/quectel.c | 61 ++++++++++++++++++++++++++++++++++++-----------
> >   1 file changed, 47 insertions(+), 14 deletions(-)
> > =

> =

> Applied, thanks.

Unfortunately I must come back to this issue.
I got hands on a few new EC21s here and guess what ?
The mux order is back to the original one again. This means, the aux
channel has to be the second channel.
So I did a bit of investigation why and when this happened. But
information is rare.
The modems I originally worked on and created the patch for have
Firmware EC21EFAR06A01M4G_BETA0318. (Reversed mux order)
The new ones do have version EC21EFAR06A03M4G. (original mux order)
I know that there was a version EC21EFAR02A02M4G that did not support
cmux at all.
Due to some Quectel Confidential Document in a firmware version
"R02A03" some bug was fixed in cmux, so cmux must be in there since
then.
The EC21EFAR06A01M4G_BETA0318 that I have is dated inbetween
EC21EFAR02A02M4G and this "R02A03".
The mux order must have changed between EC21EFAR06A01M4G_BETA0318 and
EC21EFAR06A03M4G.
I suspect (without knowing for sure) due to the beta-nature of my
firmware, that this is the only firmware with reversed mux order and
that they changed it after that and "R02A03" up until
EC21EFAR06A03M4G share the same original mux order. According to Quectel
the EC21EFAR06A01M4G_BETA0318 firmware I have here is not "out in the
wild". The modems I have here are the only ones with this firmware.

So my question is what's best to do now ?

I feel the best would be to revert this patch. I am very sorry for this.
New modems will work and I suspect old modems "out in the wild" will
work also. I don't care about supporting the few "BETA0318" modems I
have here.

Another way would be to leave this patch and implement some firmware
switch and use reversed mux order for the "BETA0318" only I have and use
normal original mux order for all other cases.

What do you think?

Thank you,
Lars
--===============2429850339996834769==--

