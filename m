Content-Type: multipart/mixed; boundary="===============7915732758919893729=="
MIME-Version: 1.0
From: nicolas.bertrand <nicolas.bertrand@linux.intel.com>
Subject: AT+CFUN=7 not supported by Huawei E173
Date: Tue, 12 Jul 2011 18:00:49 +0200
Message-ID: <4E1C6FB1.9090703@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7915732758919893729==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

I got a problem with the change "huawei: Use correct command for setting =

offline mode".

The command AT+CFUN=3D7 is not supported by all Huawei modems and so the =

E173 is not working anymore.

PCUI: > AT+CFUN=3D7\r
PCUI: < \r\n+CME ERROR: 50\r\n

This modem supports only these functionality level: 0, 1, 4, 5 and 6.
I don't have the specification of this modem and so I don't know what =

level we need to set here.

Do you have an idea on how we can resolve this problem?

Thanks.

-- =


Nico

--===============7915732758919893729==--

