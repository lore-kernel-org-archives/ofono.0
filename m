Content-Type: multipart/mixed; boundary="===============3701480972625247606=="
MIME-Version: 1.0
From: Jarko Poutiainen <jarko.poutiainen@tieto.com>
Subject: Re: [PATCH 6/9] gatchat: fix gatsyntax to support +CPOS
Date: Thu, 10 Mar 2011 16:19:46 +0200
Message-ID: <1299766786.3234.23.camel@poutijar-desktop>
In-Reply-To: <4D77FCE8.5040905@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3701480972625247606==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Denis,

On Thu, 2011-03-10 at 00:19 +0200, Denis Kenzior wrote:
> Hi Jarko,
> =

> On 03/08/2011 05:00 AM, Jarko Poutiainen wrote:
> > ---
> >  gatchat/gatsyntax.c |   10 ++++++++--
> >  1 files changed, 8 insertions(+), 2 deletions(-)
> > =

> > diff --git a/gatchat/gatsyntax.c b/gatchat/gatsyntax.c
> > index 2fc70b8..a85bc66 100644
> > --- a/gatchat/gatsyntax.c
> > +++ b/gatchat/gatsyntax.c
> > @@ -90,7 +90,11 @@ static GAtSyntaxResult gsmv1_feed(GAtSyntax *syntax,
> >  =

> >  		case GSMV1_STATE_INITIAL_CR:
> >  			if (byte =3D=3D '\n')
> > -				syntax->state =3D GSMV1_STATE_INITIAL_LF;
> > +				if (*len =3D=3D 2) {
> =

> You simply cannot do this.  The whole idea behind the state machine in
> GAtSyntax is that your data is a byte-stream.  There are no markers, and
> you can make no assumptions on the length of the buffer that is fed into
> this function.  e.g. if you're unlucky you can get:
> =

> gsmv1_feed("\r")
> gsmv1_feed("\n")
> =

Point taken.

> =

> Is there any particular reason why CPOS is not re-using the prompting
> feature of AT commands and has to invent its own?  If you think about
> this a bit harder you will realize that the spec is *completely* broken
> here and introduces a parser ambiguity which cannot be reliably fixed.
> =

Well thinking about it a: I noticed the same thing when trying to
implement b: I didn't write specification c: I'm just the guy who was
supposed to implement this. So I agree doesn't make sense but need to
find some solution for this anyway.

> At this point my only suggestion is that you need to set a parser hint
> after every CPOS command sent to the modem.  Or better yet, push a
> change request to 27.007 to use proper prompting procedures.
> =

Ok I'm not quite sure what you mean. If you mean using syntax->set_state
with hint say G_AT_SYNTAX_EXPECT_PROMPT I still need to somehow get
state to G_AT_SYNTAX_RESULT_PROMPT which I can by if
G_AT_SYNTAX_EXPECT_PROMPT then GSMV1_STATE_PROMPT and then in gsmv1_feed
I check that if '\r' and then '\n' then G_AT_SYNTAX_RESULT_PROMPT. =

Is that what you mean?
The next question is where do I call the set_hint and how? If on driver
the problem is that I need to get the driver to be aware of _GAtSyntax
or more precisely set_hint method. If on gatchat the problem is to check
if the command is +CPOS and do it efficiently.
What comes to making a change request to 27.007. I think that's a very
long road to take.

> Regards,
> -Denis

Br,
Jarko


--===============3701480972625247606==--

