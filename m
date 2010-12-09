Content-Type: multipart/mixed; boundary="===============4448118206576288146=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 4/5] cdmagen: Add CDMA MO Call Support
Date: Thu, 09 Dec 2010 02:46:26 -0600
Message-ID: <4D009762.5070201@gmail.com>
In-Reply-To: <1291332685-18740-5-git-send-email-dara.spieker-doyle@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4448118206576288146==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Dara,

On 12/02/2010 05:31 PM, Dara Spieker-Doyle wrote:
> ---
>  Makefile.am         |    3 +
>  plugins/cdmagen.c   |  276 +++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  plugins/ofono.rules |    4 +

I'd really prefer ofono.rules chunk to be in a separate patch

>  plugins/udev.c      |   21 ++++

And the changes to udev to be in a separate patch as well.

>  4 files changed, 304 insertions(+), 0 deletions(-)
>  create mode 100644 plugins/cdmagen.c
> =


Regards,
-Denis

--===============4448118206576288146==--

