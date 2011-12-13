Content-Type: multipart/mixed; boundary="===============4642424449393453207=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH_v0] CDMA modem implementation support
Date: Tue, 13 Dec 2011 08:46:19 -0600
Message-ID: <4EE7653B.3040102@gmail.com>
In-Reply-To: <1323787237-8307-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4642424449393453207==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guillaume,

On 12/13/2011 08:40 AM, Guillaume Zajac wrote:
> Hi,
> =

> This is v0 of patch to support CDMA modems into ConnMan ofono plugin.
> Please tell me if it needs to be split.
> =

> As current implementation is based on context that is GSM specific,
> a unique context is created for CDMA modems to be able to add the network=
 as
> we can't trigger the context creation from oFono side.
> Maybe be should create a add_cdma_network() function no to be context
> dependant although we need to have one to store the IPv4/IPv6 settings, i=
ndex,
> and modem path.
> =


I think you sent to the wrong list ;)

Regards,
-Denis

--===============4642424449393453207==--

