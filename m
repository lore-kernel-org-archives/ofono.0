Content-Type: multipart/mixed; boundary="===============3234746454050300161=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH v2 2/6] atmodem: create struct atmodem_network_registration
Date: Fri, 30 Apr 2010 15:35:39 +0200
Message-ID: <1272634539.22838.194.camel@localhost.localdomain>
In-Reply-To: <20100430125505.30019.63489.stgit@potku.valot.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3234746454050300161==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kalle,

> Needed to provide more channels to atmodem network_registration module.
> ---
> =

>  drivers/atmodem/network-registration.c |    7 ++++---
>  drivers/atmodem/network-registration.h |   26 ++++++++++++++++++++++++++
>  plugins/atgen.c                        |    7 ++++++-
>  plugins/calypso.c                      |    7 ++++++-
>  plugins/em770.c                        |    2 ++
>  plugins/g1.c                           |    8 +++++++-
>  plugins/hso.c                          |    7 ++++++-
>  plugins/huawei.c                       |    9 ++++++++-
>  plugins/mbm.c                          |    7 ++++++-
>  plugins/novatel.c                      |    9 ++++++++-
>  plugins/palmpre.c                      |    7 ++++++-
>  plugins/phonesim.c                     |    9 +++++++--
>  plugins/ste.c                          |    8 +++++++-
>  13 files changed, 99 insertions(+), 14 deletions(-)
>  create mode 100644 drivers/atmodem/network-registration.h

what is wrong with using ofono_netreg_status_notify?

Regards

Marcel



--===============3234746454050300161==--

