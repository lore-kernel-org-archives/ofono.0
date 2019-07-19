Content-Type: multipart/mixed; boundary="===============4952390028018272314=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] ublox: network-registration atom
Date: Fri, 19 Jul 2019 02:45:56 -0500
Message-ID: <b6a04487-0032-6643-937b-6c75bd0d4c40@gmail.com>
In-Reply-To: <20190719065102.32314-1-jonas@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4952390028018272314==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On 7/19/19 1:51 AM, Jonas Bonn wrote:
> For uBlox modems, a bit of custom setup is required, but after that the
> generic "atmodem" (27.007-compatible) method implementations are
> sufficient.  This driver, therefore, just puts the custom probe method
> into place and defers remaining functionality to the recently exported
> atmodem implementations.
> ---
>   Makefile.am                               |   1 +
>   drivers/ubloxmodem/network-registration.c | 426 ++++++++++++++++++++++
>   drivers/ubloxmodem/ubloxmodem.c           |   2 +
>   drivers/ubloxmodem/ubloxmodem.h           |   3 +
>   4 files changed, 432 insertions(+)
>   create mode 100644 drivers/ubloxmodem/network-registration.c
> =


Both applied after fixing up a couple of > 80 char instances.

Regards,
-Denis

--===============4952390028018272314==--

