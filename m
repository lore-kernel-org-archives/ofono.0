Content-Type: multipart/mixed; boundary="===============5679447908363213187=="
MIME-Version: 1.0
From: Sjur =?unknown-8bit?q?Br=C3=A6ndeland?= <sjurbren@gmail.com>
Subject: Re: [RFC PATCH] gprs: add function to handle activated context
Date: Tue, 18 Jan 2011 00:15:37 +0100
Message-ID: <AANLkTimchqt9kKH2p2ZP1ahhBpti=-+e7My_Nzi6UzKT@mail.gmail.com>
In-Reply-To: <AANLkTimLmnoJcTUyVw1+BWoU8ex9+hjtRsD2PWO0uiuy@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5679447908363213187==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka.

Pekka Pessi <ppessi@gmail.com> wrote:
>> I'm not sure we have any problems with Network Initiated Connection in o=
Fono,
>> unless someone is planning to add support for Network Initiated
>> Primary Contexts / PDN Connections.
>
> AFAIK the initial LTE default bearer context can be network-initiated,
> and the CID 0 falls outside the range from +CGDCONT.

If I am not mistaken the initial LTE default bearer is initiated by the
ME in a combined attach procedure, and not by the Network.
(but the Dedicated bearers / Secondary PDPs are activated by the Network).

Regards,
Sjur

--===============5679447908363213187==--

