Content-Type: multipart/mixed; boundary="===============7687857971421133065=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 00/16] Implement DUN server for oFono
Date: Wed, 11 Aug 2010 10:26:25 +0800
Message-ID: <1281493601-14351-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7687857971421133065==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

These patches are based my 6 patches sent on Aug 5th. It implements DUN ser=
ver logic to manage GPRS context create/destroy per DUN client requests. On=
 DUN client side, you can use 'rfcomm bind 0 xx:xx:xx:xx:xx:xx 1' and then =
'gsmdial -n /dev/rfcomm0 -c 1 -a cid -l' to test it.

Review comments are welcome!

Regards,
Zhenhua


--===============7687857971421133065==--

