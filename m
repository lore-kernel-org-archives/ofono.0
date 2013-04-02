Content-Type: multipart/mixed; boundary="===============2978573088355253374=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: Re: [PATCH 5/5] handsfree-audio: Handle when .Connect() was already
 replied to
Date: Tue, 02 Apr 2013 18:11:55 -0300
Message-ID: <20130402211155.GD2715@samus>
In-Reply-To: <5154567D.9040308@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2978573088355253374==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

Sorry for the delay.

On 09:41 Thu 28 Mar, Denis Kenzior wrote:
> Hi Vinicius,
> =

> On 03/27/2013 07:13 PM, Vinicius Costa Gomes wrote:
> >In some cases, it is possible that when sco_connect_cb() is called
> >the .Connect() message (stored in card->msg) is not valid anymore.
> =

> Can you tell me what cases these are?
> =

> My thinking is that we will treat the connect callback specially.
> =

> If the driver calls the callback function, then it is assumed that
> no further action is necessary.  If the driver calls connect_sco(),
> then we assume that the callback function will never be called.

This is indeed the case (when the HFP 1.6 driver fallbacks to direct SCO
connection). The way I was writing it I was calling connect_sco() and the
callback inside the driver.

If we consider that when you call connect_sco() you hand the connection
responsability to the core, it even makes more sense. =


So, this patch can be ignored.


Cheers,
-- =

Vinicius

--===============2978573088355253374==--

