Content-Type: multipart/mixed; boundary="===============0849716190855433834=="
MIME-Version: 1.0
From: Jukka Saunamaki <jukka.saunamaki@nokia.com>
Subject: Re: [PATCH 1/8] gprs-provision: add driver API header
Date: Wed, 19 Jan 2011 07:58:55 +0200
Message-ID: <1295416735.17394.4.camel@jsaunama-desktop>
In-Reply-To: <1295362115.3873.190.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0849716190855433834==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

> > +/*
> > + * Callback from provisioning plugin.
> > + * settings: list of struct ofono_gprs_provision_data
> > + *
> > + * It is responsibility of callback function to free settings-list
> > + * settings-list elements must be freed with ofono_gprs_provision_data=
_free()
> > + */
> > +typedef void (*ofono_gprs_provision_cb_t)(GSList *settings, void *user=
data);
> =

> so our general rule is no GLib types in oFono public APIs.

OK. Do you have any preferences for the best type here? Linked list of
'struct ofono_gprs_provision_data's, array of structs + count, array of
pointers (+count)?

--Jukka



--===============0849716190855433834==--

