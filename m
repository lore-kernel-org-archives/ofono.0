Content-Type: multipart/mixed; boundary="===============0013309599601759162=="
MIME-Version: 1.0
From: Jukka Saunamaki <jukka.saunamaki@nokia.com>
Subject: Re: [RFC PATCH 4/4] Dummy example GPRS context provisioning driver
Date: Wed, 12 Jan 2011 09:41:02 +0200
Message-ID: <1294818062.24900.21.camel@jsaunama-desktop>
In-Reply-To: <1294814934.3873.73.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0013309599601759162==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello

On Tue, 2011-01-11 at 22:48 -0800, ext Marcel Holtmann wrote:
> > +	if (sim !=3D NULL) {
> > +		ofono_sim_read(sim, SIM_EFSPN_FILEID,
> > +				OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
> > +				sim_spn_read_cb, req);
> > +		return;
> > +	}
> =

> Should this not be provided somehow by the SIM atom?
> =

> Denis, any idea why we are not keeping this information available?
> =


I would guess there was no need for it, since netreg was the only user
for EFSPN data.

I though of patching the SIM atom to read this during some phase of SIM
initialization, but was not sure exactly when, and what kind of
interface (syncronous, asyncronous?) to provide.

--Jukka



--===============0013309599601759162==--

