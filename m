Content-Type: multipart/mixed; boundary="===============1230048707289227989=="
MIME-Version: 1.0
From: Arun Ravindran <ext-arun.1.ravindran@nokia.com>
Subject: Re: failed to send Concatenated sms message with ofono v0.33:
Date: Mon, 22 Nov 2010 11:55:44 +0200
Message-ID: <4CEA3E20.3070204@nokia.com>
In-Reply-To: <1865303E0DED764181A9D882DEF65FB6815BEBBE6C@shsmsx502.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1230048707289227989==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Haitao,

> 09787000-097c6000 rw-p 00000000 00:00 0          [heap]
> b782f000-b7831000 rwxs 00000000 b3:09 16617
> /var/cache/callhistory/voicecallhistorydata
> b7831000-b7835000 rwxs 00000000 b3:09 16615
> /var/cache/smshistory/smshistorydata
> b7835000-b783a000 r-xp 00000000 b3:09 356573
> /usr/lib/ofono/plugins/smshistory.so
> b783a000-b783b000 rw-p 00004000 b3:09 356573
> /usr/lib/ofono/plugins/smshistory.so
> b783b000-b783e000 rw-p 00000000 00:00 0
> b7840000-b7843000 r-xp 00000000 b3:09 356574
> /usr/lib/ofono/plugins/callhistory.so
> b7843000-b7844000 rw-p 00003000 b3:09 356574
> /usr/lib/ofono/plugins/callhistory.so
> b7844000-b784b000 r--s 00000000 b3:09 309015
> /usr/lib/gconv/gconv-modules.cache
> b784b000-b784c000 rw-p 00000000 00:00 0
> b784c000-b784d000 r-xp 00000000 00:00 0          [vdso]
> bfb5c000-bfb7d000 rw-p 00000000 00:00 0          [stack]
> ofonod[1366]: Aborting (signal 6)
>    =

This is an issue with smshistory plugin, not really oFono issue.
There is already a bug in bugs.meego.com for this issue. (#9691).

Regards
Arun




--===============1230048707289227989==--

