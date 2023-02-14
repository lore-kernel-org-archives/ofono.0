Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF53D7C
	for <ofono@lists.linux.dev>; Tue, 14 Feb 2023 08:55:01 +0000 (UTC)
Received: by mail-lf1-f54.google.com with SMTP id f34so22483405lfv.10
        for <ofono@lists.linux.dev>; Tue, 14 Feb 2023 00:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shruggie-ro.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m+0320z8uWrBADHgdf9gwizCdHfCSjzzgPRWMhaJw9Q=;
        b=XdqWh301bJKdwzK8IFPaxipwmLSbakY2vo5hQCVKc5sQeY4FOVimvQGMcZL3voXff4
         PPO2Crb4H6Huvw+ULv7XTLMv+QIMkXfWbjkEqeS09esZvv5LY0Qo/7qqF8rPGwoJJd4A
         Ik+svewWle4ZvtjzIm09WIR0PkozG2VAIAZxnC5djEfRycWLsUKBBWWhVvCF7ionm+9s
         88BBYYzRZvX5t+ZF/mH9Q9x0alz53lEXEVAj1y6x9N3xMj/EP4i2SVym+8JRqGGAl7x3
         wnLrZDVRpI9Sir+br45LJcHQFv/cGK9FzUZTBgoNy8ExwJirKzW26fiocARKKHKC/U0H
         VR6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m+0320z8uWrBADHgdf9gwizCdHfCSjzzgPRWMhaJw9Q=;
        b=w462tM8XuTp4G7orphrWZE1Lmnbqs0h65nFlkv9ZLTlOdkfH1+ZIu/wanuulns3unB
         Le60Vn62Bm49KQKVgKaJvY0Rhh8264Eo/DEzK/enGVSmH7JJSeXclB+cl2vcs0OppPdA
         9BAVR84k3Na67sECig6PHpvkg1Cshl+BU5cbmVY6P0PsPiRFWoXOrVnhQwW6U8w9bEuG
         rzRRVv8RAzEYM9slFb+lQEVg1BkyWsWfYHowFoaSSF9Z1PAl6DMMEBRpCuvqZJvk/LzF
         /hMeBVVaiBoRarEhplXwMBtNw79nxLhRCYDQ+mn7JSWjQr3U0HxrhMSSQRPGu79h8jeb
         MiAQ==
X-Gm-Message-State: AO0yUKVukSkg4p6aLcdVoGxObtG64OUFx0OXiTPI97tDKMX+uuI+Ba5+
	ybX4JlpXYDQUtK3/bTzrY5kR/7xm/wUWxDFTLHc/9w==
X-Google-Smtp-Source: AK7set+HgQSzOhi6599gymmJ8dRN0JN8Yz30QzoiLmjp6qEbWhSgSnPx09n4GJdUcd0P9j2xqDGPeODtyvdP3qNjlf8=
X-Received: by 2002:a05:6512:3b9a:b0:4d5:ca42:aee1 with SMTP id
 g26-20020a0565123b9a00b004d5ca42aee1mr181469lfv.1.1676364899893; Tue, 14 Feb
 2023 00:54:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230211181105.7220-1-alex@shruggie.ro> <20230211181105.7220-2-alex@shruggie.ro>
 <4c80ab10-a640-682c-f397-b48509a204ee@gmail.com>
In-Reply-To: <4c80ab10-a640-682c-f397-b48509a204ee@gmail.com>
From: Alexandru Ardelean <alex@shruggie.ro>
Date: Tue, 14 Feb 2023 10:54:48 +0200
Message-ID: <CAH3L5Qr7LNSHEv7N3B1JC7_vnbiiruxZd+x_-GxU+Yo4XvJkpQ@mail.gmail.com>
Subject: Re: [RESEND PATCH 1/5] atmodem: gprs-context: fix ATD99 init for
 modems with no slave channel
To: Denis Kenzior <denkenz@gmail.com>
Cc: ofono@lists.linux.dev, patrick.frick@stihl.de, matthias.gruhler@stihl.de, 
	mircea.caprioru@flowkernel.ro, stephanie.altenburg@stihl.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 13, 2023 at 6:27 PM Denis Kenzior <denkenz@gmail.com> wrote:
>
> Hi Alexandru,
>
> On 2/11/23 12:11, Alexandru Ardelean wrote:
> > From: Mircea Caprioru <mircea.caprioru@flowkernel.ro>
> >
> > Patch 476fab4ea ("atmodem: Add support for NW DEACT notifications on sl=
ave
> > channel") has added a check to make sure we have a slave channel before
> > registering for "+CGEV:" notifications.
> >
> > Patch 8e929df4f ("atmodem: use ATD99 to enter data state when needed") =
has
> > added the ATD99 detection after the slave channel check.
> >
> > In our case, when we get a modem with no slave channels, the ATD99
> > detection will not get triggered and modems will use the AT+CGDATA=3D"P=
PP"
> > method for connecting to the internet (when ATD99 would be supported).
> >
> > This patch moves the check a bit lower in the code and removes the
> > early-return, to avoid for any potential future errors.
>

So, broader context.
We're still learning how ofono works/operates.
Things are not quite all-the-way-clear to us, because we are reading
the BG95 AT command manual (which is =C2=AF\_(=E3=83=84)_/=C2=AF ), and try=
ing to
fill-in-the-blanks (in our heads) about how ofono does it.

> So how exactly do you detect context deactivations?  The "atmodem" grps-c=
ontext
> driver is really not setup to work without a second port that is availabl=
e for
> AT commands.

Hmm, that is actually an interesting point.
The idea of the slave-channel being required, seems to have slipped me.
I will need to chase this in the quectel driver.
Thanks for the hint :)
It's quite probable that our patches (for BG95 support) are not very
good either.

>
> > ---
> >   drivers/atmodem/gprs-context.c | 8 +++-----
> >   1 file changed, 3 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/atmodem/gprs-context.c b/drivers/atmodem/gprs-cont=
ext.c
> > index f9f3c0ab..efc3fe94 100644
> > --- a/drivers/atmodem/gprs-context.c
> > +++ b/drivers/atmodem/gprs-context.c
> > @@ -449,10 +449,6 @@ static int at_gprs_context_probe(struct ofono_gprs=
_context *gc,
> >
> >       ofono_gprs_context_set_data(gc, gcd);
> >
> > -     chat =3D g_at_chat_get_slave(gcd->chat);
> > -     if (chat =3D=3D NULL)
> > -             return 0;
> > -
> >       switch (vendor) {
> >       case OFONO_VENDOR_SIMCOM_SIM900:
> >               gcd->use_atd99 =3D FALSE;
> > @@ -462,7 +458,9 @@ static int at_gprs_context_probe(struct ofono_gprs_=
context *gc,
> >                                               at_cgdata_test_cb, gc, NU=
LL);
> >       }
> >
> > -     g_at_chat_register(chat, "+CGEV:", cgev_notify, FALSE, gc, NULL);
> > +     chat =3D g_at_chat_get_slave(gcd->chat);
> > +     if (chat !=3D NULL)
> > +             g_at_chat_register(chat, "+CGEV:", cgev_notify, FALSE, gc=
, NULL);
>
> I think this goes over 80 characters / line.

ah, right;
will fix this if thi patch will not go away

>
> >
> >       return 0;
> >   }
>
> Regards,
> -Denis
