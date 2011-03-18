Content-Type: multipart/mixed; boundary="===============8644065122761610764=="
MIME-Version: 1.0
From: Jarko Poutiainen <jarko.poutiainen@tieto.com>
Subject: Re: [PATCH 07/12] gatchat: implementation for +CPOS send
Date: Fri, 18 Mar 2011 15:05:19 +0200
Message-ID: <1300453519.9383.48.camel@poutijar-desktop>
In-Reply-To: <4D82E2AF.4060901@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8644065122761610764==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Fri, 2011-03-18 at 06:42 +0200, Denis Kenzior wrote:
> Hi Jarko,
> =

> On 03/11/2011 06:23 AM, Jarko Poutiainen wrote:
> > ---
> >  gatchat/gatchat.c |   13 +++++++++++++
> >  1 files changed, 13 insertions(+), 0 deletions(-)
> > =

> > diff --git a/gatchat/gatchat.c b/gatchat/gatchat.c
> > index 3fd564d..64f131d 100644
> > --- a/gatchat/gatchat.c
> > +++ b/gatchat/gatchat.c
> > @@ -1468,6 +1468,19 @@ guint g_at_chat_send_pdu_listing(GAtChat *chat, =
const char *cmd,
> >  					listing, func, user_data, notify);
> >  }
> >  =

> > +guint g_at_chat_send_and_expect_short_prompt(GAtChat *chat, const char=
 *cmd,
> > +			const char **prefix_list, GAtResultFunc func,
> > +			gpointer user_data, GDestroyNotify notify)
> > +{
> > +	if(chat !=3D NULL)
> > +		chat->parent->syntax->set_hint(chat->parent->syntax,
> > +					G_AT_SYNTAX_EXPECT_SHORT_PROMPT);
> =

> So unfortunately you can't do this.  GAtChat is a command queue and we
> might be in the process of sending / receiving responses for multiple
> commands that are ahead of this one.  So you can't really manipulate the
> syntax directly here.  You have to do this only once the CPOSR has been
> sent on the wire.
> =

Ok, thanks. Still having trouble to understand GAtChat. =

Not just sure where I should set the hint then but I get your point.
Now I'm also a little confused because previously you suggested that I'd
make a new g_at_chat_send variant that would set the hint so what did
you mean by it then if not this?

> > +
> > +	return at_chat_send_common(chat->parent, chat->group,
> > +					cmd, prefix_list, FALSE, NULL,
> > +					func, user_data, notify);
> > +}
> > +
> >  gboolean g_at_chat_cancel(GAtChat *chat, guint id)
> >  {
> >  	/* We use id 0 for wakeup commands */
> =

> Regards,
> -Denis
Br,
Jarko


--===============8644065122761610764==--

