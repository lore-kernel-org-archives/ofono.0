Content-Type: multipart/mixed; boundary="===============7955963251853290702=="
MIME-Version: 1.0
From: Radek Polak <psonek2@seznam.cz>
Subject: Re: Polling CLCC error handling on Option modem (GTA04)
Date: Thu, 08 Mar 2012 23:47:00 +0000
Message-ID: <201203082347.01005.psonek2@seznam.cz>
In-Reply-To: <4F592AB3.2040206@eclis.ch>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7955963251853290702==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thursday 08 March 2012 21:54:59 Jean-Christian de Rivaz wrote:

> I observed on a SIMCOM modem that show the same issue, that the CLCC
> error is temporary. It seem to occurs when the CLCC command is proceeded
> by the modem at the same time that something change in the calling
> state. The next CLCC command will return the expected result. Can you
> observe that same behavior on your modem ?

Hi,
yes i do. In fact the workaround is now in oFono GIT [1].

Regards

Radek

[1] =

http://git.kernel.org/?p=3Dnetwork/ofono/ofono.git;a=3Dcommitdiff;h=3Debac4=
38d9325c34bfe22322c6234e25c86e125d7



--===============7955963251853290702==--

