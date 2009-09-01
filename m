Content-Type: multipart/mixed; boundary="===============8422130982252948365=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/3] G1: Add a G1 syntax for parsing
Date: Tue, 01 Sep 2009 12:14:55 -0500
Message-ID: <200909011214.56106.denkenz@gmail.com>
In-Reply-To: <20090830040708.GA28068@mycelium.queued.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8422130982252948365==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andres,

> This is based on the generic_at parser, with unnecessary stuff removed.
>
> The G1 routinely screws up CRLFs, so the parser needs to account for
> that.  This parser ignores leading CRLFs (which is what reference-ril
> does as well), as well as trailing LFs (which are sometimes left out).
> CRs are used as end-of-message indicators.  Since we're not bothering
> tracking CRLFs, there's also no need for a GARBAGE state, or MULTILINE
> stuff.
> ---

This one looks fine to me.

Regards,
-Denis

--===============8422130982252948365==--

