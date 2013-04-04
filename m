Content-Type: multipart/mixed; boundary="===============9214822026373175338=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: SAGEM HiloNC v2 Driver
Date: Thu, 04 Apr 2013 08:36:39 -0500
Message-ID: <515D81E7.2000102@gmail.com>
In-Reply-To: <CAAs3wMg72S76Ltr66so0WxE1kbEXmeEkniBT6C6KBzQdVofb6A@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9214822026373175338==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marco,

> I almost finished the driver..seems to work properly also on the
> embedded device (just for SMS & PPP ). If I would like to share the code
> .. how should I procede? would u like a patch posted here or a git  pull
> request ? or what else ?

Use git send-email and send the patches to the mailing list.  Please see =

'Submitting Patches' section in the HACKING document.

>
> another issue  : anyone could explain what module should I see to
> properly set the ppp0 interface once  got a valid IP from the PPP ?

See test/process-context-settings

Regards,
-Denis

--===============9214822026373175338==--

