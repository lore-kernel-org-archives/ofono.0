Content-Type: multipart/mixed; boundary="===============5543852381316659180=="
MIME-Version: 1.0
From: Lars Poeschel <poeschel@lemonage.de>
Subject: Re: Quectel BG95 Support
Date: Thu, 28 May 2020 12:01:58 +0200
Message-ID: <20200528100158.mef3ifnqzy65pi3x@lem-wkst-02.lemonage>
In-Reply-To: <20200514142722.2843.94186@ml01.vlan13.01.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5543852381316659180==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello!

On Thu, May 14, 2020 at 02:27:22PM -0000, arash.javanmard(a)inro-et.de wrot=
e:
> Hello,
> unfortunately there is no support for Quectel BG95 in ofono.  But neverth=
eless i tried to adapt the existing Quectel implementation for BG95.
> So i added:
> =

> udevng.c
> ------- 8< -------------
> 	{ "quectelqmi",	"qmi_wwan",	"2c7c", "0700"	},
> 	{ "quectelqmi",	"qcserial",	"2c7c", "0700"	},
> 	{ "quectel",	"option",	"2c7c", "0700"	},
> ------- >8 -------------

I do not know for sure, but I think this is wrong. Either your modem is
serial and using the quectel driver or it is a qmi modem with quectelqmi
as driver, but not both.
Well, maybe your modem supports both, but you can only use one at a
time.

Regards,
Lars
--===============5543852381316659180==--

