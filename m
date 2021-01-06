Content-Type: multipart/mixed; boundary="===============9180554784997400109=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Quectel EC200T USB: Problems with context activation
Date: Wed, 06 Jan 2021 13:52:27 -0600
Message-ID: <d9ecd585-4913-387c-eee0-92df034c3455@gmail.com>
In-Reply-To: <CAFiQ677uwX44Hv-Xx9c+dH===O6rqz2k0GzMGRKfujbVp6-zKw@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9180554784997400109==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sergei,

>     So far, all modems on this planet have honored the default properly...
> =

> Sorry for my misunderstanding. I should have read the RFC better but this=
 aspect =

> is defined
> properly only in the following clause -
> "TheConfiguration Option is used to inform the peer which control
> =

> characters MUST remain mapped when the peer sends them."
> =

> So I have managed to find this after your message. Thank you.
> =

>     So you have two options for fixing this:
>      =C2=A0 =C2=A0- Make GAtPPP negotiate a default ACCM in all cases
> =

>      =C2=A0 =C2=A0- Override the negotiated ACCM (using g_at_hdlc_set_rec=
v_accm for your
>     particular modem.
> =

> I think that this modem is buggy as you have clearly shown. I agree that =
it is =

> not a good idea to
> do something which does not follow the RFCs fine. But, I feel that the de=
fault =


I don't remember why we chose not to negotiate the RX ACCM.  Things may hav=
e =

worked wonderfully with the defaults, so maybe we just decided not to touch=
 it.

> value for ACCM
> is not that one we should use. Excuse me if I am too direct here, I am no=
t an =

> expert in this field
> but I think it is better for DTE to send a configuration request with ACC=
M =3D =

> 0x00000000
> as pppd does because this allows us to send more information in the same =
number =

> of bytes.
> Would you agree? If not I will override the negotiated ACCM, if it is lef=
t =


I think that makes sense.

> default, for this
> chinese modem because I do not feel that they could update the firmware t=
o =

> fulfill the RFC
> requirements=C2=A0in a reasonable=C2=A0amount of time if they even would.=
=C2=A0I do not think =

> that they
> would even find this necessary if I had told them.

Well, it isn't a 'requirement' to use the defaults.  What happened in this =

particular case is that we didn't explicitly tell the modem side what RX AC=
CM we =

want, and the modem firmware didn't use the defined default values.

I think it should be safe for us to use an ACCM of 0 instead of the RFC def=
ault. =

  But just in case, we should probably provide a way for the driver to over=
ride =

it if needed.

So what I would do is:

- Set REQ_OPTION_ACCM in the lcp init somewhere.  Set the initial value to =
be 0 =

as you suggest.
- Add g_at_ppp_set_accm() in order to allow drivers to provide a custom ACC=
M to =

negotiate, if needed.

Regards,
-Denis
--===============9180554784997400109==--

