Content-Type: multipart/mixed; boundary="===============5323904248943897346=="
MIME-Version: 1.0
From: Jean-Christian de Rivaz <jc@eclis.ch>
Subject: Re: GPRS support for Ofono
Date: Tue, 01 Sep 2009 22:17:36 +0200
Message-ID: <4A9D8160.6000404@eclis.ch>
In-Reply-To: <200909012225.47712.remi@remlab.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5323904248943897346==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

R=C3=A9mi Denis-Courmont a =C3=A9crit :
> Le mardi 1 septembre 2009 22:02:43 Jean-Christian de Rivaz, vous avez =C3=
=A9crit :
>> With GPRS support, Ofono become very interesting!
>>
>> I failed to understand how the "isi_gprs" code in your patch communicate
>> with a PPP stack.
> =

> That would be because it does NOT use a PPP stack.
> =

> ISI modems have their own IP path using a dedicated kernel driver =

> (net/phonet/pep-gprs.c in Linux 2.6.28 amd later). There is no point in u=
sing =

> the PPP line discipline.

Thanks for the explanation. I will start learning how phonet works. But
I expect there exists a PPP stack somewhere in phonet because the modem
I use don't have one. And I don't think it's possible to have a IP link
over GPRS without the PPP protocol between them.

Jean-Christian de Rivaz

--===============5323904248943897346==--

