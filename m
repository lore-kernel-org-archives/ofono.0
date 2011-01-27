Content-Type: multipart/mixed; boundary="===============3252500074026646798=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: EF-SPN API (was: [gprs-provision PATCHv7 0/5] Plugin API for
 provisioning of GPRS context settings)
Date: Thu, 27 Jan 2011 08:37:17 +0100
Message-ID: <1296113837.1520.142.camel@aeonflux>
In-Reply-To: <1296112918.30517.26.camel@jsaunama-desktop>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3252500074026646798==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jukka,

> > you can have a look on what it would take to store a) read SPN in the
> > SIM atom and store it and b) let netreg atom use that value.
> =

> Simple solution for this would be something like:
> =

> During some SIM initialisation phase (at sim_ready()?), sim-atom
> requests ofono_sim_read(SIM_EFSPN_FILEID).
> =

> For netreg (and gprs/provisioning) it would provide:
> typedef void (*ofono_sim_spn_read_cb_t)(int ok, const char *spn,
> 					void *userdata);
> void ofono_sim_read_spn(struct ofono_sim *sim, ofono_sim_spn_read_cb_t cb,
> 			void *userdata);
> =

> ofono_sim_read_spn would queue requests until SPN is received (and
> immediately call callback if SPN is ready).

don't make this asynchronous. Just read the SPN and store it. Then it
can be easily accessed similar to MCC and MNC.

The GPRS atom and netreg for that matter will not be available before
the SIM atom has been fully initialized anyway.

If there is any race condition with this one, the we need to be really
really careful since it has a lot of consequences.

Regards

Marcel



--===============3252500074026646798==--

