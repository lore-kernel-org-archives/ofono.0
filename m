Content-Type: multipart/mixed; boundary="===============6975915022160384727=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: STK DisplayText changes proposal
Date: Tue, 23 Nov 2010 10:05:37 -0600
Message-ID: <4CEBE651.4080502@gmail.com>
In-Reply-To: <9F3EABD6E3419B4C81F34EAABB4D4018813542BD15@irsmsx501.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6975915022160384727==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guillaume,

On 11/23/2010 09:33 AM, Lucas, GuillaumeX wrote:
> Hi,
> =

> According to the 3GPP specifications there is some missing points in the =
SATK DisplayText implementation and I want to propose some API changes here.
> =

> 1. clear message after delay / wait for user to clear flag
> =

> This flag corresponds to the bit 8 of the command qualifier (see ETSI TS =
102 223) and indicates how the message should be cleared by the UI.
> In the STK agent documentation it's indicated that this flag is handled u=
sing different timeout value for the Agent DisplayText method call. But tha=
t doesn't seem the case in the code: there is no check of the flag.

Andrew has to answer this one, it seems like there's a disconnect
between the implementation and the docs.  Probably just a bug.

> =

> For me it's to the UI to handle the way how the message must be cleared a=
nd not to ofono. With the current Agent DisplayText method API this is not =
possible as there is no indication if the message must be cleared after a d=
elay or after a user action. So I want to propose the following change for =
the STK Agent:
> =

> Change    void DisplayText(string text, byte icon_id, boolean urgent)
> By        void DisplayText(string text, byte icon_id, boolean urgent, boo=
lean clear_after_delay)
> =

> Where clear_after_delay boolean must be set to '1' for the clear message =
after delay case and to '0' for the wait for user to clear case.

Actually I really don't want to make this distinction.  The UI should
always give the user the option to clear the message.  So just
increasing the timeout when wait_for_user flag is set seems enough to me.

> =

> 2. Busy screen
> =

> The other missing point in the DisplayText implementation is the case of =
the busy screen.
> According to the sequence 1.2 of the ETSI TS 102 384 we must return a ter=
minal response with the error "screen busy" when the ME is not in the idle =
screen and if the text message is not urgent. In the current implementation=
 there is no way to return this type of error in the terminal response.
> =

> I propose to add a new error code ScreenBusy in the same way of what it's=
 done for GoBack and EndSession event.

I can be convinced that this is a good idea.  However, in 99% of the
cases the STK session is started by the user, so the screen should never
be 'busy'.

Andrew, what do you think?

Regards,
-Denis

--===============6975915022160384727==--

