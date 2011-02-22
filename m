Content-Type: multipart/mixed; boundary="===============8886904655628445740=="
MIME-Version: 1.0
From: Jeevaka.Badrappan@elektrobit.com
Subject: RE: [RFC] doc: Add support for CMAS/EU-Alert
Date: Tue, 22 Feb 2011 07:36:25 +0200
Message-ID: <B668883EB5DD7144ADFC248A72176EA802E31446@fioues07.ebgroup.elektrobit.com>
In-Reply-To: <C681C76E0D5F1E4BB01DE79E0A80EEC70304D53F@usrdes03.ebgroup.elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8886904655628445740==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Rajesh,

ofono-bounces(a)ofono.org wrote:
> Hi Jeeva,
> =

> Is this WarningType really required on the App side ?
> Irrespective of the warning type, the emergency broadcast
> message handling won't change on the apps side (i.e, its
> going to be displayed immediately to the user). This can be
> achieved by the old boolean variable EmergencyAlert only ?
> =


Its Popup property which is used for displaying the
messages immediately to the user. EmergencyAlert Property
is used to hint whether an emergency indicator(Vibration, emergency
tone)
should be activated.

Yes, agree that the WarningType is not really required. =

May be it was there for some reason. This RFC patch just extends
the existing EmergencyType property.

Regards,
Jeevaka=20

--===============8886904655628445740==--

