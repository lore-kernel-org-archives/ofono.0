Content-Type: multipart/mixed; boundary="===============3618459446797467557=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Problems provisioning APN from SIMs
Date: Thu, 04 Jun 2015 14:52:08 -0500
Message-ID: <5570AC68.5000208@gmail.com>
In-Reply-To: <556EEDE9.3090904@dynamicdevices.co.uk>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3618459446797467557==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alex,

On 06/03/2015 07:07 AM, Alex J Lennon wrote:
> Hi,
>
> A request for some advice.
>
> We're having trouble provisioning APNs for SIMs from certain Telcos, and
> it seems to be because of the ordering of providers in serviceproviders.x=
ml
>

Ordering should have nothing to do with it.

> Vodafone and O2 are cases in point. SIMs from either of those two
> telcos, used in the UK, will fail to default to the standard APNs upon
> provisioning.
>
> In the case of Vodafone it is because an ASDA Mobile provider is present
> before the Vodafone provider and both have the same MNC.
>
> It's similar with O2, excepting that in this case there's a Giffgaff
> provider before the O2 provider which thus is used for the APN.

oFono's provisioning logic is very conservative.  We do not allow =

duplicate contexts.  Thus if the database contains multiple matches for =

a MCC/MNC pair, the provisioning will fail.  The way to to deal with =

this is to extend the database with additional identifying information. =

  E.g. SPN.  I believe we added the SPN field to =

Mobile-Broadband-Provider-Info XML DTD.  But I haven't been paying much =

attention whether the database has been properly populated with this =

field since then.

>
> I suspect our use case is similar to many others. We have a headless
> embedded Linux board and we want an installation technician to be able
> to put a SIM in, power the unit, and have everything else automated.
>
> It looks like we may have to implement a custom serviceproviders.xml,
> which would be a shame.
>
> I am wondering if there are any other algorithmic or configuration
> alternatives we can look at, such as Ofono trying different contexts
> until one works? Or some additional Ofono provisioning configuration?
>

oFono can use any information present on the SIM to try and figure out =

the SIM provider.  We already provide MCC, MNC and SPN to the =

provisioning plugin.

However, this really depends on the underlying provisioning database to =

contain this information and do so in such a way that duplicates are not =

possible.

Regards,
-Denis


--===============3618459446797467557==--

