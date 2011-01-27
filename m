Content-Type: multipart/mixed; boundary="===============2195930773909276238=="
MIME-Version: 1.0
From: Jukka Saunamaki <jukka.saunamaki@nokia.com>
Subject: EF-SPN API (was: [gprs-provision PATCHv7 0/5] Plugin API for
 provisioning of GPRS context settings)
Date: Thu, 27 Jan 2011 09:21:58 +0200
Message-ID: <1296112918.30517.26.camel@jsaunama-desktop>
In-Reply-To: <1296111563.1520.138.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2195930773909276238==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

> you can have a look on what it would take to store a) read SPN in the
> SIM atom and store it and b) let netreg atom use that value.

Simple solution for this would be something like:

During some SIM initialisation phase (at sim_ready()?), sim-atom
requests ofono_sim_read(SIM_EFSPN_FILEID).

For netreg (and gprs/provisioning) it would provide:
typedef void (*ofono_sim_spn_read_cb_t)(int ok, const char *spn,
					void *userdata);
void ofono_sim_read_spn(struct ofono_sim *sim, ofono_sim_spn_read_cb_t cb,
			void *userdata);

ofono_sim_read_spn would queue requests until SPN is received (and
immediately call callback if SPN is ready).


But this still would be asyncronous, which causes the problem in netreg
(and gprs/provisioning). Is there any way to delay netreg initialisation
until SPN is available (and are there other SIM files netreg reads)?

--Jukka



--===============2195930773909276238==--

