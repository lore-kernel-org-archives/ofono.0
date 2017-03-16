Content-Type: multipart/mixed; boundary="===============4150612825044754707=="
MIME-Version: 1.0
From: Piotr Haber <gluedig@gmail.com>
Subject: Re: Telit LE910V1 - LTE only modem
Date: Thu, 16 Mar 2017 10:32:03 +0100
Message-ID: <20170316093204.25275-1-gluedig@gmail.com>
In-Reply-To: <d0f4d648-97b3-8310-1105-e98114d419ba@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4150612825044754707==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lukasz,

I have never useg LE910-SVG but I have used LE910-EUG which is also V1 LE91=
0 modem.
It uses QMI interface and is End-of-life product according to Telit.
Below is a patch I used to add support for it, maybe it will help you.

Modem is not recognized automatically, you need to point ofono  to use corr=
ect driver
by setting ENV{OFONO_DRIVER}=3D"le910" in udev.




--===============4150612825044754707==--

