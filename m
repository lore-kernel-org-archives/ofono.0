Content-Type: multipart/mixed; boundary="===============5211731399501517603=="
MIME-Version: 1.0
From: Simon LETHBRIDGE <simon.lethbridge@stericsson.com>
Subject: RE: [PATCH] doc: Add Location Services API (resending now that I am
 on ofono mailing list)
Date: Thu, 18 Nov 2010 10:50:06 +0100
Message-ID: <B4268AAFAFA3E244B5B0641D5914917048B76BEA90@EXDCVYMBSTM006.EQ1STM.local>
In-Reply-To: <4CDC6501.3070206@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5211731399501517603==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> -----Original Message-----
> From: Denis Kenzior [mailto:denkenz(a)gmail.com]
> Sent: 11 November 2010 21:50
> To: ofono(a)ofono.org
> Cc: Sjur Br=C3=A6ndeland; Simon LETHBRIDGE; Sjur BRENDELAND
> Subject: Re: [PATCH] doc: Add Location Services API
 =


> =

> So let me summarize 27.007 briefly.  It defines the following elements =

> for +CPOS/+CPOSR:
> =

> - location
> - assist_data
> - pos_meas
> - GPS_meas
> - GPS_assist_req
> - msg
> - pos_err
> =

> So from my understanding +CPOS command can be used to send <location>, =

> <GPS_assist_req> and <pos_err> elements.
> =

> And +CPOSR can transfer the following elements from the network:
> <assist_data>, <pos_meas>, <msg>.
> =

> Am I right so far?

This is substantially correct, however the assistance data request can only=
 be made in response to a positioning request from the network.  If assista=
nce is required otherwise then an MOLR is needed, which we don't support ye=
t. =


> =

> Where does the <GPS_meas> element fall into?

There are two types of procedure "MSB" where the location is calculated in =
the mobile, and "MSA" where it is calculated in the network.  For MSA code =
phase measurements and doppler are sent to the network.  One possible benef=
it of MSA procedures is that less assistance data needs to be transferred. =

> =

> What about other location services related commands defined in 27.007?
> How do they fit in? E.g.:
> - +CMOLR
> - +CMTLR
> - +CMTLRA
These are not required for NILR (Network Initiated - Location Requests) pro=
cedures (e.g. E911 procedures).  However it could be useful to add support =
later.

The current proposal only supports NILR.

Regards,

Simon


> -----Original Message-----
> From: Denis Kenzior [mailto:denkenz(a)gmail.com]
> Sent: 11 November 2010 21:50
> To: ofono(a)ofono.org
> Cc: Sjur Br=C3=A6ndeland; Simon LETHBRIDGE; Sjur BRENDELAND
> Subject: Re: [PATCH] doc: Add Location Services API
> =

> Hi Sjur and Simon,
> =

> On 11/11/2010 01:44 PM, Sjur Br=C3=A6ndeland wrote:
> > From: Sjur Br=C3=A6ndeland <sjur.brandeland@stericsson.com>
> >
> > As requested, this is our initial proposal for a minimal API
> > in order to support E911, based on the 27.007 defined AT
> > commands.
> >
> > We've discussed internally different names for this API:
> > AGNSSManager or AssistedGlobalNavigationSatelliteSystem,
> > but ended up with the simpler LocationServicesManager.
> >
> > Looking forward to your comments on this API.
> >
> > Regards,
> > Simon Lethbridge and
> > Sjur Br=C3=A6ndeland
> > ---
> >  doc/location-services-api.txt |   56
> +++++++++++++++++++++++++++++++++++++++++
> >  1 files changed, 56 insertions(+), 0 deletions(-)
> >  create mode 100644 doc/location-services-api.txt
> >
> > diff --git a/doc/location-services-api.txt b/doc/location-services-
> api.txt
> > new file mode 100644
> > index 0000000..18ef230
> > --- /dev/null
> > +++ b/doc/location-services-api.txt
> > @@ -0,0 +1,56 @@
> > +LocationServicesManager hierarchy
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +Service	org.ofono
> > +Interface	org.ofono.LocationServicesManager
> =

