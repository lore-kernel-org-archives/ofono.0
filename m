Content-Type: multipart/mixed; boundary="===============6396552595610084172=="
MIME-Version: 1.0
From: Antti Paila <antti.paila@nokia.com>
Subject: Re: [PATCH 0/4 v2] Network Time plugin
Date: Tue, 21 Dec 2010 09:34:02 +0200
Message-ID: <1292916842.10058.5.camel@apaila-ThinkPad-T410>
In-Reply-To: <1291967638-12371-1-git-send-email-antti.paila@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6396552595610084172==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

Could someone review this patch. It has been waiting for review a while
now. Thanks.

-Antti  =


On Fri, 2010-12-10 at 09:53 +0200, Antti Paila wrote:
> This series of patches introduces the network time part of the NITZ featu=
re =

>  as outlined in 3GPP spec 22.042. The Network Time plugin has two DBUS =

>  interfaces for client applications: notification signal and polling meth=
od =

>  call. The time information consists of three dictionary entries: 1) time=
 and =

>  date in seconds from epoch (renormalized to time indicatation arrival ti=
me);
>  2) daylight saving time; 3) timezone.
>  =

>  include/dbus.h |    1 +
>  plugins/nettime.c | 285 ++++++++++++++++++++++++++++++++++++++++++++++++=
+++++
>  Makefile.am |   10 ++++++++--
>  test/get-nettime |   25 +++++++++++++++++++++++++
>  test/test-nettime |   46 ++++++++++++++++++++++++++++++++++++++++++++++
>  doc/network-time-api.txt |   31 +++++++++++++++++++++++++++++++



--===============6396552595610084172==--

