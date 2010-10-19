Content-Type: multipart/mixed; boundary="===============1587020601933330125=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [RFC sim-ready-v1 PATCH 0/3] ofono_sim_ready_notify
Date: Tue, 19 Oct 2010 11:43:35 +0200
Message-ID: <1287481415.3316.138.camel@aeonflux>
In-Reply-To: <1287416435-4307-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1587020601933330125==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

> Here is my 2nd stab at the ofono_sim_ready_notify().
> =

> Main difference from Denis's and Kristen's patch is that the modem
> driver now has a way to indicate that is ready or not: if SIM is not
> ready, the ofono_sim_driver indicates that with query_passwd_state
> callback returning OFONO_SIM_PASSWORD_INVALID. A separate enum and a
> string value for PinRequired property for that case would probably be
> nice, however, it is not very clear to me how the modems handle the
> transition from PIN-locked SIM to SIM-locked modem.
> =

> After the driver determines that the SIM is ready, it calls
> ofono_sim_ready_notify().
> =

> The patches has now been tested with the PIN and PUK codes with mbm and
> the new isimodem sim driver by Jukka Saunamaki. IFX seems to be
> identical in PIN and PUK cases, too.
> =

> The isimodem driver demonstrates also the case where PIN is disabled but
> SIM is not ready yet when oFono tries to initialize the modem. The
> isimodem driver tries to read some CPHS information in order to
> determine if the modem is ready. I'm not sure how that kind of probing
> should be implemented in atmodem driver.

so how do we handle AT command based modems that have no extra
indication of SIM ready state? Are we stuck with quirks in the atmodem
SIM driver or can we push these into the modem plugins?

Regards

Marcel



--===============1587020601933330125==--

