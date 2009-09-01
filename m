Content-Type: multipart/mixed; boundary="===============7410841646022875655=="
MIME-Version: 1.0
From: Jean-Christian de Rivaz <jc@eclis.ch>
Subject: Re: GPRS support for Ofono
Date: Tue, 01 Sep 2009 21:02:43 +0200
Message-ID: <4A9D6FD3.7040207@eclis.ch>
In-Reply-To: <a4e57c0e0909010409m1ccd4326scf28151fe8afb859@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7410841646022875655==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Ismo Puustinen a =C3=A9crit :
> I started working on Ofono GPRS support.

Hello,

With GPRS support, Ofono become very interesting!

I failed to understand how the "isi_gprs" code in your patch communicate
with a PPP stack. For example, I currently use a project where the APN
is configured and a connection open with it. Then a pppd process is
started to establish the IP link. It seem that you make this in a other
(and certainly better) way, but I missed the big picture.

Best Regards,

Jean-Christian de Rivaz

--===============7410841646022875655==--

