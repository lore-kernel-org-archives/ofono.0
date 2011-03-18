Content-Type: multipart/mixed; boundary="===============4189287467909727300=="
MIME-Version: 1.0
From: Jarko Poutiainen <jarko.poutiainen@tieto.com>
Subject: Re: [PATCH 08/12] gatchat: fix gatsyntax to support +CPOS
Date: Fri, 18 Mar 2011 15:56:42 +0200
Message-ID: <1300456602.9383.69.camel@poutijar-desktop>
In-Reply-To: <4D82E55E.3050503@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4189287467909727300==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Fri, 2011-03-18 at 06:53 +0200, Denis Kenzior wrote:
> Hi Jarko,
> =

> On 03/11/2011 06:23 AM, Jarko Poutiainen wrote:
> > ---
> >  gatchat/gatsyntax.c |   19 +++++++++++++++++++
> >  1 files changed, 19 insertions(+), 0 deletions(-)
> > =

> > diff --git a/gatchat/gatsyntax.c b/gatchat/gatsyntax.c
> > index 2fc70b8..f1d896b 100644
> > --- a/gatchat/gatsyntax.c
> > +++ b/gatchat/gatsyntax.c
> > @@ -64,6 +64,9 @@ static void gsmv1_hint(GAtSyntax *syntax, GAtSyntaxEx=
pectHint hint)
> >  	case G_AT_SYNTAX_EXPECT_MULTILINE:
> >  		syntax->state =3D GSMV1_STATE_GUESS_MULTILINE_RESPONSE;
> >  		break;
> > +	case G_AT_SYNTAX_EXPECT_SHORT_PROMPT:
> > +		syntax->state =3D GSMV1_STATE_PROMPT;
> > +		break;
> >  	default:
> >  		break;
> >  	};
> > @@ -195,6 +198,13 @@ static GAtSyntaxResult gsmv1_feed(GAtSyntax *synta=
x,
> >  				i +=3D 1;
> >  				res =3D G_AT_SYNTAX_RESULT_PROMPT;
> >  				goto out;
> > +			} else if (byte =3D=3D '\r')
> > +				break;
> > +			else if (byte =3D=3D '\n') {
> > +				syntax->state =3D GSMV1_STATE_IDLE;
> > +				i +=3D 1;
> > +				res =3D G_AT_SYNTAX_RESULT_PROMPT;
> > +				goto out;
> =

> Please just create a dedicated state for this one and don't hack the
> PROMPT state.
> =

Ok, good point.

> >  			}
> >  =

> >  			syntax->state =3D GSMV1_STATE_RESPONSE;
> > @@ -239,6 +249,8 @@ static void gsm_permissive_hint(GAtSyntax *syntax, =
GAtSyntaxExpectHint hint)
> >  {
> >  	if (hint =3D=3D G_AT_SYNTAX_EXPECT_PDU)
> >  		syntax->state =3D GSM_PERMISSIVE_STATE_GUESS_PDU;
> > +	else if (hint =3D=3D G_AT_SYNTAX_EXPECT_SHORT_PROMPT)
> > +		syntax->state =3D GSM_PERMISSIVE_STATE_PROMPT;
> >  }
> >  =

> >  static GAtSyntaxResult gsm_permissive_feed(GAtSyntax *syntax,
> > @@ -298,6 +310,13 @@ static GAtSyntaxResult gsm_permissive_feed(GAtSynt=
ax *syntax,
> >  				i +=3D 1;
> >  				res =3D G_AT_SYNTAX_RESULT_PROMPT;
> >  				goto out;
> > +			} else if (byte =3D=3D '\r')
> > +				break;
> > +			else if (byte =3D=3D '\n') {
> > +				syntax->state =3D GSM_PERMISSIVE_STATE_IDLE;
> > +				i +=3D 1;
> > +				res =3D G_AT_SYNTAX_RESULT_PROMPT;
> > +				goto out;
> =

> Same comment here, and man you better pray that your modem doesn't
> insert unsolicited notifications between you sending a CPOSR and you
> receiving a prompt ;)
> =

Yep. Btw now that I think about it, shouldn't the patch that I proposed
to ste.c help? I know it's ste specific solution but still..

> >  			}
> >  =

> >  			syntax->state =3D GSM_PERMISSIVE_STATE_RESPONSE;
> =

> Regards,
> -Denis
Br,
Jarko



--===============4189287467909727300==--

