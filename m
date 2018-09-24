Content-Type: multipart/mixed; boundary="===============5973898339301091193=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] location-reporting.h: driver properties handling
Date: Mon, 24 Sep 2018 16:07:12 -0500
Message-ID: <c8c8e4a5-f86c-7f9e-c89e-d4c25a2d30fb@gmail.com>
In-Reply-To: <20180923061922.23288-1-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5973898339301091193==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Giacinto,

On 09/23/2018 01:19 AM, Giacinto Cifelli wrote:
> The GNSS receiver configuration is highly proprietary.
> Some are configured through the GNSS port itself, some through other
> ports. The properties themselves vary among the manufacturers, with no
> standard available. Besides, ofono doesn't handle any state for a GNSS
> receiver.
> =

> Therefore, this extensions allows to get and set directly D-Bus
> properties by the driver.
> ---
>   include/location-reporting.h | 3 +++
>   1 file changed, 3 insertions(+)
>

No.  We're never going to do stuff like this.  Drivers are never going =

to get D-Bus messages.  They don't even know anything about D-Bus.

Either properly support the format you have in =

doc/location-reporting-api.txt or feel free to create a vendor specific =

D-Bus API for Gemalto inside plugins/gemalto.c

Regards,
-Denis

--===============5973898339301091193==--

