Content-Type: multipart/mixed; boundary="===============1201768766108914342=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] Add support of Huawei EM770 modem
Date: Mon, 15 Mar 2010 23:45:09 -0700
Message-ID: <1268721909.2700.15.camel@localhost.localdomain>
In-Reply-To: <1268721424-15127-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1201768766108914342==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Yang,

> Comparing with general Huawei modem, EM770 is a full feature modem that
> supports voicecall, phonebook, call forwarding, call barring, etc.
> ---
>  Makefile.am            |    3 +
>  plugins/huawei-em770.c |  226 ++++++++++++++++++++++++++++++++++++++++++=
++++++
>  plugins/ofono.rules    |    1 +
>  plugins/udev.c         |   27 ++++++
>  4 files changed, 257 insertions(+), 0 deletions(-)
>  create mode 100644 plugins/huawei-em770.c

for simplicity just let call it em770.c and everything where you have
huawei_em770 just use em770. We do similar things for G1 etc.

Regards

Marcel



--===============1201768766108914342==--

