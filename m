Content-Type: multipart/mixed; boundary="===============3195777931206276339=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Udev detection broken?
Date: Thu, 08 Sep 2011 03:49:04 -0500
Message-ID: <4E688180.7030907@gmail.com>
In-Reply-To: <4E71241C.9000407@makhutov.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3195777931206276339==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Artem,

On 09/14/2011 05:01 PM, Artem Makhutov wrote:
> Hello,
> =

> I am trying to setup ofono on my PC again, unfortunatly ofono does not
> pick up the connected huawei modem.
> =

> I have traced it down to plugins/udev.c - get_property function.
> =


Please note that huawei detection is now being done by plugins/udevng.c.

Regards,
-Denis

--===============3195777931206276339==--

