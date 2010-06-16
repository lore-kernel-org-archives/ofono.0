Content-Type: multipart/mixed; boundary="===============3799313686107719848=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: ATModem-PPP Doubts
Date: Tue, 15 Jun 2010 23:07:42 -0500
Message-ID: <201006152307.42363.denkenz@gmail.com>
In-Reply-To: <AANLkTikuv3eSYcZa-7SjeJStY9fn04np95rxTYnlLjw3@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3799313686107719848==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Arun,

> Hi,
> =

> We using a modem through atmodem interface. While testing the
> functionalities, we found that the dataconnectionmanager interface is not
> coming up.
> =

> We enabled the gprs modem driver creation and context creation in by addi=
ng
> it in atgen.c
> =

> atgen_post_sim(struct ofono_modem *modem)
> {
> ---------------------------------------------------------------
> ---------------------------------------------------------------
> gprs =3D ofono_gprs_create(modem,0, "atmodem", chat);
> gc =3D ofono_gprs_context_create(modem, 0, "atmodem", chat);
> =

> if (gprs && gc)
>         ofono_gprs_add_context(gprs, gc);
> =

> mw =3D ofono_message_waiting_create(modem);
> if (mw)
>         ofono_message_waiting_register(mw);
> =

> }
> After this change the dataconnection manager interface was shown in the
> ./list-medem script.
> =

> 1) Is this a correct change ? why was this not present in atgen? Could any
> one clarify?

The change is correct.  Our ppp support is still experimental, so probably =
no =

one got around to enabling this in atgen.  Patches welcome.

> =

> =

> We wanted PDP context activation through atmodem and we could see that our
> modem returns
> *at+cgdcont=3D?
> +CGDCONT: (1-255),("IP","IPV6"),,,(0),(0,1,2)
> =

> OK
> *
> where as Nokia modem (E63) returns
> =

> *at+cgdcont=3D?
> +CGDCONT: (1-2),"IP",,,(0),(0)
> +CGDCONT: (1-2),"IPV6",,,(0),(0)
> =

> OK
> *
> The modem we use is returning the string in a different way from 3GPP
>  27.007 , which says to return the multiple PDP types are separate lines.

Correct, we tend to go by the book.  This is one of the areas where atgen i=
s =

useful; it tells you quite quickly where your modem is compliant / not =

compliant with 27.007.

> =

> We modified the Gprs.c file in atmodem driver, to search for the list of
> strings, and we are able to make PDP context activation.
> =

> 2) Is this change an accepted one?

Depends on how you did it.  In general there are three acceptable ways:

- Accept both compliant and non-compliant format if possible while maintain=
ing =

a high level of strictness.
- If the above is not feasible, quirk the functionality by sending a =

OFONO_VENDOR_* flag to the atom driver and writing the necessary quirk hand=
ling =

code there.  This requires a proper modem driver as atgen does not use quir=
ks.
- If both of the above are too invasive, then writing your own atom driver =
& =

modem driver is an option

Sounds like option 1 or 2 is likely the case for you.

> =

> 3) Currently i am stuck at the PPP (IPCP stage), how can i link this
>  context (and PPP link) to my Ubuntu's network manager?

I assume you're not failing to negotiate the IPCP parameters, otherwise we'=
d =

like to see a log of gsmdial with pppdump option enabled for your modem.

Monitor ofono's PrimaryContext interface of the context you're activating. =
 It =

will send you all the details of the ppp connection, including net interfac=
e, =

ip, and dns information.  =


Integrating this into NetworkManager is left as an exercise to the reader :=
)  =


Regards,
-Denis

--===============3799313686107719848==--

