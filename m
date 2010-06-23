Content-Type: multipart/mixed; boundary="===============3041571454966234129=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/6] ppp: Fix incorrect packet length for little-endian
Date: Wed, 23 Jun 2010 18:20:26 -0500
Message-ID: <201006231820.26732.denkenz@gmail.com>
In-Reply-To: <1277286402-22312-2-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3041571454966234129==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Zhenhua,

> packet->length is in TCP/IP network byte order. It needs to call ntohs()
> to convert to host byte order, which is little-endian.

Nice catch.  Patch has been applied, thanks.

Regards,
-Denis

--===============3041571454966234129==--

