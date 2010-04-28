Content-Type: multipart/mixed; boundary="===============1006348343845068038=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi@remlab.net>
Subject: Re: [PATCH] usbpnmodem: configure usbpn interfaces automatically
Date: Wed, 28 Apr 2010 15:10:55 +0200
Message-ID: <5ea667bc6124f7498f850d50ffc04fa1@chewa.net>
In-Reply-To: <1272035118-26998-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1006348343845068038==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Fri, 23 Apr 2010 18:05:18 +0300, Pekka Pessi <Pekka.Pessi@nokia.com>
wrote:
> ---
>  drivers/isimodem/isimodem.c |    2 +-
>  gisi/netlink.c              |  246
> +++++++++++++++++++++++++++++++++++++++---
>  gisi/netlink.h              |   11 ++-
>  plugins/usbpnmodem.c        |   10 ++-
>  4 files changed, 246 insertions(+), 23 deletions(-)

I fail to see why we need this. usbpn is already autoconfigured by the
kernel. It only needs to be brought administratively up.

-- =

R=C3=A9mi Denis-Courmont
http://www.remlab.net
http://fi.linkedin.com/in/remidenis


--===============1006348343845068038==--

