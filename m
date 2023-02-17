Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118CB7F
	for <ofono@lists.linux.dev>; Fri, 17 Feb 2023 16:52:10 +0000 (UTC)
Received: by mail-lj1-f175.google.com with SMTP id f3so1504148ljn.12
        for <ofono@lists.linux.dev>; Fri, 17 Feb 2023 08:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shruggie-ro.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IxZlNS1U5MMpfmFTC7f99y4jbBJZNjV8sp2SEuzMa1s=;
        b=f+Ci+qvxWURkhgVXOMI/7IGzVKr7klMNGcHXlWnoZbDGiGixoHAqP6HiOsCNQMhW8N
         DncmI6QSwtJ07v3edsPVLG0YNHSZIjzpP96bM7InnUb+3UWUV7xgSUEq/rFXFJgnJzHC
         6qjCkr1wsVnhCkXduzumqVHREQ5Zj8gNl4TsuOlpUB0fyGRTNA6zIYUfKJMOHg2p3wN9
         n4RcVbwNLn44RYWbzfB9di5Sk4ktjqWnK6N21Y8slq2FclqDt+dghtkRtRcjUhFHpoqM
         44zYcwGjMxrqCI+lQ5WCFjWUtgQNI9jAds6XKAH29AI0dzwJDgkswfe+W40CoYZqtQYi
         6VVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IxZlNS1U5MMpfmFTC7f99y4jbBJZNjV8sp2SEuzMa1s=;
        b=cBDUEz0pwOhQFzF3E/UzFWCcClk6GEqCGBVrDTga4QHAQpMmDsz3qaUiKfp7Bt6zP+
         TU8UxYIwPuw06vDi0jZB/R4DM//JQY9DLy886oqa3JV99G8tqtT/Uvdu1ZGeT9Du12BI
         iBJLZPuu044xs/dKXLlLolUJ7AdeBcG9Ly65v5o7yyYH7RBqfUED3Z5v/I0no5IDeQ27
         3+ekFDjjFAftboQLjHTkycZZxK3Vns14IYKpAIK/WPG7KFtSu0gHrceFtiq5aUvy+djd
         fUJcb9+9eAHrvFQdOqoy2HzB0xzfBMZXBU+3F8e+ExjrMPE9Co7PPIzK9MZJlL3a1Gra
         1cgw==
X-Gm-Message-State: AO0yUKU4Vociv+IVCYWdawYYHVu5SvJgMFSHc3xYCxfsIY76uX2PbwhK
	PZMpbPGYon45Snc00GmRDGwAc/ouf5Az+ulOxH2YaA==
X-Google-Smtp-Source: AK7set+l76z08n4me+WNyUn3z/gmFiQ7oYsqC0nMp7qu67Es5QmcvqsFAtUKwxyOrbjuwfU+gx9C7gB85Gb8tiq6gkM=
X-Received: by 2002:a05:651c:11cd:b0:293:39fe:b712 with SMTP id
 z13-20020a05651c11cd00b0029339feb712mr614923ljo.3.1676652728979; Fri, 17 Feb
 2023 08:52:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230211181105.7220-1-alex@shruggie.ro> <20230211181105.7220-3-alex@shruggie.ro>
 <3699f2d8-73a6-4f30-df66-af4f395ff54d@gmail.com> <CAH3L5QoTe__tq9geKgUWYdXSO=5YF+7ysAHiKCd-Pn6Pvr2o+Q@mail.gmail.com>
 <0f136da4-e5eb-95cb-729f-f19b2db067cf@gmail.com>
In-Reply-To: <0f136da4-e5eb-95cb-729f-f19b2db067cf@gmail.com>
From: Alexandru Ardelean <alex@shruggie.ro>
Date: Fri, 17 Feb 2023 18:51:58 +0200
Message-ID: <CAH3L5QpFgk4EeoaWk4vP=JaX0ie9VYegQX25XyU51P6-oF1O9w@mail.gmail.com>
Subject: Re: [RESEND PATCH 2/5] gprs: rework have_active_contexts() to check
 for non-active contexts
