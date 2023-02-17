Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EBA9446
	for <ofono@lists.linux.dev>; Fri, 17 Feb 2023 17:04:53 +0000 (UTC)
Received: by mail-lj1-f179.google.com with SMTP id r28so1809016ljk.1
        for <ofono@lists.linux.dev>; Fri, 17 Feb 2023 09:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shruggie-ro.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6vsOUsAGOia7JU7X2ma8oasKQTmpxbtX8xAaaSDWbnw=;
        b=OgEnOVBN4P7Vfuc0XiUW/cAcNgC6Hs0bZGP2F+CybVKTcMe3IRNr1nW02iqNSHmvcc
         4uuofIVTtksXqyBMQi9JJ5kx46VGGtcA7ceA4/WJq0LChua6G50XjSTgUpL2z96w3h0K
         g4rKwxAqO/vsm/TQaDvk2qUkzx368bqszUwiK8Eex77xH2ZwU4dvnJUTPtA16gPc+Ai8
         SaC1C6tkSV6JtXB93VAOxvM+drqoHDadHs+W/EIgTlRZMp1H06smDlaiXVqmKgyTTnSA
         qJmEfHuaKpvvdlTeHb8ENPuxANykRsm0thYa9t5Zxpu44aiKO7/k4Z9tvUI9yQ2LA62/
         M/Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6vsOUsAGOia7JU7X2ma8oasKQTmpxbtX8xAaaSDWbnw=;
        b=gIlQDmIC3NFvPJaekWtpF1xlZf2rFxi83pqlR6RGRoaVQxIh/UqIdKMsbfyNE/IHid
         ENDkErYCJJTBlzKpH3qANq582KtZcvh6CwIq3K4Uae72jDnCRmbMcMNQqw5birks3JuH
         H13zMu19zEaxPZTMTiwacrp3UxFnb3hsR/y1g+7sjHyYReVqHC2/q1T+Bwhh7ncS1Q8f
         RVfXELI9jU0CqtM9IOBTfB58x9W0GW/1gTz8bpdoEsNo2pyMnwzZR114Nt8VF0fO7rF/
         CDQANm2F+tY+aw/cZVidxPW3IM6xgNanVQrcSpXAXz6/5QGUuOqtAHZ2YdR4EUCXP8fs
         +2kA==
X-Gm-Message-State: AO0yUKXs67XKpzDokx2uKnRjzfLPtDFbdFwcbZOBUtT19Msggp6/zUlh
	BjMnRX5OcAONHs6pme/xGTVdFbh8aVR083RYz7gA5w==
X-Google-Smtp-Source: AK7set/LPjt3chs+qJlTKYZkTurVseCpBcMFwA7WjNmnw3uU26MHXJLSyHIMq0whrSE6tQAlS3R+kxxmYlow5wM1CE8=
X-Received: by 2002:a05:651c:1688:b0:293:4647:364a with SMTP id
 bd8-20020a05651c168800b002934647364amr592446ljb.3.1676653491815; Fri, 17 Feb
 2023 09:04:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230211181105.7220-1-alex@shruggie.ro> <20230211181105.7220-4-alex@shruggie.ro>
 <849beb97-9939-ae1d-a6e8-24dd66097ada@gmail.com>
In-Reply-To: <849beb97-9939-ae1d-a6e8-24dd66097ada@gmail.com>
From: Alexandru Ardelean <alex@shruggie.ro>
Date: Fri, 17 Feb 2023 19:04:40 +0200
Message-ID: <CAH3L5QpifTqU+UL6ic88YZ=yjuqc9u5_MbOn65Sbon2ENcyD7g@mail.gmail.com>
Subject: Re: [RESEND PATCH 3/5] gprs: extend on_lte() to check for M1 and
 Nb-IOT techs
To: Denis Kenzior <denkenz@gmail.com>
Cc: ofono@lists.linux.dev, patrick.frick@stihl.de, matthias.gruhler@stihl.de, 
	mircea.caprioru@flowkernel.ro, stephanie.altenburg@stihl.de
Content-Type: text/plain; charset="UTF-8"

On Mon, Feb 13, 2023 at 6:52 PM Denis Kenzior <denkenz@gmail.com> wrote:
>
> Hi Alexandru,
>
> On 2/11/23 12:11, Alexandru Ardelean wrote:
> > The BG95 is an LTE modem with Cat M1 and NB-IoT techs.
> > So, when it happens that the modem registers to one of these techs (in our
> > case Cat M1), and there is no GSM advertised by the operator, the modem
> > will not attach.
> >
>
> oFono doesn't really grok these technology types.  It must be taught to handle
> them properly.

Ack.
It's what we want to do.

>
> > Following the current logic of LTE, it looks like we just need to extend
> > the "on_lte()" function to allow for these techs.
>
> Or maybe treat them specially if they're not handled like LTE?

Ah.
So, I may be a bit confused here about what LTE refers to (or which
you are referring to).
To me LTE is EUTRAN, Cat M1 and NB-IoT.
But maybe, you are referring to LTE as just EUTRAN, and the others are
specific cases that need to be handled differently.
That is fine from my side.

>
> >
> > Also, not checking the .read_settings callback existence. That looks like a
> > hack done for EUTRAN. In our case, the BG95 is controlled by AT commands,
> > so there is no .read_settings hook yet, and we don't seem to need it.
>
> For LTE support, .read_settings must be implemented.  That is because you need
> to obtain the default context details (see my reply to the previous patch).
> This is needed for matching default context to provisioned ones, etc.

Will see maybe about this .read_settings hook.
Maybe we treat LTE Cat M1 entirely differently.
Who knows?
But if we do get QMI to work (at some point), then this is not required anymore.

>
> If NB_IOT* acts differently than LTE in this regard, then modifying on_lte() is
> probably not the right approach.

Hmmm.
So we don't use NB-IoT. It's a requirement (for us) to disable it.
We're just using LTE Cat M1.
I guess I put it there inertially after looking into the list of LTE enums.


>
> > ---
> >   src/gprs.c | 16 ++++++++++++----
> >   1 file changed, 12 insertions(+), 4 deletions(-)
> >
>
> Regards,
> -Denis
>
