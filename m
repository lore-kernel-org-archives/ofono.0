Content-Type: multipart/mixed; boundary="===============9117483739079908485=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: Re: Issue with service reporting on a 4G modem
Date: Mon, 19 Feb 2018 18:02:13 +0100
Message-ID: <c2267ed4-5ae8-e7db-565e-9c694aa138ad@monom.org>
In-Reply-To: <AM4PR01MB18739E5535492213F423A9719CCB0@AM4PR01MB1873.eurprd01.prod.exchangelabs.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9117483739079908485==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Bassem,

[added ofono mailing list]

On 02/16/2018 11:24 AM, Bassem BOUBAKER wrote:
> Hello community,
> =

> I'm having connman version 1.31 along side with ofono running on my board.
> =

> When I activate a context on my 4G modem using ofono, connman creates two=
 services: one is cellular and the other is ethernet.
> =

> *AR Wired ethernet_XX_cable
> *AO XXX cellular_XXX_context1
> =

> In this case, the ideal state is that connman reports only one cellular t=
echnology related to the modem.
> =

> When digging into the logs, I feels like a new ethernet device is enumera=
ted and connman creates the appropriate service for it.
> =

> Knowing that my modem net interface is using "cdc_ether" driver, does any=
one have an idea about what could be the issue here?

 From you description I understand that the modem creates an additional =

ethernet interface? Could you post the corresponding logs (or post a =

link to the logs)?

I am also not sure what the exact question is. I suspect you want to see =

only one interface and not two..

Thanks,
Daniel

--===============9117483739079908485==--

