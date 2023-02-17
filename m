Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAC8746A
	for <ofono@lists.linux.dev>; Fri, 17 Feb 2023 15:03:39 +0000 (UTC)
Received: by mail-lf1-f53.google.com with SMTP id d24so1923900lfs.8
        for <ofono@lists.linux.dev>; Fri, 17 Feb 2023 07:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shruggie-ro.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7bVQgDLnM8wr4XSCsf7b+FfJec8TD4vs0Es1P8nWzkw=;
        b=BWi5daA7p+DRK4xYD1FIDX9/+pMjBcLfKFg9n4M42gQ/ZHk0Jllx4RutmG3XUnxhSy
         vmmN248J2lmxgJnn+eeoUYLYc7m9FUxQrdoa9bZ51GKOnBTUueyqFqQX4/gOEGJ5y8qs
         iV9bKu6fCFrlXlYZabhZejv2jaVc6sq8/Gl+dJZ9oT1jFTbm1cogFgE4Dczz29n/cmVt
         DyKsoP8lXgFhrpcnTIbGvLg/eaAki5TrN5xTZWPtGCSNRXJdAbYUK3zWLqGAbqRQnHBV
         o0eo4wwkzFbzM9ZnxgddvzvTltd9cLjtMfCLRDriHpwX7RIU6mycKeHR7iKmblWjeFUT
         z8SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7bVQgDLnM8wr4XSCsf7b+FfJec8TD4vs0Es1P8nWzkw=;
        b=ajowgVjrTEmFHIpJR353iP03X9Ou1QvbNG77Bh3ueaLrb0y9hz+dII8+CA6+ME4DIL
         dq4dbbJtF9cdpD2NwJoHzN+ihEthw0bCcoDm0dN1e56WgWEzl8CHJmISiYKIxcHwUiBI
         mQbCDNmXZIaGrMHelcSifxw1brUZ5HUCq+ve1DI3P8zsKoupI1DgC3DYF61msEtLM1TN
         Or9nn8NSD0MZSdPijWNNGNVbh6jIOhjLikRUeGCVw7O78xZp9yQSqRqJv9KNu1lOAmJm
         pKPzFSmIaTqau7Sz0DtMsE2QwjUmoqFCRwXmxl0LOW4Ezs/vVoG856Mll6yahE3XXf9U
         vZ4w==
X-Gm-Message-State: AO0yUKWA1Dhwr7vaiQwwKyuwMFPCty5E5D8qgIKZnxDGjsupl5PSS3IQ
	mNpuEwXSb9w9bwy+908A7bgY+plmZf9jC3iHJdxxzw==
X-Google-Smtp-Source: AK7set8YgSwLdrBVXRmwOVPwg3TnHBsHYrMstNbYsgAUD7N73opng2KqCnEEhifTzCIj1HPLmcApucp4GhWDfVsb+aE=
X-Received: by 2002:ac2:4ac7:0:b0:4d5:ca32:7bba with SMTP id
 m7-20020ac24ac7000000b004d5ca327bbamr442166lfp.1.1676646217470; Fri, 17 Feb
 2023 07:03:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230211181105.7220-1-alex@shruggie.ro> <20230211181105.7220-3-alex@shruggie.ro>
 <3699f2d8-73a6-4f30-df66-af4f395ff54d@gmail.com>
In-Reply-To: <3699f2d8-73a6-4f30-df66-af4f395ff54d@gmail.com>
From: Alexandru Ardelean <alex@shruggie.ro>
Date: Fri, 17 Feb 2023 17:03:25 +0200
Message-ID: <CAH3L5QoTe__tq9geKgUWYdXSO=5YF+7ysAHiKCd-Pn6Pvr2o+Q@mail.gmail.com>
Subject: Re: [RESEND PATCH 2/5] gprs: rework have_active_contexts() to check
 for non-active contexts
To: Denis Kenzior <denkenz@gmail.com>
Cc: ofono@lists.linux.dev, patrick.frick@stihl.de, matthias.gruhler@stihl.de, 
	mircea.caprioru@flowkernel.ro, stephanie.altenburg@stihl.de
Content-Type: text/plain; charset="UTF-8"

On Mon, Feb 13, 2023 at 6:46 PM Denis Kenzior <denkenz@gmail.com> wrote:
>
> Hi Alexandru,
>
> On 2/11/23 12:11, Alexandru Ardelean wrote:
> > While trying to add LTE support to the Quectel BG95-M3 modem, we've run
> > into a bit of a chicken-n-egg dilemma.
> >
> > While ofono has enumerated (successfully) the GPRS contexts (from the
> > modem), we got only one (IP), but it's not active.
> >
>
> How did it do that?

So, we get the context via the AT+CGDCONT=? command

