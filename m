Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7017F
	for <ofono@lists.linux.dev>; Fri, 17 Feb 2023 07:25:14 +0000 (UTC)
Received: by mail-lj1-f178.google.com with SMTP id bx13so220638ljb.3
        for <ofono@lists.linux.dev>; Thu, 16 Feb 2023 23:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shruggie-ro.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UmouY2nCk2el4084S3TjG7ir1DGpNj2RsyWFS14hOOI=;
        b=HCCyWdY7YYNNz/AWP8SGiQZQ7gkPeyBDJq1OSJaY9gYDzBCnwBp4IEzhinsaaf5ztN
         SWwbJbKdQtW24wvYceonW2S0P5Tb8XHtRc6tM3OvhRVnymkDyh2W+ABZs3lO9RXLS6JR
         J1VwiHAu22wm013fTFMhgYVf4pi5BSTaoSV1AvU+fx4MLjtvhtwAmWfCEbjpoVDwQ3tU
         j9ErvgU4fqc8Hfd3vtJCjz1/EUwooRKWplXWBHaniKHtAGsGh+hb2RRzE4/+FpRIpVuF
         3oXVQIapBBeIy/8A1V1WicO5zJo7RXFP4eGrvDmSBoUgotxLIk4e43Y24Bwdd9RsP8/C
         KPig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UmouY2nCk2el4084S3TjG7ir1DGpNj2RsyWFS14hOOI=;
        b=lyzZ3Nee2UJtHCYIp8YOYZSocCcZqKeKrhhgbh7K5doziiNML8fq2neWLH2IomoyN7
         Oep5QrusOYk5gU0trj41hNVSJjtbp5F9pjeH+T0cA7YeMqcXBOwPB63baSk46qS7I/PG
         XItze3McyO5NDEy1iVT82ZS6QGYVydSJ7SjXVsYAWD5BkhXNjuAjZW6bkgh9JpLleAGE
         hdmyuYlnsL6Mgs2O2JnoOSVo3SE8eDrcPNb2xF2yvcsMNB+3iTnrGtRV8koAFojeyPE2
         cfXfUy+9yHel46WjSv+BIgAaH6AdjXhUgQCx4jaIIlhUsfHlTMfwM9D0EaDFr06anEYD
         3ciQ==
X-Gm-Message-State: AO0yUKUp8ikokWj7zpv7WyIMAUflUl63w3t6ovOoKu9HUK/RDh6MFnTl
	04au6vTSkCk0eWuhIxOIiSNw16blgKnC+w8/nsXbCA==
X-Google-Smtp-Source: AK7set8KI97bvTXaG5oO/xTQbyhKP5raOI7Sl1legeoo0dYiENVr8B5SWt21Y32VbKvWN+dSTwuh81zQzwg5wemX82o=
X-Received: by 2002:a05:651c:3d1:b0:294:764a:330d with SMTP id
 f17-20020a05651c03d100b00294764a330dmr206905ljp.3.1676618712237; Thu, 16 Feb
 2023 23:25:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230211181105.7220-1-alex@shruggie.ro> <20230211181105.7220-2-alex@shruggie.ro>
 <4c80ab10-a640-682c-f397-b48509a204ee@gmail.com> <CAH3L5Qr7LNSHEv7N3B1JC7_vnbiiruxZd+x_-GxU+Yo4XvJkpQ@mail.gmail.com>
In-Reply-To: <CAH3L5Qr7LNSHEv7N3B1JC7_vnbiiruxZd+x_-GxU+Yo4XvJkpQ@mail.gmail.com>
From: Alexandru Ardelean <alex@shruggie.ro>
Date: Fri, 17 Feb 2023 09:25:01 +0200
Message-ID: <CAH3L5QrM8akr3ChdmqAOLHNd5hTArTXkVcUHtz6MFH+5kT8Upg@mail.gmail.com>
Subject: Re: [RESEND PATCH 1/5] atmodem: gprs-context: fix ATD99 init for
 modems with no slave channel
To: Denis Kenzior <denkenz@gmail.com>
Cc: ofono@lists.linux.dev, patrick.frick@stihl.de, matthias.gruhler@stihl.de, 
	mircea.caprioru@flowkernel.ro, stephanie.altenburg@stihl.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 14, 2023 at 10:54 AM Alexandru Ardelean <alex@shruggie.ro> wrot=
