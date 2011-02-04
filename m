Content-Type: multipart/mixed; boundary="===============7172257360096497331=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] plugin: add plugin for Linktop/Teracom LW273 data card
Date: Fri, 04 Feb 2011 10:37:59 -0600
Message-ID: <4D4C2B67.6070706@gmail.com>
In-Reply-To: <AANLkTi=cz3mwErBKbsDhFYsmGnXrcF=nyKANdYOViGDo@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7172257360096497331==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Amit,

On 02/03/2011 10:34 AM, Amit Mendapara wrote:
> The LW273 and LW272 devices are being distributed by BSNL in India
> with Teracom
> brand name. Both the devices have similar specs except data speed and
> having same
> usb id (230d:0001).
> =

> Links:
> =

> http://www.bsnl.in/service/3G/3G_files/3g.htm
> http://www.teracom.in/htmls/3G.html
> http://www.linktop.com.cn/en/Products.asp?FID=3D1&LID=3D302
> <http://www.linktop.com.cn/en/Products.asp?FID=3D1&LID=3D302>
> http://amit-mendapara.blogspot.com/2010/11/amazing-bsnl-3g.html
> =

> Regards
> --
> Amit Mendapara
> =


Thanks for your patch, but please resubmit it in a proper format for
review.  The easiest way to do that is git-send-email.  Also, please
have a look at the 'Submitting patches' section in the HACKING file of
oFono.  Ideally this should be a 3 patch series, one adding the linktop
driver, one modifying udev and one modifying ofono.rules.

Regards,
-Denis

--===============7172257360096497331==--

