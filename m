Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EBA7F
	for <ofono@lists.linux.dev>; Fri, 17 Feb 2023 16:51:04 +0000 (UTC)
Received: by mail-lj1-f182.google.com with SMTP id y20so1823112ljc.0
        for <ofono@lists.linux.dev>; Fri, 17 Feb 2023 08:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shruggie-ro.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4z5IhkZY/wB7S6uFP5qmTPLPl1MnGoxig0YSS5ZnqaE=;
        b=q1dhw8LGNHU/affzFekI1TVjzRHsjaTl6VDMIJ+ATiF8Fld03l8Ki2/tthPpgqdB+/
         dtbpvXsEV26ur0WTotBUzlpTXNdw7m7k0LDnv2w4VM2+fZouReBQwBpDSJKwyBVecvUU
         nqN8GtMCb33sIKmrevdNJwV/uohGryvUR+yfdYSlrA9Ap+grJla+7sE4aAOBimCUN7Rc
         3JIqTswKV7AFLd+paxy5FJG11UU+61DzFfNOgkwsyWVa1rrLEyhe9oTduFculGpCQ8ar
         m54OwGnC2wkfIt5oVveqdIM+z2ibPBtE0C2gSnoOPtfivtEmrOoscqp5dVw/EgGkCcm+
         h20w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4z5IhkZY/wB7S6uFP5qmTPLPl1MnGoxig0YSS5ZnqaE=;
        b=GnO/ZL3NDWwJlDGya8W/ISpagQmWiX07e9aVgbVby1NBFfaaSuyIA4imeEJH4sIUib
         XlmRZmRjFBhG2ML0C04IKq+8wktSC8NoIrf80wE/T0DzOOw0fBP2+P0pYBwUXYZ4bz5y
         N96/qT0XEDaxCI8uF6kJotew5+ZvBu+Hn13hNrY/FozUIY7bdfAz1PlnvCugi9uxy+ZB
         ypQhM6C9Tb3kh2xAj2ifL/RO3KEJQ4hCBUXCpeIKcmdpdSl9UgsA4CjCpvK4+i/4BjNh
         a9Y3UUefPXsBNMOqrykkhccVIJIbc1CN/yW0XLg66G2Fl9u2vyjjrEc/gQYXimcLirFN
         6zfQ==
X-Gm-Message-State: AO0yUKW6uFHq9qwI0zgO6yS+Qe3+ocftMqV1YwVNBLKtce6buFJliDgA
	006iRnrvqvu0atSH2ddjf+lMxL30ioXvdXnCoXXLRw==
X-Google-Smtp-Source: AK7set+0P3wcELSTPXUaEDPZzq6i4SxLg49Qqke2is5WajYTx+QFT3yaUSPb25dkhszjVUkwo/ysKNfsnMjY8gG9YXU=
X-Received: by 2002:a05:651c:11cd:b0:293:39fe:b712 with SMTP id
 z13-20020a05651c11cd00b0029339feb712mr613949ljo.3.1676652662460; Fri, 17 Feb
 2023 08:51:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230211181105.7220-1-alex@shruggie.ro> <20230211181105.7220-2-alex@shruggie.ro>
 <4c80ab10-a640-682c-f397-b48509a204ee@gmail.com> <CAH3L5Qr7LNSHEv7N3B1JC7_vnbiiruxZd+x_-GxU+Yo4XvJkpQ@mail.gmail.com>
 <CAH3L5QrM8akr3ChdmqAOLHNd5hTArTXkVcUHtz6MFH+5kT8Upg@mail.gmail.com> <f1ac996c-c9fe-8d07-fd6d-5cfb83e68eb5@gmail.com>
In-Reply-To: <f1ac996c-c9fe-8d07-fd6d-5cfb83e68eb5@gmail.com>
From: Alexandru Ardelean <alex@shruggie.ro>
Date: Fri, 17 Feb 2023 18:50:51 +0200
Message-ID: <CAH3L5Qq-9BrC4_r1vo59eM8Ld9CiBDFRcUcvNK_uBXLGH5yz3w@mail.gmail.com>
Subject: Re: [RESEND PATCH 1/5] atmodem: gprs-context: fix ATD99 init for
 modems with no slave channel
To: Denis Kenzior <denkenz@gmail.com>
Cc: ofono@lists.linux.dev, patrick.frick@stihl.de, matthias.gruhler@stihl.de, 
	mircea.caprioru@flowkernel.ro, stephanie.altenburg@stihl.de
Content-Type: text/plain; charset="UTF-8"

On Fri, Feb 17, 2023 at 5:17 PM Denis Kenzior <denkenz@gmail.com> wrote:
>
> Hi Alexandru,
>
> > So, it seems we have an issue with our current modem FW.
> > It may be too old and we need to update it, to have things running smoother.
> > The kernel 'option' driver enumerates 4 /dev/ttyUSB{0,1,2,3} ports.
> > One thing that was confusing (for me at least), is, (in oFono) the Aux
> > port feels more like Modem port in the context of the atmodem driver +
> > quectel driver (and at least for BG95). But that's just semantic
> > probably.
>
> You may also want to check whether your device isn't really an mbim or qmi
> device in disguise.  Some of the devices I've seen over the years will actually
> ship with a single (reduced functionality) AT port, but have to be driven by
> other protocols.
>
> I know nothing of this hardware, just throwing this out there.

Well, I combed the Quectel forums for this BG95 and some of the issues
we are having are also shared by others.

We knew that QMI support for this modem is rather broken (from their
direct support contact).
Which is why we were trying on making the AT commands work.
This was also mentioned by Quectel when they upstreamed the VID + PID
combinations to the kernel:
https://lore.kernel.org/linux-usb/TYZPR06MB4270136AEC3FB06E20F6503486CF9@TYZPR06MB4270.apcprd06.prod.outlook.com/
https://lore.kernel.org/linux-usb/TYZPR06MB4270471E08BF0BCDBF24722186CE9@TYZPR06MB4270.apcprd06.prod.outlook.com/

Seems that our FW does not support device ports re-configuration (the
AT+QCFGEXT="usbnet" command does not work in our FW).
https://forums.quectel.com/t/bg95-unable-to-set-usbnet-to-rmnet/14308/10
(Though an update fixes that)

For now, we have an internal hack that uses the UART port as the
second AT port (in the atmodem driver).
So, basically, /dev/ttyUSB2 is Aux and a /dev/ttySTM3 is the Modem port.

I wouldn't know (now) what to propose for oFono upstream?
Wait for the QMI support to be finished by Quectel (if ever)?
Funny story: Quectel support seems to send FW updates via email if you
ask them on their forum:
https://forums.quectel.com/t/latest-firmware-bg95-m3/15403

>
> Regards,
> -Denis
