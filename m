Content-Type: multipart/mixed; boundary="===============5062409039286422451=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 4/5] cdmaphonesim: Add CDMA SMS Support
Date: Mon, 20 Dec 2010 14:42:20 -0600
Message-ID: <4D0FBFAC.1010701@gmail.com>
In-Reply-To: <1291854951-2378-5-git-send-email-lei.2.yu@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5062409039286422451==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lei,

On 12/08/2010 06:35 PM, Lei Yu wrote:
> ---
>  Makefile.am               |    9 ++
>  configure.ac              |    6 +
>  plugins/cdmaphonesim.c    |  344 +++++++++++++++++++++++++++++++++++++++=
++++++
>  plugins/cdmaphonesim.conf |   14 ++
>  4 files changed, 373 insertions(+), 0 deletions(-)
>  create mode 100644 plugins/cdmaphonesim.c
>  create mode 100644 plugins/cdmaphonesim.conf
> =


Have you considered adding a CDMA/GSM selector to phonesim.conf instead?
 So e.g. a new configuration key called 'Type' where type can be 'gsm'
or 'cdma'.

That way you can share much of the phonesim plugin plumbing and only
populate the atoms differently...

Regards,
-Denis

--===============5062409039286422451==--

