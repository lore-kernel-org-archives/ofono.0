Content-Type: multipart/mixed; boundary="===============2922729592648553122=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Huawei MS2131
Date: Fri, 19 Jan 2018 09:31:52 -0600
Message-ID: <cd427759-b9d2-52ae-d5db-a4c114931282@gmail.com>
In-Reply-To: <B5CD1B0BA251DD468958CC22781DD5372B3BCA@DEFTHW99EJ0MSX.ww902.siemens.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2922729592648553122==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Xingxing,

> root(a)iot2000-ebs:/usr/lib/ofono/test# ./activate-context
> Error activating /huawei_0/context1: org.ofono.Error.NotImplemented: Impl=
ementation not provided.

This tells me that the gprs context driver has failed to initialize.  Do =

you have TUN/TAP support enabled in your kernel?  Is there a log with =

ofono running with debug enabled, e.g. '-n -d' you can provide?

Regards,
-Denis

--===============2922729592648553122==--

