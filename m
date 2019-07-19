Content-Type: multipart/mixed; boundary="===============5729540186391170303=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 01/10] atmodem: export generic netreg funcs
Date: Fri, 19 Jul 2019 01:40:39 -0500
Message-ID: <1614a65f-96fa-41af-a3c1-9572211f4c44@gmail.com>
In-Reply-To: <20190718102314.28094-1-jonas@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5729540186391170303==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On 7/18/19 5:23 AM, Jonas Bonn wrote:
> An upcoming netreg driver for uBlox modems will need to override the
> probe method in order to set itself up, but for further functionality
> the "generic" AT implementations are sufficient.  The easiest way to do
> this is to just set up a vtable with a custom probe implementation and
> defer all other methods to the common/generic methods.
> =

> The problem is that the AT methods are not actually exported.  This
> generic AT functionality was not intended to be hooked directly into
> other drivers.
> =

> This patch exports all the methods of the atmodem network-registration
> driver implementation so that they can be used as generic/common
> implementations for other drivers.
> ---
>   drivers/atmodem/network-registration.c | 16 +++++++++-------
>   drivers/atmodem/network-registration.h | 17 +++++++++++++++++
>   2 files changed, 26 insertions(+), 7 deletions(-)
>   create mode 100644 drivers/atmodem/network-registration.h
> =


Patches 1 & 2 applied, thanks.

Regards,
-Denis


--===============5729540186391170303==--

