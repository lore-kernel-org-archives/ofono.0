Content-Type: multipart/mixed; boundary="===============5110395588686895135=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: SIM ToolKit support
Date: Wed, 17 Mar 2010 17:06:29 -0600
Message-ID: <201003171806.29561.denkenz@gmail.com>
In-Reply-To: <FC2FB65B4D919844ADE4BE3C2BB739AD1DCE17A3@shsmsx501.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5110395588686895135==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Johnson,

> Hi,
> =

> Is there anybody can share me some information about SIM Toolkit support =
by
>  ofono? Current status, any schedule to support STK?

We started implementing the initial BER-TLV / CTLV parser in src/stkutil.c, =

this work has only just begun.  We're also working on figuring out the =

interface for proactive commands, terminal responses and envelopes, see rec=
ent =

patches on the mailing list from  =

Andrzej.

In effect we're nowhere close to supporting SIM toolkit yet.

Regards,
-Denis

--===============5110395588686895135==--

