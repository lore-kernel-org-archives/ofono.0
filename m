Content-Type: multipart/mixed; boundary="===============7035653680446198870=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Unable to connect Huawei HiLink E303
Date: Thu, 06 Feb 2014 10:52:02 -0600
Message-ID: <52F3BDB2.6040106@gmail.com>
In-Reply-To: <CAK+sfosT-thxn02iuvScDvF8Nz9ZO5cw_YiB=z5ku-_5fkv-Uw@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7035653680446198870==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Homam,

> ofonod[17818]: drivers/atmodem/gprs-context.c:at_cgdata_cb() ok 0
> ofonod[17818]: Unable to enter data state
> ofonod[17818]: src/gprs.c:pri_activate_callback() 0x2121c00
> ofonod[17818]: src/gprs.c:pri_activate_callback() Activating context fail=
ed with error: Incorrect parameters
>

Can you enable AT command tracing by using:

export OFONO_AT_DEBUG=3D1 the running ofonod and post that log.

It looks like the either the APN setup is incorrect or the modem will =

require us to use the legacy form of context activation instead of +CGDATA.

Regards,
-Denis


--===============7035653680446198870==--

