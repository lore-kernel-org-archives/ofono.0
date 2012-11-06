Content-Type: multipart/mixed; boundary="===============7601500526175249516=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: ofono and connecting to an APN
Date: Tue, 06 Nov 2012 09:05:38 -0600
Message-ID: <50992742.7080109@gmail.com>
In-Reply-To: <op.wncv7qjryxxkfz@pohanka-pc>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7601500526175249516==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jan,

> excuse me for a newbie question, but I would like to know if ofono
> daemon is responsible for connecting a modem to APN for sending MMS or
> browsing internet. How it is usually done on devices using ofono? It is

oFono is the one establishing the GPRS context.  Some other daemon makes =

the control decisions on what context should be established and when. =

e.g. connman makes this decision in the case of Type=3Dinternet contexts =

and something like mmsd makes this decision for Type=3Dmms contexts.


> task for another daemon like connman or something similar? If yes how
> these daemons communicate with ofono when they are grabbing the
> interface for making ppp conection?
>

I'm not quite sure I understand the question?  The context establishment =

is achieved using org.ofono.ConnectionContext interface, e.g. by setting =

the 'Active' property.  The PPP connection is done by oFono itself.

Regards,
-Denis

--===============7601500526175249516==--

