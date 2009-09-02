Content-Type: multipart/mixed; boundary="===============4328132668627931582=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 2/2] G1: Add a G1 syntax for parsing
Date: Wed, 02 Sep 2009 16:12:03 -0700
Message-ID: <1251933123.1266.131.camel@localhost.localdomain>
In-Reply-To: <20090902190336.67cc9648@mycelium.queued.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4328132668627931582==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andreas,

> This is based on the generic_at parser, with unnecessary stuff removed.
> =

> The G1 routinely screws up CRLFs, so the parser needs to account for
> that.  This parser ignores leading CRLFs (which is what reference-ril
> does as well), as well as trailing LFs (which are sometimes left out).
> CRs are used as end-of-message indicators.  Since we're not bothering
> tracking CRLFs, there's also no need for a GARBAGE state, or MULTILINE
> stuff.
> ---
>  plugins/g1.c |   87 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++-
>  1 files changed, 85 insertions(+), 2 deletions(-)

this patch has been applied now, too. Thanks.

Regards

Marcel



--===============4328132668627931582==--

