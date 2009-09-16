Content-Type: multipart/mixed; boundary="===============8960867983160270685=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: Bug in sms
Date: Wed, 16 Sep 2009 14:14:30 +0200
Message-ID: <fb249edb0909160514l1e6ea5b1q4071af4dc475a6c7@mail.gmail.com>
In-Reply-To: <38D9F46DFF92C54980D2F2C1E8EE313001AB9212FC@pdsmsx503.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8960867983160270685==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

2009/9/16 Gu, Yang <yang.gu@intel.com>:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Today I tried oFono with my cell phone, but it=
 crashed when starting up.
> The problem happens in function at_cmgl_notify() of file drivers/atmodem/=
sms.c.
> In my case, strlen(hexpdu) =3D=3D 338, but the buffer "pdu" has maximum s=
ize of
> 164. So after decode_hex_own_buf(), some memory was written unexpectedly.

The attached patch adds length check everywehere decode_hex_own_buf()
is used with a static buffer and also enlarges the buffers to account
for SMSC included in a PDU.

Regards

--===============8960867983160270685==--