To: Denis Kenzior <denkenz@gmail.com>
Cc: ofono@lists.linux.dev, patrick.frick@stihl.de, matthias.gruhler@stihl.de, 
	mircea.caprioru@flowkernel.ro, stephanie.altenburg@stihl.de
Content-Type: text/plain; charset="UTF-8"

On Fri, Feb 17, 2023 at 5:23 PM Denis Kenzior <denkenz@gmail.com> wrote:
>
> Hi Alexandru,
>
> On 2/17/23 09:03, Alexandru Ardelean wrote:
> > On Mon, Feb 13, 2023 at 6:46 PM Denis Kenzior <denkenz@gmail.com> wrote:
> >>
> >> Hi Alexandru,
> >>
> >> On 2/11/23 12:11, Alexandru Ardelean wrote:
> >>> While trying to add LTE support to the Quectel BG95-M3 modem, we've run
> >>> into a bit of a chicken-n-egg dilemma.
> >>>
> >>> While ofono has enumerated (successfully) the GPRS contexts (from the
> >>> modem), we got only one (IP), but it's not active.
> >>>
> >>
> >> How did it do that?
> >
> > So, we get the context via the AT+CGDCONT=? command
> >
> > Feb 17 16:43:04 imow1 ofonod[31380]: Aux: > AT+CGDCONT=?\r
> > Feb 17 16:43:04 imow1 ofonod[31380]: Aux: < \r\n+CGDCONT:
> > (1-15),"IP",,,(0-2),(0-4),(0)\r\n+CGDCONT:
> > (1-15),"PPP",,,(0-2),(0-4),(0)\r\n+CGDCONT:
> > (1-15),"IPV6",,,(0-2),(0-4),(0)\r\n+CGDCONT:
> > (1-15),"IPV4V6",,,(0-2),(0-4),(0)\r\n+CGDCONT:
> > (1-15),"Non-IP",,,(0-2),(0-4),(0)\r\n\r\nOK\r\n
> >
>
> That's a capability check.  It just lists the context types supported by this
> modem, not the actual context definitions themselves.  Querying of the defined
> contexts would in theory be performed via 'AT+CGDCONT?'.  But oFono doesn't do
> this, it grabs the context settings via provisioning or the D-Bus API.
>
> > I'll be honest, I did not check that this is parsed correctly by
> > ofono. I just assumed that this is correct.
> >
> > When querying via DBus for the contexts
> >
> > dbus-send --system --dest=org.ofono --type=method_call
> > --reply-timeout=120000 --print-reply /quectel_0
> > org.ofono.ConnectionManager.GetContexts
> >
> > The output is
> >
> > method return time=1676645265.639429 sender=:1.68 -> destination=:1.73
> > serial=101 reply_serial=2
> >     array [
> >        struct {
> >           object path "/quectel_0/context1"
> >           array [
> >              dict entry(
> >                 string "Name"
> >                 variant                   string "Internet"
> >              )
> >              dict entry(
> >                 string "Active"
> >                 variant                   boolean false
> >              )
> >              dict entry(
> >                 string "Type"
> >                 variant                   string "internet"
> >              )
> >              dict entry(
> >                 string "Protocol"
> >                 variant                   string "ip"
> >              )
> >              dict entry(
> >                 string "AccessPointName"
> >                 variant                   string "stihliaxx.tma.iot"
> >              )
> >              dict entry(
> >                 string "Username"
> >                 variant                   string ""
> >              )
> >              dict entry(
> >                 string "Password"
> >                 variant                   string ""
> >              )
> >              dict entry(
> >                 string "AuthenticationMethod"
> >                 variant                   string "chap"
> >              )
> >              dict entry(
> >                 string "Settings"
> >                 variant                   array [
> >                    ]
> >              )
> >              dict entry(
> >                 string "IPv6.Settings"
> >                 variant                   array [
> >                    ]
> >              )
> >           ]
> >        }
> >     ]
> >
> >
>
> That looks like it is coming from a provisioning database.

Ah, will check.
If that's the case, then this patch can definitely be dropped.

>
> Regards,
> -Denis
