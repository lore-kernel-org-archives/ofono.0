Content-Type: multipart/mixed; boundary="===============7530071858826989963=="
MIME-Version: 1.0
From: Lucas, GuillaumeX <guillaumex.lucas@intel.com>
Subject: RE: STK DisplayText changes proposal
Date: Wed, 24 Nov 2010 08:00:07 +0000
Message-ID: <9F3EABD6E3419B4C81F34EAABB4D4018813542BDED@irsmsx501.ger.corp.intel.com>
In-Reply-To: <AANLkTikaLZOFj2to93n9sMGYXtO29StLogb3j7PDgw=S@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7530071858826989963==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> =

> On 23 November 2010 18:08, Denis Kenzior <denkenz@gmail.com> wrote:
> > On 11/23/2010 10:55 AM, Andrzej Zaborowski wrote:
> >> As for the clear after delay flag, there's a check for it in
> >> display_text_cb (line 1248). =C2=A0As far as I can make out the only
> >> difference is the response sent to the SIM.
> >
> > So it has been a long time since those discussions, but it does seem
> to
> > me that using a higher timeout in the case of 'wait_for_user' flag
> seems
> > like a good idea. =C2=A0Do you remember why we left this out?
> =

> No, I don't, I'll send a patch to use the normal timeout instead of
> short timeout when clearing after user action is requested.  As for
> the proposal to add a parameter clear_after_delay and the ScreenBusy
> response I'm fine with both of them (as I don't think the saving from
> hiding these details is worth it) but I leave it up to you and
> Guillaume.  It seems that a user action always clears the message but
> it may be good to display a "confirm" button anyway.  The ScreenBusy
> response is also possible for other proactive commands so for
> consistency would need to be added there too.
> =


For the 'clear_after_delay' flag your patch to used the normal timeout and =
not the short when a user request is waiting will be probably sufficient fo=
r the moment. For the ScreenBusy response I'm agree with you that this resp=
onse is also possible for other proactive commands. I'll do the necessary p=
atch for this.

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

--===============7530071858826989963==--

