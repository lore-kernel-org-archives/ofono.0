Content-Type: multipart/mixed; boundary="===============4902211870485047756=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: [PATCH 1/6] gprs-provision: add driver API header
Date: Mon, 24 Jan 2011 12:16:17 +0200
Message-ID: <AANLkTin89+SgEqw1PsPnvw2ASyNTORB23uMX6CcC91np@mail.gmail.com>
In-Reply-To: <1295853054.2182.43.camel@jsaunama-desktop>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4902211870485047756==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jukka,

2011/1/24 Jukka Saunamaki <jukka.saunamaki@nokia.com>:
> Then how about something like this: Lets make provisioning API
> synchronous (so that plugins do not need to care about SIM or other
> safety).
> In stead, if in gprs atom ofono_gprs_register() we notice the need for
> provisioning, =C2=A0ofono_sim_read(SPN) is called there. All issues would=
 be
> localised there. Provisioning modules would be called with MCC,MNC,SPN
> as parameters.

I think this is a better approach. It would reduce the role of the
provisioning plugins to database abstraction only, which is
essentially what they are.

I think the provisioning atom/plugins also should not be modem
specific, but just created once for all modems to use.

Cheers,
Aki

--===============4902211870485047756==--