> I actually think LocationServices is enough..
> =

> So let me summarize 27.007 briefly.  It defines the following elements
> for +CPOS/+CPOSR:
> =

> - location
> - assist_data
> - pos_meas
> - GPS_meas
> - GPS_assist_req
> - msg
> - pos_err
> =

> So from my understanding +CPOS command can be used to send <location>,
> <GPS_assist_req> and <pos_err> elements.
> =

> And +CPOSR can transfer the following elements from the network:
> <assist_data>, <pos_meas>, <msg>.
> =

> Am I right so far?
> =

> Where does the <GPS_meas> element fall into?
> =

> > +Object path	[variable prefix]/{modem0,modem1,...}
> > +
> > +Methods	dict GetProperties()
> > +
> > +			Returns properties for the modem object. See
> > +			the properties section for available properties.
> > +
> > +			Possible Errors: [service].Error.InvalidArguments
> > +
> > +		void SetProperty(string name, variant value)
> > +
> > +			Changes the value of the specified property. Only
> > +			properties that are listed as read-write are
> > +			changeable. On success a PropertyChanged signal
> > +			will be emitted.
> > +
> > +			Possible Errors: [service].Error.InvalidArguments
> > +					 [service].Error.DoesNotExist
> =

> I think we can get rid of the above two methods, see below...
> =

> > +
> > +		void SendPositioningControl(string xml_element)
> > +
> > +			Send an XML element conforming to the XML DTD for
> <pos>
> > +			as defined in 3GPP 27.007 Table 8.55-2.  This xml is
> > +			used for transferring data associated with
> positioning
> > +			requests received via control plane from the network.
> > +			This includes assistance data requests and the
> results
> > +			of positioning procedures. This method maps directly
> to
> > +			the 3GPP 27.007 AT+CPOS command.
> > +
> > +
> > +Signals	PropertyChanged(string name, variant value)
> > +
> > +			This signal indicates a changed value of the given
> > +			property.
> > +
> > +		PositioningRequest(string xml_element)
> > +
> > +			Receive an XML element conforming to the XML DTD for
> > +			<pos> in 3GPP 27.007. This xml is used for
> transferring
> > +			data associated with positioning requests received,
> via
> > +			control plane, from the network. This includes
> > +			measurement requests and assistance data. This signal
> > +			maps directly to the 3GPP defined +CPOSR unsolicited
> > +			result code.
> =

> How about transforming this signal into an Agent based API instead.  So
> let us have a LocationServicesAgent API with the following rough API:
> =

> LocationServicesAgent
> =

> * Release() - Self explanatory
> * HandleRequest(string xml) - Essentially gets passed the data from the
> +CPOSR unsolicited response.
> =

> We can then add two more methods to the LocationServices interface:
> =

> * RegisterAgent()
> * UnregisterAgent()
> =

> > +
> > +Properties	boolean NetworkInitiatedProceduresEnabled [readwrite]
> > +
> > +			If NetworkInitiatedProceduresEnabled is False, then
> > +			no Position Requests from the network are accepted.
> > +			The modem is not enabled for positioning requests
> > +			from the networks view point.
> =

> This property can then be potentially made redundant.  E.g. if there's
> no agent registered, the network position requests are turned off.
> Once
> the agent is registered, they are turned on.
> =

> The SendPositioningControl function can then be tweaked to return an
> error if the Agent is not registered.  I assume there's nothing useful
> we can do without someone handling the data returned by +CPOSR.
> =

> What about other location services related commands defined in 27.007?
> How do they fit in? E.g.:
> - +CMOLR
> - +CMTLR
> - +CMTLRA
> =

> Regards,
> -Denis

--===============5211731399501517603==--

