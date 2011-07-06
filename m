Content-Type: multipart/mixed; boundary="===============3504171364145501653=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] Create a SpeedUp plugin, using standard AT Modem,
 and add corresponding udev rules
Date: Wed, 06 Jul 2011 20:07:50 +0200
Message-ID: <1309975670.21109.31.camel@aeonflux>
In-Reply-To: <1309955657-14565-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3504171364145501653==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Betrand,

>  Makefile.am         |    3 +
>  plugins/ofono.rules |    9 ++
>  plugins/speedup.c   |  334 +++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  plugins/udev.c      |   54 ++++++++
>  4 files changed, 400 insertions(+), 0 deletions(-)
>  create mode 100644 plugins/speedup.c

same request as for everybody else in the past. Please split udev rules
and detection into a separate patch.

Regards

Marcel



--===============3504171364145501653==--

