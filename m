Content-Type: multipart/mixed; boundary="===============4441833565309938132=="
MIME-Version: 1.0
From: Jan Pohanka <xhpohanka@gmail.com>
Subject: Re: sierra wireless MC8795V
Date: Mon, 16 Jul 2012 14:30:28 +0200
Message-ID: <op.whjg02aryxxkfz@pohanka-pc>
In-Reply-To: <op.whjberu4yxxkfz@pohanka-pc>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4441833565309938132==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> Is the support for sierra modems broken, or I'm missing something?
>
> I have added this line to ofono udev rules
> ATTRS{idVendor}=3D=3D"1199", ATTRS{idProduct}=3D=3D"683c",  =

> ENV{OFONO_DRIVER}=3D"sierra"

Ok. This problem is not a part of ofono. I'm not sure why, but udev does
not trigger rules in ofono.conf. When I trigger them manually, ofono
detects the modem correctly. Nevertheless ofono is not able to make a call
with MC8795V...

Jan

--===============4441833565309938132==--

