Content-Type: multipart/mixed; boundary="===============3842699272086080473=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] Set session state to RESPONSE_SENT after sending response.
Date: Sat, 27 Feb 2010 11:40:07 -0600
Message-ID: <201002271140.07489.denkenz@gmail.com>
In-Reply-To: <1267417768-16937-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3842699272086080473==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

Good catch, patch has been applied.

> Hi Denis,
> I am not entirely sure this new state is needed though.  As the commit sa=
ys
> the network may continue the dialog but it is not obliged to send any kind

The state is actually meant to un-confuse the USSD_STATE_ACTIVE if clause i=
n =

ofono_ussd_notify.  Otherwise we treat it exactly like USSD_STATE_ACTIVE.

> of response to our reponse, at least this is not in the specs.  So if it
> doesn't send anything (neither a notification nor request) we will remain
> in this state and user will not be able to Initiate a new session for that

In theory the modem should time out the USSD request and send us a notifica=
tion =

regardless.  I'm afraid we have to rely on the modem for this one, since th=
e =

modem would refuse to send USSDs if a session is active anyway.

> time.  The other option, if I misunderstood the spec, would be to make the
> Respond method return the string.

I'm actually open to the idea, the reason 'Initiate' returns a string is th=
at =

95% of the time there is no dialog, just straight request -> response.

Regards,
-Denis

--===============3842699272086080473==--

