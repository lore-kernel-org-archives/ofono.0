Content-Type: multipart/mixed; boundary="===============6417853269392218080=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH v4 7/7] plugins/ste: Use SOCK_STREAM for CAIF and enable
 interface specification.
Date: Tue, 17 Aug 2010 00:12:03 +0200
Message-ID: <1281996723.23399.56.camel@localhost.localdomain>
In-Reply-To: <1281993134-3926-7-git-send-email-sjurbren@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6417853269392218080==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sjur,

>  plugins/modem.conf  |    5 +++++
>  plugins/modemconf.c |    1 +
>  plugins/ste.c       |   20 +++++++++++++++++++-
>  3 files changed, 25 insertions(+), 1 deletions(-)

please don't intermix modemconf and STE plugin changes. I need two
separate patches for this.

Regards

Marcel



--===============6417853269392218080==--

