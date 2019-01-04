Content-Type: multipart/mixed; boundary="===============7534128231847410375=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: PPP broken by 6fc119d9eaee5f9cc37a5a7198d1c55ef98fd645
Date: Fri, 04 Jan 2019 15:48:33 +0100
Message-ID: <CAKSBH7HcbAF=-APHV7O-C7a6ZnFegCPJtkf4Li6rqG7VG7kLmw@mail.gmail.com>
In-Reply-To: <CAPsFW+SnOenGf+qcfujLK43b0WPHrQDTdu=ecyncwO1-YXnS-A@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7534128231847410375==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

On Fri, Jan 4, 2019 at 3:40 PM Philippe De Swert
<philippedeswert@gmail.com> wrote:
>
> Hi Giacinto,
>
> Thanks for looking at this so quickly!
>
> On 04/01/2019, Giacinto Cifelli <gciofono@gmail.com> wrote:
> >> The comments for a88662d23c45f49d9af5a508d4d0a778950b2420 made me
> >> suspect it is this part of the patch that broke it:
> >>
> >> diff --git a/gatchat/ppp_lcp.c b/gatchat/ppp_lcp.c
> >> index df9cd0ef..3fe38217 100644
> >> --- a/gatchat/ppp_lcp.c
> >> +++ b/gatchat/ppp_lcp.c
> >> @@ -279,6 +279,9 @@ static enum rcr_result lcp_rcr(struct pppcp_data
> >> *pppcp,
> >>                                 *new_len =3D 4;
> >>
> >>                                 return RCR_NAK;
> >> +
> >> +                       case G_AT_PPP_AUTH_METHOD_NONE:
> >> +                               return RCR_REJECT;

can you change your code to:
     return RCR_ACCEPT;

this is what I posted in the first attempt to commit, but Denis
objected that a reject would be in order.
I still believe that an accept would select as before the default
operation at the end of the function, which is just... return
RCR_ACCEPT; (line 354 on the latest commit as of today)

If this works, I can submit a new patch, or you can do it.

@Denis Kenzior : any opinion on this?

> >
> > I remember this, I added it because of a suggestion that couldn't just
> > ignore it.
> > Is your PDP context configured for AUTH_NONE, PAP or CHAP?
>
> AUTH_NONE.
>
> > And what happens if you change it?
>
> It took me a while to understand this was the issue as I had another
> sim who would request CHAP and that one worked (even if it was empty
> username and pass, operators are weird..)
>
> So from what I have seen I would say the issue is only with AUTH_NONE.
> Most likely RCR_REJECT is the wrong thing to send, but my knowledge of
> PPP is basically whatever I read today and a quick look at the RFC so
> I am not in a position to comment in more detail on that. What I do
> know is that removing that bit made it work for me.
>
> Cheers,
>
> Philippe

Regards,
Giacinto

--===============7534128231847410375==--

