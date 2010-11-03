Content-Type: multipart/mixed; boundary="===============3197131593303267032=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [RFC] [CHANGE 2/2] ifxmodem: adding modem API to support agps
Date: Wed, 03 Nov 2010 08:51:59 +0100
Message-ID: <1288770719.9615.15.camel@aeonflux>
In-Reply-To: <CB28AA307186A940B1253A743EA1F20AA58B8B1C@orsmsx507.amr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3197131593303267032==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Robertino,

> This patch is RFC for Infenion modem API to support agps implementation o=
f ofono.

same rules as in the other email apply here.

>  drivers/ifxmodem/agps.c |  438 +++++++++++++++++++++++++++++++++++++++++=
++++++
>  include/agps.h          |  157 +++++++++++++++++
>  2 files changed, 595 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/ifxmodem/agps.c
>  create mode 100644 include/agps.h

As I explained, we don't intermix core changes with modem plugin
changes.

So include/ and src/ directories are core directories. If you wanna add
anything there, then you need to submit that as a separate patch.

And I want to see an initial patch that updates the TODO file with at
minium ownership if an entry already exists.

Regards

Marcel



--===============3197131593303267032==--

