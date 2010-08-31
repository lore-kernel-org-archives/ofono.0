Content-Type: multipart/mixed; boundary="===============5991412651899421225=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Clarification on USSD support in ofono
Date: Tue, 31 Aug 2010 11:13:21 -0500
Message-ID: <4C7D2A21.8030605@gmail.com>
In-Reply-To: <B668883EB5DD7144ADFC248A72176EA802A0E1B0@fioues07.ebgroup.elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5991412651899421225==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jeevaka,

On 08/31/2010 10:39 AM, Jeevaka.Badrappan(a)elektrobit.com wrote:
> Hi,
>  =

>> Yes, the driver api may need a change like this.  The current API was
> created based on the fact that many modems don't understand anything
> other than DCS =3D 15.  However =

>> with STK's "Send USSD" command, sending the requested DCS as-is is
> probably our best bet.
> =

>> There is a hope that most modems implement Send USSD in their firmware
> so that ofono doesn't have to do anything (this is the case on the Texas
> Instruments Calypso modem), > do you have a modem that you know does not
> handle Send USSD internally?  Of course it makes sense to implement the
> fallback in ofono anyway.
> =

>> Have you been working on implementation of this command? I'm asking to
> avoid duplicating the effort.
> =

> No, I dont have any modem which doesn't handle the Send USSD command
> internally. =

> =

> Yes, I have done some implementation. Planning to test it with the
> phonesim. If needed, I can do the implementation of the Send USSD
> command.

Can you send what you have so far to the list?  Andrew and Yang are
actually already looking into this, so it might be nice for the three of
you to be on the same page and not duplicate effort.

Thanks,
-Denis

--===============5991412651899421225==--

