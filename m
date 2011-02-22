Content-Type: multipart/mixed; boundary="===============5990831380725128194=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC] doc: Add support for CMAS/EU-Alert
Date: Tue, 22 Feb 2011 11:29:46 -0600
Message-ID: <4D63F28A.4030902@gmail.com>
In-Reply-To: <B668883EB5DD7144ADFC248A72176EA802E31446@fioues07.ebgroup.elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5990831380725128194==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jeeva,

On 02/21/2011 11:36 PM, Jeevaka.Badrappan(a)elektrobit.com wrote:
> Hi Rajesh,
> =

> ofono-bounces(a)ofono.org wrote:
>> Hi Jeeva,
>>
>> Is this WarningType really required on the App side ?
>> Irrespective of the warning type, the emergency broadcast
>> message handling won't change on the apps side (i.e, its
>> going to be displayed immediately to the user). This can be
>> achieved by the old boolean variable EmergencyAlert only ?
>>
> =

> Its Popup property which is used for displaying the
> messages immediately to the user. EmergencyAlert Property
> is used to hint whether an emergency indicator(Vibration, emergency
> tone)
> should be activated.
> =

> Yes, agree that the WarningType is not really required. =

> May be it was there for some reason. This RFC patch just extends
> the existing EmergencyType property.

Lets just get rid of it then and keep the name EmergencyAlert.  Do we
want to re-model this using an Agent style API by any chance?

Regards,
-Denis

--===============5990831380725128194==--

