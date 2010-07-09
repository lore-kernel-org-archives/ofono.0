Content-Type: multipart/mixed; boundary="===============7669115350347666299=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 0/1] Avoid timeout too quickly in PPP handshaking
Date: Fri, 09 Jul 2010 16:40:34 +0800
Message-ID: <1278664835-21295-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7669115350347666299==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

The patch is to increase the Max-Failure count for NAKs in IPCP handshaking=
. It is inspired by the similar implementation in pppd. Our PPP server uses=
 IPCP NAKs to stall until acquiring the client IP address from DHCP server,=
 so we need to increase the max failure count (default is 5) in IPCP handsh=
aking.

Thanks,
Zhenhua


--===============7669115350347666299==--

