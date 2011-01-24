Content-Type: multipart/mixed; boundary="===============7574351664118609813=="
MIME-Version: 1.0
From: Jukka Saunamaki <jukka.saunamaki@nokia.com>
Subject: Re: [PATCH 1/6] gprs-provision: add driver API header
Date: Mon, 24 Jan 2011 09:10:54 +0200
Message-ID: <1295853054.2182.43.camel@jsaunama-desktop>
In-Reply-To: <4D39C5F8.4040004@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7574351664118609813==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Fri, 2011-01-21 at 11:44 -0600, Denis Kenzior wrote:
> > The reason for asyncronous API is still that SPN value reading from SIM.
> > Is there any way to make sure it is available synchronously when
> > provisioning is run?
> =

> Not really. So you're introducing a boatload of extra complexity just
> because of the need for EFspn?  Are you 100% sure that you really need
> this?  Can some of these corner cases be covered differently?

As I have said, there are MVNOs (I checked, all of them do not have
their own MNC) and operator brand names that use different APN settings
from their host operator. To tell these cases apart in provisioning, we
need SPN. =


> > And what do you mean with it being impossible to support multiple
> > provisioning plugins properly? Plugins are run one after another until
> > first returns something.
> > Race conditions I tried to address in gprs, so if gprs atom goes away
> > while provisioning is running nothing bad should happen. But sure, there
> > might something else, and hopefully someone could point them.
> =

> How exactly are you guaranteeing that 'nothing bad should happen'?
> There is no cancellation mechanism that I see.  Not to mention that the
> current ofono_sim_read API is not even safe either.  For exactly the
> same reasons.

No, I am not so familiar with the whole code that I could guarantee
that. So, I am asking for help there.

You say ofono_sim_read is not safe, but in what sense? Is it possible
that it never calls the callback?

Then how about something like this: Lets make provisioning API
synchronous (so that plugins do not need to care about SIM or other
safety).
In stead, if in gprs atom ofono_gprs_register() we notice the need for
provisioning,  ofono_sim_read(SPN) is called there. All issues would be
localised there. Provisioning modules would be called with MCC,MNC,SPN
as parameters. =


Any other solutions, anyone?

--Jukka



--===============7574351664118609813==--

