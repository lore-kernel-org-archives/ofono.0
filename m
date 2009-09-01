Content-Type: multipart/mixed; boundary="===============6391915655978013024=="
MIME-Version: 1.0
From: Christensen, Mikkel <mlc@ti.com>
Subject: RE: GPRS support for Ofono
Date: Tue, 01 Sep 2009 22:30:40 +0200
Message-ID: <E49DAF743FB3E9469ED423C0D3DB5F1CCE9168C0@dnce01.ent.ti.com>
In-Reply-To: <4A9D8160.6000404@eclis.ch>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6391915655978013024==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 01, 2009 at 15:17:36, Jean-Christian de Rivaz wrote:
> Thanks for the explanation. I will start learning how phonet works. =

> But I expect there exists a PPP stack somewhere in phonet because the =

> modem I use don't have one. And I don't think it's possible to have a =

> IP link over GPRS without the PPP protocol between them.

On most modern modems there is no need to have a PPP link between the Appli=
cation Processor (AP) and the modem. They will often be able to transmit IP=
 traffic directly to the AP.

Hence there is no PPP stack in phonet. If your modem does not support raw I=
P messaging (or any other datagram service) to the AP you will probably be =
stuck with good old PPP.




--===============6391915655978013024==--

