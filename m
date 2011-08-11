Content-Type: multipart/mixed; boundary="===============0353586031970325315=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 0/3] oFono rules update
Date: Thu, 11 Aug 2011 09:21:56 -0700
Message-ID: <1313079722.3373.139.camel@aeonflux>
In-Reply-To: <1313077104-13397-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0353586031970325315==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

> Based on the latest usb_modeswitch rules, some 3G dongles require
> to modify the ofono rules to be supported correctly (tests done in India)=
  =

> =

> =

> Philippe Nunes (3):
>   udev: use ttyUSB3 for ZTE K3570 modem port.
>   udev:  add support for Olive HSDPA modem
>   udev: Use ttyUSB4 for Huawei E367 Pcui port
> =

>  plugins/ofono.rules |   17 ++++++++++-------
>  1 files changed, 10 insertions(+), 7 deletions(-)

I think you are way too late with these changes. We are not using
plugins/udev.c for Huawei and ZTE device detection anymore. I fixed this
all up and plugins/udevng.c should do proper automatic detection.

Please check if this works properly for you or if you have problems.

Regards

Marcel



--===============0353586031970325315==--

