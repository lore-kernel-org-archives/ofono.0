Content-Type: multipart/mixed; boundary="===============7028525216213969378=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: failed to start ofonod....
Date: Thu, 11 Jun 2009 12:21:18 +0300
Message-ID: <9abb677a75928bf307cc854d4aabff72@localhost>
In-Reply-To: <a0b5f4b30906110055j38ae0005t86f114ead305d8da@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7028525216213969378==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Thu, 11 Jun 2009 15:55:58 +0800, WuYongbo <wilbur.unail@gmail.com>
wrote:
> *$ sudo ofonod  -n -d
> ofonod[25234]: oFono version 0.0
> ofonod[25234]: Unable to hop onto D-Bus: Connection ":1.646" is not
allowed
> to own the service "org.ofono" due to security policies in the
> configuration
> file
> ofonod[25234]: Exit

Try:

$ sudo /etc/init.d/dbus reload

Cheers,
Aki

--===============7028525216213969378==--

