Content-Type: multipart/mixed; boundary="===============7006663987680992795=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: Re: RFC: API for Neighbouring Cell Info
Date: Fri, 29 Jan 2010 10:04:10 +0200
Message-ID: <1264752250.19283.773.camel@phoenix.elisa-laajakaista.fi>
In-Reply-To: <97D5E1BB8FC13D4EA3B34BAE8E6898C9BACB181B@orsmsx508.amr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7006663987680992795==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

to, 2010-01-28 kello 19:03 +0100, ext Bastian, Waldo kirjoitti:
> I would like to propose an API for exposing neighbouring cell info. =

> Since the exact information provided is rather modem specific my
> thinking is to use the following API as the generic framework and then
> the actual per-cell information attributes that a driver provides can
> be different from modem to modem with the constraint that _if_ a modem
> provides a certain attribute that is specified by this API definition
> the driver must format it as specified.

There are two parts to neighbor cell information. The first part
provides meta-information on the second part, which is the actual
measurement data.

Like you propose, the first part is a dict, with keys like cell type and
current MCC and MNC.

The second part is the measurement data, and that is different for
different types of cells. Not all information is mandatory for all
modems and all cell types.

For the measurement data, there is a standard available. OMA SUPL, User
Plane Location Protocol describes the sets of measurements available for
different types of cells:

http://www.openmobilealliance.org/Technical/release_program/supl_v2_0.aspx

> Your feedback is highly appreciated, especially from those who plan to
> use this information for location purposes.

I think the pattern you use here is wrong. This needs to be a method
call; a signal won't work. The measurement data is constantly changing,
and you don't want a constant stream of PropertyChanged() signals.

So I think something like this instead:

GetNeighborCells() -> a{sv}, aa{sv}

That is: a dict for the meta-data, and an array of dicts for cell
measurements. That response signature looks a bit intimidating, but I've
implemented it, it's not a big deal.

The important property here is that the location system has a single
method call that retrieves all relevant information from the modem, so
that they can then do their triangulation magic.

> Once there is agreement on the API we can discuss whether it makes
> sense to add some skeleton support in the oFono core or leave it to
> each individual modem plugin to implement the DBUS service in its
> entire.

I think it's reasonable to assume that most modems support this. There
is a standard to follow, and at least isimodem will have a driver for
it. So I would make it a proper atom from the beginning.

The modem plugin API should distinguish between different types of
cells; there should be ops to retrieve cell type specific measurements.

Other comments on the interface:

> Properties boolean Enabled [readwrite] =

> =

> 			Boolean representing whether the interface provides
> 			neighbouring cell information.
> =


This is useless. If a modem driver doesn't support neighbor cell info,
it won't registered a driver and the interface just doesn't show up.

> 			int8 RSCP [readonly, UMTS only]
> =

> 				Received Signal Code Power [3GPP TS 25.133 s9.1.1.3] in dBm [-120...-=
25]
> =

> 			int8 ECNO [readonly, UMTS only]
> =

> 				CPICH Ec/No [3GPP TS 25.133 s9.1.2.3] in dB  [-24...0]

This is already part of the measurement data, which I think should be in
the per-cell information (the serving cell measurement data is still
measurement data).

Cheers,
Aki


--===============7006663987680992795==--

