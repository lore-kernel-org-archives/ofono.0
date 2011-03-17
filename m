Content-Type: multipart/mixed; boundary="===============0169123780876078591=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 0/7] Add CDMA Connection Manager support
Date: Thu, 17 Mar 2011 14:28:54 -0500
Message-ID: <4D8260F6.3080702@gmail.com>
In-Reply-To: <1295651210-22922-1-git-send-email-christian.lam@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0169123780876078591==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christian,

On 01/21/2011 05:06 PM, christian.lam(a)nokia.com wrote:
> From: Christian Lam <christian.lam@nokia.com>
> =

> This series of patches provides the support for the CDMA Connection
> Manager, cdma-connman, atom. This includes Mobile Originated connection
> and disconnection features of Packet Data Service over CDMA
> (1xRTT and 1xEV-DO) systems. This implementation do not yet handle the
> CDMA Network Registration which is future work.
> =

> These patches have been tested against the Nokia 7705 CDMA device in a
> tethered mode.
> =

> Limitations
> -----------
> The Nokia 7705 device does not support an AT interface for reporting requ=
est
> responses, such as the remote/network disconnect reasons, so these are
> currently untested.
> =

> Christian Lam (7):
>   dbus: add CDMA Connection Manager interface
>   cdma-connman: add CDMA Connection Manager support
>   src: add CDMA Connection Manager support
>   nokiacdma: add CDMA Connection Manager support
>   cdmamodem: add CDMA Connection Manager support
>   test: add CDMA Connection Manager support scripts
>   test: add Settings dict parsing for CDMA ConnMan
> =


All 7 patches have been applied with some minor amends by me (mainly
resolving conflicts in Makefile.am).  Thanks.

Regards,
-Denis

--===============0169123780876078591==--

