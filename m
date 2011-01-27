Content-Type: multipart/mixed; boundary="===============4932453590100173505=="
MIME-Version: 1.0
From: Jukka Saunamaki <jukka.saunamaki@nokia.com>
Subject: Re: [PATCH 1/3] sim: add ofono_sim_get_spn API header
Date: Thu, 27 Jan 2011 16:04:42 +0200
Message-ID: <1296137082.30517.46.camel@jsaunama-desktop>
In-Reply-To: <1296136583.1520.155.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4932453590100173505==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi

On Thu, 2011-01-27 at 14:56 +0100, ext Marcel Holtmann wrote:
> > +const char *ofono_sim_get_spn(struct ofono_sim *sim);
> > +unsigned char ofono_sim_get_spn_dc(struct ofono_sim *sim);
> =

> what is the spn_dc for? We are converting everything into UTF-8 anyway
> and that should be sufficient.

That is "Display Condition" byte of EF-SPN. Needed by netreg. Perhaps
better name would have been spn_flags.

--Jukka



--===============4932453590100173505==--

