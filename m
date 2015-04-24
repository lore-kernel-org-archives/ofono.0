Content-Type: multipart/mixed; boundary="===============8794392088775971508=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Small query
Date: Fri, 24 Apr 2015 10:15:50 -0500
Message-ID: <553A5E26.3000803@gmail.com>
In-Reply-To: <222E70FA67D72A4FB8EEDF5AF01724ACCB4942@BGSMSX102.gar.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8794392088775971508==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Ram,

 >
> after the ofonod daemon starts running, the daemon is removing the wlan1
> interface.
>

That is not the case.  oFono simply prints some events it receives =

through udev (e.g. wlan1 was removed).  It does not actually trigger the =

removal.

Regards,
-Denis

--===============8794392088775971508==--