e:
>
> On Mon, Feb 13, 2023 at 6:27 PM Denis Kenzior <denkenz@gmail.com> wrote:
> >
> > Hi Alexandru,
> >
> > On 2/11/23 12:11, Alexandru Ardelean wrote:
> > > From: Mircea Caprioru <mircea.caprioru@flowkernel.ro>
> > >
> > > Patch 476fab4ea ("atmodem: Add support for NW DEACT notifications on =
slave
> > > channel") has added a check to make sure we have a slave channel befo=
re
> > > registering for "+CGEV:" notifications.
> > >
> > > Patch 8e929df4f ("atmodem: use ATD99 to enter data state when needed"=
) has
> > > added the ATD99 detection after the slave channel check.
> > >
> > > In our case, when we get a modem with no slave channels, the ATD99
> > > detection will not get triggered and modems will use the AT+CGDATA=3D=
"PPP"
> > > method for connecting to the internet (when ATD99 would be supported)=
.
> > >
> > > This patch moves the check a bit lower in the code and removes the
> > > early-return, to avoid for any potential future errors.
> >
>
> So, broader context.
> We're still learning how ofono works/operates.
> Things are not quite all-the-way-clear to us, because we are reading
> the BG95 AT command manual (which is =C2=AF\_(=E3=83=84)_/=C2=AF ), and t=
rying to
> fill-in-the-blanks (in our heads) about how ofono does it.
>
> > So how exactly do you detect context deactivations?  The "atmodem" grps=
-context
> > driver is really not setup to work without a second port that is availa=
ble for
> > AT commands.
>
> Hmm, that is actually an interesting point.
> The idea of the slave-channel being required, seems to have slipped me.
> I will need to chase this in the quectel driver.
> Thanks for the hint :)
> It's quite probable that our patches (for BG95 support) are not very
> good either.

Firstly, thanks for the trigger/hint about the second AT port.
We did a thorough check about that. (Well, at least I hope it was thorough =
:p )
And we ended up searching the Quectel forum (no idea why that didn't
come to mind sooner).

So, it seems we have an issue with our current modem FW.
It may be too old and we need to update it, to have things running smoother=
.
The kernel 'option' driver enumerates 4 /dev/ttyUSB{0,1,2,3} ports.
One thing that was confusing (for me at least), is, (in oFono) the Aux
port feels more like Modem port in the context of the atmodem driver +
quectel driver (and at least for BG95). But that's just semantic
probably.

So

/dev/ttyUSB0 - Diag
/dev/ttyUSB1 - GNSS
/dev/ttyUSB2 - AT commands (in oFono this is 'Aux')
/dev/ttyUSB3 - AT commands (in oFono this is 'Modem')

In our case, /dev/ttyUSB3 doesn't seem to respond to any AT command,
though it should.
Hence the suspicion that we need to update the modem FW.
Luckily, we have a serial /dev/ttySTM3 port, which we can temporarily
use to get URCs (context DEACT and such).

The thing about /dev/ttyUSB3 is that there is an AT command (which
incidentally) is not in our modem FW that makes the port behave like
an AT modem port, an RmNet port, or an ECM port.
We'll see what we'll do with this.

I will try to respond to the rest of the comments (in the series).
Apologies that I did not do that sooner.
We were really chasing this comment (which really helped).

For now, this BG95 patchset will need to be discarded (in the light of
the modem FW stuff).

Many thanks :)
Alexandru


>
> >
> > > ---
> > >   drivers/atmodem/gprs-context.c | 8 +++-----
> > >   1 file changed, 3 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/atmodem/gprs-context.c b/drivers/atmodem/gprs-co=
ntext.c
> > > index f9f3c0ab..efc3fe94 100644
> > > --- a/drivers/atmodem/gprs-context.c
> > > +++ b/drivers/atmodem/gprs-context.c
> > > @@ -449,10 +449,6 @@ static int at_gprs_context_probe(struct ofono_gp=
rs_context *gc,
> > >
> > >       ofono_gprs_context_set_data(gc, gcd);
> > >
> > > -     chat =3D g_at_chat_get_slave(gcd->chat);
> > > -     if (chat =3D=3D NULL)
> > > -             return 0;
> > > -
> > >       switch (vendor) {
> > >       case OFONO_VENDOR_SIMCOM_SIM900:
> > >               gcd->use_atd99 =3D FALSE;
> > > @@ -462,7 +458,9 @@ static int at_gprs_context_probe(struct ofono_gpr=
s_context *gc,
> > >                                               at_cgdata_test_cb, gc, =
NULL);
> > >       }
> > >
> > > -     g_at_chat_register(chat, "+CGEV:", cgev_notify, FALSE, gc, NULL=
);
> > > +     chat =3D g_at_chat_get_slave(gcd->chat);
> > > +     if (chat !=3D NULL)
> > > +             g_at_chat_register(chat, "+CGEV:", cgev_notify, FALSE, =
gc, NULL);
> >
> > I think this goes over 80 characters / line.
>
> ah, right;
> will fix this if thi patch will not go away
>
> >
> > >
> > >       return 0;
> > >   }
> >
> > Regards,
> > -Denis
