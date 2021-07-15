Content-Type: multipart/mixed; boundary="===============5414226778790323768=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/3] gemalto: add radio-settings driver
Date: Thu, 15 Jul 2021 13:12:03 -0500
Message-ID: <2a42248f-7c99-5f24-a450-651645ec366c@gmail.com>
In-Reply-To: <20210704155348.432964-2-geomatsi@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5414226778790323768==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sergey,

On 7/4/21 10:53 AM, Sergey Matyukevich wrote:
> Add support for Gemalto specific radio settings.
> =

> ---
>   Makefile.am                           |   1 +
>   drivers/gemaltomodem/gemaltomodem.c   |   2 +
>   drivers/gemaltomodem/gemaltomodem.h   |   3 +
>   drivers/gemaltomodem/radio-settings.c | 267 ++++++++++++++++++++++++++
>   4 files changed, 273 insertions(+)
>   create mode 100644 drivers/gemaltomodem/radio-settings.c
> =


I went ahead and applied this with a 2 lines amended: changing 'enum =

ofono_access_mode' to 'unsigned int'.  I recently updated all the drivers i=
n =

commit 1d86dbc6 ("radio-settings: Do not use enum ofono_access_mode").  So =
I did =

a similar amend here for consistency.

Regards,
-Denis
--===============5414226778790323768==--

