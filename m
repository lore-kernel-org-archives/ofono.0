Content-Type: multipart/mixed; boundary="===============1447751193301815252=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [RFC PATCH 0/4] Atom for Neighbour Cell Info
Date: Tue, 21 Dec 2010 06:04:46 -0800
Message-ID: <1292940286.2658.18.camel@aeonflux>
In-Reply-To: <1292940024-24363-1-git-send-email-antti.paila@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1447751193301815252==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Antti,

> This series of patches implements an interface for client
>  application to fetch the ECID information of neighbouring
>  cells using DBUS.
> =

>  src/cell-info.c |  537 +++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  include/cell-info.h |   66 +++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  include/dbus.h |    1 +
>  src/ofono.h    |    1 +
>  Makefile.am |    4 ++--

I am missing the D-Bus API documentation in this patch. I know that
proposals have been posted, but you need to pick that up and make it
part of your patchset.

Regards

Marcel



--===============1447751193301815252==--

