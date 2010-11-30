Content-Type: multipart/mixed; boundary="===============0625028089505295027=="
MIME-Version: 1.0
From: Lucas, GuillaumeX <guillaumex.lucas@intel.com>
Subject: RE: [PATCH] stk: Add busy error for the display text command
Date: Tue, 30 Nov 2010 09:15:05 +0000
Message-ID: <9F3EABD6E3419B4C81F34EAABB4D4018813547D902@irsmsx501.ger.corp.intel.com>
In-Reply-To: <AANLkTimih-84mT+uFCXytpBXHpH-rdkx=_y=ML29tAXy@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0625028089505295027==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrzej

> =

> Hi Guillaume,
> =

> On 25 November 2010 09:44, Lucas, GuillaumeX
> <guillaumex.lucas@intel.com> wrote:
> > From: Guillaume Lucas <guillaumex.lucas@intel.com>
> >
> > According to the sequence 1.2 of the ETSI TS 102 384 a busy
> > screen error type must be returned for the display text
> > proactive command when the message is not urgent and if the
> > ME is not able to display the text.
> > ---
> > =C2=A0doc/stk-api.txt | =C2=A0 =C2=A01 +
> > =C2=A0src/stk.c =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A07 +++++++
> > =C2=A0src/stkagent.c =C2=A0| =C2=A0 12 ++++++++++--
> > =C2=A0src/stkagent.h =C2=A0| =C2=A0 =C2=A01 +
> > =C2=A04 files changed, 19 insertions(+), 2 deletions(-)
> >
> > diff --git a/doc/stk-api.txt b/doc/stk-api.txt
> > index b9ca592..79daee6 100644
> > --- a/doc/stk-api.txt
> > +++ b/doc/stk-api.txt
> > @@ -116,6 +116,7 @@ Methods =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 b=
yte RequestSelection(string
> title, byte icon_id,
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0cleared prior to the display of this text.
> >
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0Possible Errors:
> [service].Error.SimToolkit.GoBack
> > +
> =C2=A0[service].Error.SimToolkit.Busy
> >
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0Implementation notes:
> >
> > diff --git a/src/stk.c b/src/stk.c
> > index ac2e646..e6b78a4 100644
> > --- a/src/stk.c
> > +++ b/src/stk.c
> > @@ -1250,6 +1250,10 @@ static void display_text_cb(enum
> stk_agent_result result, void *user_data)
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0STK_RESULT_TYPE_NO_RESPONSE :
> STK_RESULT_TYPE_SUCCESS);
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;
> >
> > + =C2=A0 =C2=A0 =C2=A0 case STK_AGENT_RESULT_BUSY:
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 send_simple_response=
(stk,
> STK_RESULT_TYPE_TERMINAL_BUSY);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> > +
> =

> According to TS 102.223 on Screen Busy we also need to append a
> "additional info" field in the Terminal Busy response with a 1-byte
> value 01 ("screen is busy").

Yes you're right. I've seen this but after sending my patch.
I've another patch in my pipe regarding this but in top of the current busy=
 patch.
I'm waiting the integration of the busy patch to submit it.

> =

> Denis on IRC also wondered if this response should be allowed when the
> message is flagged urgent.
> =


According to the spec I think no, this type of response is not allowed when=
 the message is fluffed urgent.

> > =C2=A0 =C2=A0 =C2=A0 =C2=A0case STK_AGENT_RESULT_TERMINATE:
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0default:
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0send_simple_resp=
onse(stk,
> STK_RESULT_TYPE_USER_TERMINATED);
> > @@ -1363,6 +1367,7 @@ static void request_confirmation_cb(enum
> stk_agent_result result,
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;
> >
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0case STK_AGENT_RESULT_TERMINATE:
> > + =C2=A0 =C2=A0 =C2=A0 default:
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0send_simple_resp=
onse(stk,
> STK_RESULT_TYPE_USER_TERMINATED);
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;
> =

> Most of the other commands also allow a "Terminal busy" response in
> table 6.1 in section 6.11, without giving a specific "additional info"
> value.  I think it would be ok to treat them the same way as
> DisplayText and supply the "screen is busy" value, what do you think?
> =


You're right for the other commands but those cases are already handled by =
ofono.
In fact there is only for the display text proactive command that we can ha=
ve this error for a busy screen reason.

Regards,
Guillaume
---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

--===============0625028089505295027==--

