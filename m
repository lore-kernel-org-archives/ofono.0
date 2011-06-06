Content-Type: multipart/mixed; boundary="===============2266216529162209681=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v4 1/4] network-registration.c: add telit support
Date: Mon, 06 Jun 2011 17:52:25 -0500
Message-ID: <4DED5A29.5000707@gmail.com>
In-Reply-To: <1307546317-31831-1-git-send-email-Bernhard.Guillon@hale.at>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2266216529162209681==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Bernhard,

On 06/08/2011 10:18 AM, Bernhard.Guillon(a)hale.at wrote:
> From: Bernhard Guillon <Bernhard.Guillon@hale.at>
> =

> *add support for CIND=3D? tokens like ("signal",(0-7,99))
> *add telit quirk for token encapsulation e.g.
>     (("one",(0-7,99)),("two",(0-7,99)))
> ---
>  drivers/atmodem/network-registration.c |   41 ++++++++++++++++++++++++++=
++----
>  1 files changed, 36 insertions(+), 5 deletions(-)
> =


Patch has been applied (after patch 3) and with a few minor nitpicks
amended.  Thanks.

Regards,
-Denis

--===============2266216529162209681==--

