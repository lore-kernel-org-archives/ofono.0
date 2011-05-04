Content-Type: multipart/mixed; boundary="===============5833144843890621452=="
MIME-Version: 1.0
From: andrzej zaborowski <balrogg@gmail.com>
Subject: Re: Ofono cross compiling for ARM
Date: Wed, 04 May 2011 13:59:57 +0200
Message-ID: <BANLkTint4qbXrNTr5iVCYtgYu6T+L+BWbw@mail.gmail.com>
In-Reply-To: <BANLkTink6D45Lz6iAEmOnoeMtJu2bMkZ_Q@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5833144843890621452==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Yuruvaj,

On 4 May 2011 11:07, Yuvaraj Ragupathi <yuvaraj.addu@gmail.com> wrote:
> I want to cross compile the ofono for ARM target.
>
> So i executed configure file with following arguments
>
>
> #./configure --host=3Darm
> --libdir=3D/usr/lib/madde/linux-i686/sysroots/meego-core-armv7l-madde-sys=
root-1.1.2-fs/usr/lib
> --prefix=3D/home/$myname/Desktop/ofono_For_ARM/binaries
> --includedir=3D/usr/lib/madde/linux-i686/sysroots/meego-core-armv7l-madde=
-sysroot-1.1.2-fs/usr/include
>
>
> It is giving config related error message
>
> configure: error: signalfd support is required
>
>
> What it does mean?

This error is related to glibc version, I believe signalfd was added
in 2.7 so you need to upgrade your cross toolchain.  There's also
dependency on kernel version but I don't know what the minimum version
that works is.

Best regards

--===============5833144843890621452==--

