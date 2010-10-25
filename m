Content-Type: multipart/mixed; boundary="===============6222426034568327093=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 3/6] test: add scripts to enable and disable fast dormancy
Date: Mon, 25 Oct 2010 16:34:54 +0200
Message-ID: <1288017294.3613.11.camel@aeonflux>
In-Reply-To: <1288013290-6124-4-git-send-email-mika.liljeberg@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6222426034568327093==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mika,

>  Makefile.am                |    4 +++-
>  test/disable-fast-dormancy |   20 ++++++++++++++++++++
>  test/enable-fast-dormancy  |   20 ++++++++++++++++++++
>  3 files changed, 43 insertions(+), 1 deletions(-)
>  create mode 100755 test/disable-fast-dormancy
>  create mode 100755 test/enable-fast-dormancy

what about just using a set-fast-dormancy script that takes a parameter.

I know we were not really consistent with the test directory, but since
we have set-tech-preference and get-tech-preference, I think we should
do it that way.

Regards

Marcel



--===============6222426034568327093==--

