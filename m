Content-Type: multipart/mixed; boundary="===============7261298735964456014=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: oFono + Quectel EC25 module: connecting to network,
 ppp0 interface help
Date: Wed, 08 Feb 2017 15:10:16 -0600
Message-ID: <87a76a55-a2d5-4572-30c9-6e975315b8ea@gmail.com>
In-Reply-To: <CAOZ0rctdUO7HcZmq2zH+6+i=YX=b2QibvsTE51UDbP9CmF1PJQ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7261298735964456014==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Demetrius,

>
> I've included the log of oFono debug. The output is form me: plugging
> in modem -> enable-modem -> online-modem -> scan-for-operators ->
> test-network-registration

Your log contains:
"GPRS not supported on this device"

which would imply that gprs atom driver has failed to initialize =

properly.  See HACKING for how to enable AT command tracing (e.g. =

exporting OFONO_AT_DEBUG) and figure out why this fails.

Regards,
-Denis

--===============7261298735964456014==--

