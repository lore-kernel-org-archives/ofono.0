Content-Type: multipart/mixed; boundary="===============5542103565499229566=="
MIME-Version: 1.0
From: Christensen, Mikkel <mlc@ti.com>
Subject: RE: GPRS support for Ofono
Date: Tue, 01 Sep 2009 21:27:53 +0200
Message-ID: <E49DAF743FB3E9469ED423C0D3DB5F1CCE9168A6@dnce01.ent.ti.com>
In-Reply-To: <4A9D6FD3.7040207@eclis.ch>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5542103565499229566==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 01, 2009 at 14:02:43, Jean-Christian de Rivaz wrote:
> I failed to understand how the "isi_gprs" code in your patch =

> communicate with a PPP stack. For example, I currently use a project =

> where the APN is configured and a connection open with it. Then a pppd =

> process is started to establish the IP link. It seem that you make =

> this in a other (and certainly
> better) way, but I missed the big picture.

The best way to do this is without PPP and this is probably what Ismo is do=
ing. You would just create a new net_device like "eth0" and hide all the IS=
I and cellular messaging behind that interface providing a clean IP network=
 device.

Best regards,
 Mikkel Christensen=20

--===============5542103565499229566==--