Feb 17 16:43:04 imow1 ofonod[31380]: Aux: > AT+CGDCONT=?\r
Feb 17 16:43:04 imow1 ofonod[31380]: Aux: < \r\n+CGDCONT:
(1-15),"IP",,,(0-2),(0-4),(0)\r\n+CGDCONT:
(1-15),"PPP",,,(0-2),(0-4),(0)\r\n+CGDCONT:
(1-15),"IPV6",,,(0-2),(0-4),(0)\r\n+CGDCONT:
(1-15),"IPV4V6",,,(0-2),(0-4),(0)\r\n+CGDCONT:
(1-15),"Non-IP",,,(0-2),(0-4),(0)\r\n\r\nOK\r\n

I'll be honest, I did not check that this is parsed correctly by
ofono. I just assumed that this is correct.

When querying via DBus for the contexts

dbus-send --system --dest=org.ofono --type=method_call
--reply-timeout=120000 --print-reply /quectel_0
org.ofono.ConnectionManager.GetContexts

The output is

method return time=1676645265.639429 sender=:1.68 -> destination=:1.73
serial=101 reply_serial=2
   array [
      struct {
         object path "/quectel_0/context1"
         array [
            dict entry(
               string "Name"
               variant                   string "Internet"
            )
            dict entry(
               string "Active"
               variant                   boolean false
            )
            dict entry(
               string "Type"
               variant                   string "internet"
            )
            dict entry(
               string "Protocol"
               variant                   string "ip"
            )
            dict entry(
               string "AccessPointName"
               variant                   string "stihliaxx.tma.iot"
            )
            dict entry(
               string "Username"
               variant                   string ""
            )
            dict entry(
               string "Password"
               variant                   string ""
            )
            dict entry(
               string "AuthenticationMethod"
               variant                   string "chap"
            )
            dict entry(
               string "Settings"
               variant                   array [
                  ]
            )
            dict entry(
               string "IPv6.Settings"
               variant                   array [
                  ]
            )
         ]
      }
   ]


>
> > And trying to activate it, would yield a NotAttached error (via DBus).
> >

With the above context, we run this command:

dbus-send --system --dest=org.ofono --type=method_call
--reply-timeout=120000 --print-reply /quectel_0/context1
org.ofono.ConnectionContext.SetProperty string:Active
variant:boolean:true

-  When modem registers with an operator via GSM, this works
-  When the modem registers to an operator with LTE Cat M1, we get a
NotAttached (GRPS) error

> > The BG95-M3 modem supports Cat M1/Cat NB2/EGPRS LTE.
> >
> > This situation would show up when trying to connect to an operator that
> > only has "lte-cat-m1" tech (and nothing else). If it the operator would
> > also advertise "gsm" tech, ofono would connect via "gsm".
>
> I'm not really sure how lte-cat-m1 works.  With LTE the requirement was that for
> a successful network registration on LTE, a context had to be 'active'.  This
> can be an IP context or an IMS one, or any type really.  So just by merely being
> registered to LTE indicates that you're "attached".

So, at least in the BG95 case, the LTE context is not 'active' (already).
And the on_lte() function only checks EUTRAN, leaving Cat-M1 (or
NB-IoT) to be considered 'GSM' (or non-LTE).

>
> Now, this whole attached business is really for UMTS and avoiding data roaming.
> With LTE and newer technologies we should really redesign the API.  But that is
> quite a bit of work and oFono is in maintenance-only mode at the moment.
>

Hopefully this doesn't sound too bad (to ask): is there a better
alternative that you could recommend to oFono (given that it's in
maintenance-only mode) ?
We picked-up oFono because it's in Yocto.
Maybe oFono is fine for our needs, but I guess the issues with the
BG95 FW have made it more difficult than it needed to be.

> >
> > Now, this could be a particularity of this modem (BG95-M3), in which case
> > it may be an idea to add a hook into the quectel plugin/driver to check the
> > attached status.
> >
> > But for now, it seems that allowing the Attached state to be reported for
> > any present GPRS contexts (even non-active), seems to work.
>
> How do you figure that?  gprs->contexts can be populated via provisioning or
> D-Bus API.  So just the presence of these contexts means nothing for the
> attached status.

Oh, I did not know about gprs->contexts being populate-able via DBus API.
Well, checking the presence of contexts (regardless of whether they're
active) is what worked for us with LTE Cat M1.
I am not saying/insisting that this is correct.
I am also using this patch like an RFC (without specifying the tag).

Btw: we're also not sure how Cat M1 is supposed to work.
We're just relying on oFono to take that load from us
Since QMI is not working too well for our BG95 FW, we need to use the
atmodem driver for a while.

>
> >
> > For EUTRAN, this behavior is still maintained.
> > ---
> >   src/gprs.c | 16 ++++++++++++----
> >   1 file changed, 12 insertions(+), 4 deletions(-)
> >
>
> Regards,
> -Denis
>
