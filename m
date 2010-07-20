Content-Type: multipart/mixed; boundary="===============5866090834525449291=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi@remlab.net>
Subject: Re: ISI drivers test simulator
Date: Tue, 20 Jul 2010 12:25:44 +0200
Message-ID: <563d79ac52a667af8ebd79bca6afd9b9@chewa.net>
In-Reply-To: <A9AC1023FCA4654D92AC24C2A8F6A092017C1472@renesas4bis.renesas-rdf.local>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5866090834525449291==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Tue, 20 Jul 2010 11:28:59 +0200, "Alan KREUTZ"
<alan.kreutz.vz@rdf.renesas.com> wrote:
> 1-    Is, the fact to test oFono ISI driver with a Nokia phone, the only
> way to test ISI drivers or is there a simulator like phonesim for ISI
> driver?

Yes.

> 2-    How to test oFono with a Nokia mobile? I believe that the plugin
> usbpnmodem.c must be used to communicate with modem via USB and it seems
> that Maemo (or MeeGo) is mandatory too. Is this correct?

Yes and no. Some of the oFono atoms from the ISI driver do work with S60
phones and S40 phones too.

> 3-    And last question, if a Nokia modem is connected via USB to a PC,
> is the Nokia's modem disconnected from UI part in order to receive and
> treat only messages from host (PC/oFono)?

Some features won't work, notably SMS reception.

-- =

R=C3=A9mi Denis-Courmont
http://www.remlab.net
http://fi.linkedin.com/in/remidenis


--===============5866090834525449291==--

