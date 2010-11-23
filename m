Content-Type: multipart/mixed; boundary="===============1855402410131350120=="
MIME-Version: 1.0
From: Lucas, GuillaumeX <guillaumex.lucas@intel.com>
Subject: STK DisplayText changes proposal
Date: Tue, 23 Nov 2010 15:33:58 +0000
Message-ID: <9F3EABD6E3419B4C81F34EAABB4D4018813542BD15@irsmsx501.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1855402410131350120==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

According to the 3GPP specifications there is some missing points in the SA=
TK DisplayText implementation and I want to propose some API changes here.

1. clear message after delay / wait for user to clear flag

This flag corresponds to the bit 8 of the command qualifier (see ETSI TS 10=
2 223) and indicates how the message should be cleared by the UI.
In the STK agent documentation it's indicated that this flag is handled usi=
ng different timeout value for the Agent DisplayText method call. But that =
doesn't seem the case in the code: there is no check of the flag.

For me it's to the UI to handle the way how the message must be cleared and=
 not to ofono. With the current Agent DisplayText method API this is not po=
ssible as there is no indication if the message must be cleared after a del=
ay or after a user action. So I want to propose the following change for th=
e STK Agent:

Change    void DisplayText(string text, byte icon_id, boolean urgent)
By        void DisplayText(string text, byte icon_id, boolean urgent, boole=
an clear_after_delay)

Where clear_after_delay boolean must be set to '1' for the clear message af=
ter delay case and to '0' for the wait for user to clear case.

2. Busy screen

The other missing point in the DisplayText implementation is the case of th=
e busy screen.
According to the sequence 1.2 of the ETSI TS 102 384 we must return a termi=
nal response with the error "screen busy" when the ME is not in the idle sc=
reen and if the text message is not urgent. In the current implementation t=
here is no way to return this type of error in the terminal response.

I propose to add a new error code ScreenBusy in the same way of what it's d=
one for GoBack and EndSession event.

Please let me know if you agree with it.

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


--===============1855402410131350120==--

