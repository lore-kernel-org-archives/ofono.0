Content-Type: multipart/mixed; boundary="===============3987037567482384045=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: bug reactivating primary context?
Date: Wed, 27 May 2015 12:14:08 -0500
Message-ID: <5565FB60.7000502@gmail.com>
In-Reply-To: <CANPyyuMeLV+UTUVzYqnH8rWwCJ4_mjUYDnVxje9KDYpw1V4YSQ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3987037567482384045==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mike,

>
> It looks like AT&C0 is correctly being issued, from the logs here:
>
> ofonod[1398]: plugins/huawei.c:sysinfo_enable_cb() 255 -> 1
> ofonod[1398]: Modem: > AT&C0\r
> ofonod[1398]: PCUI: > AT&C0\r
> ofonod[1398]: PCUI: < \r\nOK\r\n
>
> I'm using a Huawei e173:
> ofonod[2008]: Modem: < ATE0 +CMEE=3D1\r\r\nOK\r\n
> ofonod[2008]: PCUI: < \r\nManufacturer: huawei\r\nModel:
> E173L\r\nRevision: 21.106.04.00.982\r\nIMEI: 868387000063372\r\n+GCAP:
> +CGSM,+DS,+ES\r\n\r\nOK\r\n

Yes, certain models of Huawei modems are the main culprits.  There have =

been a few suggestions on how to solve this, but it is quite nasty & =

requires re-opening the AT modem port.  Nobody had the itch to fix it =

properly.

>
> Is there any way I can see if the modem is closing the command port?
>

strace, or use g_at_chat_set_disconnect_function() and see if that gets =

called.

Regards,
-Denis


--===============3987037567482384045==--

