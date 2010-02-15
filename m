Content-Type: multipart/mixed; boundary="===============2444910926532105792=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH, rfc] Handle network-initiated ussd requests.
Date: Mon, 15 Feb 2010 15:24:10 -0600
Message-ID: <201002151524.10602.denkenz@gmail.com>
In-Reply-To: <fb249edb1002151212r255407bejbdb0214140a090bd@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2444910926532105792==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> Hi,
> =

> On 15 February 2010 18:03, Denis Kenzior <denkenz@gmail.com> wrote:
> >>       } else {
> >>               ofono_error("Received an unsolicited USSD, ignoring for
> >> now..."); DBG("USSD is: status: %d, %s", status, str);
> >>
> >> +             if (ussd->driver->respond_not_supported)
> >> +                     ussd->driver->respond_not_supported(ussd,
> >> +                                     ussd_not_supported_callback,
> >> NULL); +
> >>               return;
> >
> > There's no reason for this else clause to exist now.  The above else if
> > condition is handling this case too.  Just look carefully at ussd driver
> > for AT command modems, we always call back first, then issue ussd_notif=
y.
> >  This is the case for both modems with and without cancel support.
> =

> This is true but we might also get a request when we're in
> USSD_STATE_USER_ACTION and then by my reading we should reply that the
> user is busy i.e. send a cancel, what do you think?  I left the clause
> in the patch but removed the unneeded "ussd->pending" check.

In everything I've researched I understood that there can't be two concurre=
nt =

ussd sessions.  The only things that can happen during USSD_STATE_USER_ACTI=
ON:
- Network sends a timed out notification or terminates the ussd action
- someone else actually responds to the USSD (other local client has =

responded)

I think we should simply ignore the re-entrant case (which USSD operation a=
re =

you canceling? First or second?) until we're told otherwise.  However, we =

_should_ handle the network termination / other local client has responded =

cases.

Also, it might be a good idea to have a State property that shows the curre=
nt =

USSD request state.

Regards,
-Denis

--===============2444910926532105792==--

