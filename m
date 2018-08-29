Content-Type: multipart/mixed; boundary="===============4504136048731966162=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 0/1] atmodem: Handle broken +CMT notifications of some
 cinterion modems
Date: Wed, 29 Aug 2018 16:12:30 -0500
Message-ID: <2e937792-2132-8bfb-c2d5-092cecedd97f@gmail.com>
In-Reply-To: <20180829144827.4577-1-tournier.julien@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4504136048731966162==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Julien,

On 08/29/2018 09:48 AM, tournier.julien(a)gmail.com wrote:
> From: Julien Tournier <tournier.julien@gmail.com>
> =

> Hi Denis,
> =

> Here is the fixed patch for the +CMT notification parsing on some cinteri=
on
> modems that have a leading coma. I hope i took all your remarks into acco=
unt
> =

> =

>   drivers/atmodem/sms.c | 21 ++++++++++++++++++---
>   1 file changed, 18 insertions(+), 3 deletions(-)
> =


I reworded the commit description and the comment in the code and =

applied this patch.  Thanks!

Regards,
-Denis

--===============4504136048731966162==--

