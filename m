Content-Type: multipart/mixed; boundary="===============7982998440899348870=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: query
Date: Wed, 29 Jul 2015 10:27:03 -0500
Message-ID: <55B8F0C7.6020807@gmail.com>
In-Reply-To: <222E70FA67D72A4FB8EEDF5AF01724ACCF24B7@BGSMSX102.gar.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7982998440899348870==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Ram,

On 07/29/2015 08:12 AM, Kallumari Nagaraja Rao, RammohanX wrote:
> Hello All,
>
> As said below, I am using the Intel Edison board with a Ublox on a
> serial interface.
>
> After doing some debugging got to know that the
> =E2=80=9C/plugins/udevng.c:enumerate_devices()=E2=80=9D does get struck a=
nd
>
> nothing happens after that.

Since you have debug output after enumerate_devices() is called, this is =

highly unlikely.  Does your kernel support udev?  You need to get your =

kernel and system sorted out first.

Regards,
-Denis

--===============7982998440899348870==--

