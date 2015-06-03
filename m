Content-Type: multipart/mixed; boundary="===============7801813149744105286=="
MIME-Version: 1.0
From: Alex J Lennon <ajlennon@dynamicdevices.co.uk>
Subject: Problems provisioning APN from SIMs
Date: Wed, 03 Jun 2015 14:07:05 +0200
Message-ID: <556EEDE9.3090904@dynamicdevices.co.uk>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7801813149744105286==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

A request for some advice.

We're having trouble provisioning APNs for SIMs from certain Telcos, and
it seems to be because of the ordering of providers in serviceproviders.xml

Vodafone and O2 are cases in point. SIMs from either of those two
telcos, used in the UK, will fail to default to the standard APNs upon
provisioning.

In the case of Vodafone it is because an ASDA Mobile provider is present
before the Vodafone provider and both have the same MNC.

It's similar with O2, excepting that in this case there's a Giffgaff
provider before the O2 provider which thus is used for the APN.

I suspect our use case is similar to many others. We have a headless
embedded Linux board and we want an installation technician to be able
to put a SIM in, power the unit, and have everything else automated.

It looks like we may have to implement a custom serviceproviders.xml,
which would be a shame.

I am wondering if there are any other algorithmic or configuration
alternatives we can look at, such as Ofono trying different contexts
until one works? Or some additional Ofono provisioning configuration?

Thanks,

Alex

--===============7801813149744105286==--

