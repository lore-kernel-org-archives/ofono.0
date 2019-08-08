Content-Type: multipart/mixed; boundary="===============4344720737335828079=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Duplicated contexts...
Date: Thu, 08 Aug 2019 14:10:21 -0500
Message-ID: <5ce7b703-3abf-49e3-efa7-3a89259c5d4d@gmail.com>
In-Reply-To: <CAHB-PjnzsOxc-ZbH95LQ94R05wCUz4UCdhgphNiseubEfCwZsQ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4344720737335828079==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Richard,

> 21:01:52 daemon.info <http://daemon.info> ofonod[547]: Aux: < \r\n+CIEV: =

> 2,2\r\n
> 21:01:52 daemon.info <http://daemon.info> ofonod[547]: Aux: < \r\n+CGEV: =

> ME PDN ACT 4\r\n
> 21:01:52 daemon.info <http://daemon.info> ofonod[547]: Aux: < \r\n+CGEV: =

> NW CLASS "B"\r\n
> 21:01:52 daemon.info <http://daemon.info> ofonod[547]: Aux: < \r\n+CREG: =

> 5,"0080","00000006",7\r\n
> So I think the interesting part is the ME PDN ACT here. and you see =

> before the cops=3D0 sim is still reading stuff...

As I said earlier, your modem is getting set Online way before the SIM =

has been initialized.  The only reason for setting Online that early is =

if you have a locked SIM and you need to make an emergency call or you =

have no SIM at all and need to do the same.

For normal cases going Online before the SubscriberIdentity has been =

probed was never a good idea.  I'm all for making that work, but you =

will likely find that doing this will uncover other issues.

> =

> Good point. I vote for option 2, I think its less intrusive. agree its =

> an OK way forward?
> =


I think either option is about the same amount of work, Option 1 being =

more elegant but a bit more invasive, yes.

Regards,
-Denis

--===============4344720737335828079==--

